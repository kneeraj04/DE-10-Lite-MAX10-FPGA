library ieee;
use ieee.std_logic_1164.all;

entity i2c_master is
    generic (
        CLK_DIV : integer := 2
    );

    port (
        clk        : in    std_logic;
        reset      : in    std_logic;
        start      : in    std_logic;

        slave_addr : in    std_logic_vector(6 downto 0);
        data_in    : in    std_logic_vector(7 downto 0);

        scl        : out   std_logic;
        sda        : inout std_logic;

        busy       : out   std_logic;
        done       : out   std_logic
    );
end i2c_master;


architecture behavioral of i2c_master is

    type state_type is (
        IDLE,
        START_BIT,

        ADDR_LOW,
        ADDR_HIGH,

        ADDR_ACK_LOW,
        ADDR_ACK_HIGH,

        DATA_LOW,
        DATA_HIGH,

        DATA_ACK_LOW,
        DATA_ACK_HIGH,

        STOP_LOW,
        STOP_HIGH,

        FINISH
    );

    signal state : state_type := IDLE;

    signal count : integer range 0 to CLK_DIV-1 := 0;

    signal scl_reg : std_logic := '1';
    signal sda_reg : std_logic := 'Z';

    signal address_reg : std_logic_vector(7 downto 0);
    signal data_reg    : std_logic_vector(7 downto 0);

    signal bit_index : integer range 0 to 7 := 7;

begin

    scl <= scl_reg;

    -- Open-drain SDA
    -- 0 = pull LOW
    -- Z = release
    sda <= sda_reg;

    busy <= '1' when state /= IDLE else '0';

    done <= '1' when state = FINISH else '0';


    process(clk, reset)

    begin

        if reset = '1' then

            state       <= IDLE;

            count       <= 0;

            scl_reg     <= '1';
            sda_reg     <= 'Z';

            address_reg <= (others => '0');
            data_reg    <= (others => '0');

            bit_index   <= 7;


        elsif rising_edge(clk) then

            case state is


                ----------------------------------------------------
                -- IDLE
                ----------------------------------------------------

                when IDLE =>

                    scl_reg <= '1';
                    sda_reg <= 'Z';

                    count <= 0;

                    if start = '1' then

                        address_reg <= slave_addr & '0';
                        data_reg    <= data_in;

                        bit_index <= 7;

                        state <= START_BIT;

                    end if;


                ----------------------------------------------------
                -- START
                ----------------------------------------------------

                when START_BIT =>

                    scl_reg <= '1';
                    sda_reg <= '0';

                    count <= 0;

                    state <= ADDR_LOW;


                ----------------------------------------------------
                -- ADDRESS LOW
                ----------------------------------------------------

                when ADDR_LOW =>

                    scl_reg <= '0';

                    sda_reg <= address_reg(bit_index);

                    if count = CLK_DIV-1 then

                        count <= 0;

                        state <= ADDR_HIGH;

                    else

                        count <= count + 1;

                    end if;


                ----------------------------------------------------
                -- ADDRESS HIGH
                ----------------------------------------------------

                when ADDR_HIGH =>

                    scl_reg <= '1';

                    if count = CLK_DIV-1 then

                        count <= 0;

                        if bit_index = 0 then

                            state <= ADDR_ACK_LOW;

                        else

                            bit_index <= bit_index - 1;

                            state <= ADDR_LOW;

                        end if;

                    else

                        count <= count + 1;

                    end if;


                ----------------------------------------------------
                -- ADDRESS ACK LOW
                ----------------------------------------------------

                when ADDR_ACK_LOW =>

                    scl_reg <= '0';

                    sda_reg <= 'Z';

                    if count = CLK_DIV-1 then

                        count <= 0;

                        state <= ADDR_ACK_HIGH;

                    else

                        count <= count + 1;

                    end if;


                ----------------------------------------------------
                -- ADDRESS ACK HIGH
                ----------------------------------------------------

                when ADDR_ACK_HIGH =>

                    scl_reg <= '1';

                    sda_reg <= 'Z';

                    if count = CLK_DIV-1 then

                        count <= 0;

                        bit_index <= 7;

                        state <= DATA_LOW;

                    else

                        count <= count + 1;

                    end if;


                ----------------------------------------------------
                -- DATA LOW
                ----------------------------------------------------

                when DATA_LOW =>

                    scl_reg <= '0';

                    sda_reg <= data_reg(bit_index);

                    if count = CLK_DIV-1 then

                        count <= 0;

                        state <= DATA_HIGH;

                    else

                        count <= count + 1;

                    end if;


                ----------------------------------------------------
                -- DATA HIGH
                ----------------------------------------------------

                when DATA_HIGH =>

                    scl_reg <= '1';

                    if count = CLK_DIV-1 then

                        count <= 0;

                        if bit_index = 0 then

                            state <= DATA_ACK_LOW;

                        else

                            bit_index <= bit_index - 1;

                            state <= DATA_LOW;

                        end if;

                    else

                        count <= count + 1;

                    end if;


                ----------------------------------------------------
                -- DATA ACK LOW
                ----------------------------------------------------

                when DATA_ACK_LOW =>

                    scl_reg <= '0';

                    sda_reg <= 'Z';

                    if count = CLK_DIV-1 then

                        count <= 0;

                        state <= DATA_ACK_HIGH;

                    else

                        count <= count + 1;

                    end if;


                ----------------------------------------------------
                -- DATA ACK HIGH
                ----------------------------------------------------

                when DATA_ACK_HIGH =>

                    scl_reg <= '1';

                    sda_reg <= 'Z';

                    if count = CLK_DIV-1 then

                        count <= 0;

                        state <= STOP_LOW;

                    else

                        count <= count + 1;

                    end if;


                ----------------------------------------------------
                -- STOP LOW
                ----------------------------------------------------

                when STOP_LOW =>

                    scl_reg <= '0';

                    sda_reg <= '0';

                    count <= 0;

                    state <= STOP_HIGH;


                ----------------------------------------------------
                -- STOP HIGH
                ----------------------------------------------------

                when STOP_HIGH =>

                    scl_reg <= '1';

                    sda_reg <= 'Z';

                    state <= FINISH;


                ----------------------------------------------------
                -- FINISH
                ----------------------------------------------------

                when FINISH =>

                    scl_reg <= '1';
                    sda_reg <= 'Z';

                    state <= IDLE;


            end case;

        end if;

    end process;

end behavioral;