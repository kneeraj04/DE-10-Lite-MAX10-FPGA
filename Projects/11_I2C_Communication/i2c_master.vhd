library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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
        SEND_ADDRESS,
        ADDRESS_ACK,
        SEND_DATA,
        DATA_ACK,
        STOP_BIT,
        FINISH
    );

    signal state : state_type := IDLE;

    signal clk_count : integer range 0 to CLK_DIV-1 := 0;

    signal scl_int : std_logic := '1';
    signal sda_int : std_logic := 'Z';

    signal address_reg : std_logic_vector(7 downto 0);
    signal data_reg    : std_logic_vector(7 downto 0);

    signal bit_count : integer range 0 to 7 := 7;

begin

    scl <= scl_int;

    -- I2C open-drain SDA
    -- 0 = pull LOW
    -- Z = release line
    sda <= sda_int;

    busy <= '1' when state /= IDLE else '0';

    done <= '1' when state = FINISH else '0';


    process(clk, reset)

    begin

        if reset = '1' then

            state       <= IDLE;

            clk_count   <= 0;

            scl_int     <= '1';
            sda_int     <= 'Z';

            address_reg <= (others => '0');
            data_reg    <= (others => '0');

            bit_count   <= 7;


        elsif rising_edge(clk) then

            case state is


                ----------------------------------------------------
                -- IDLE
                ----------------------------------------------------

                when IDLE =>

                    scl_int   <= '1';
                    sda_int   <= 'Z';
                    clk_count <= 0;

                    if start = '1' then

                        address_reg <= slave_addr & '0';
                        data_reg    <= data_in;

                        bit_count <= 7;

                        state <= START_BIT;

                    end if;


                ----------------------------------------------------
                -- START
                ----------------------------------------------------

                when START_BIT =>

                    -- SCL HIGH
                    scl_int <= '1';

                    -- SDA HIGH -> LOW
                    sda_int <= '0';

                    clk_count <= 0;

                    state <= SEND_ADDRESS;


                ----------------------------------------------------
                -- SEND ADDRESS
                ----------------------------------------------------

                when SEND_ADDRESS =>

                    if clk_count = CLK_DIV-1 then

                        clk_count <= 0;

                        if scl_int = '1' then

                            -- Falling edge
                            scl_int <= '0';

                        else

                            -- Rising edge
                            scl_int <= '1';

                            if bit_count = 0 then

                                state <= ADDRESS_ACK;

                            else

                                bit_count <= bit_count - 1;

                            end if;

                        end if;


                    else

                        clk_count <= clk_count + 1;

                    end if;


                    -- Change SDA only while SCL is LOW
                    if scl_int = '0' then

                        sda_int <= address_reg(bit_count);

                    end if;


                ----------------------------------------------------
                -- ADDRESS ACK
                ----------------------------------------------------

                when ADDRESS_ACK =>

                    -- Release SDA
                    sda_int <= 'Z';

                    if clk_count = CLK_DIV-1 then

                        clk_count <= 0;

                        if scl_int = '0' then

                            scl_int <= '1';

                        else

                            scl_int <= '0';

                            bit_count <= 7;

                            state <= SEND_DATA;

                        end if;

                    else

                        clk_count <= clk_count + 1;

                    end if;


                ----------------------------------------------------
                -- SEND DATA
                ----------------------------------------------------

                when SEND_DATA =>

                    if clk_count = CLK_DIV-1 then

                        clk_count <= 0;

                        if scl_int = '1' then

                            scl_int <= '0';

                        else

                            scl_int <= '1';

                            if bit_count = 0 then

                                state <= DATA_ACK;

                            else

                                bit_count <= bit_count - 1;

                            end if;

                        end if;

                    else

                        clk_count <= clk_count + 1;

                    end if;


                    -- Change SDA only while SCL is LOW
                    if scl_int = '0' then

                        sda_int <= data_reg(bit_count);

                    end if;


                ----------------------------------------------------
                -- DATA ACK
                ----------------------------------------------------

                when DATA_ACK =>

                    -- Release SDA
                    sda_int <= 'Z';

                    if clk_count = CLK_DIV-1 then

                        clk_count <= 0;

                        if scl_int = '0' then

                            scl_int <= '1';

                        else

                            scl_int <= '0';

                            state <= STOP_BIT;

                        end if;

                    else

                        clk_count <= clk_count + 1;

                    end if;


                ----------------------------------------------------
                -- STOP
                ----------------------------------------------------

                when STOP_BIT =>

                    -- SCL HIGH
                    scl_int <= '1';

                    -- Release SDA
                    sda_int <= 'Z';

                    state <= FINISH;


                ----------------------------------------------------
                -- FINISH
                ----------------------------------------------------

                when FINISH =>

                    scl_int <= '1';
                    sda_int <= 'Z';

                    state <= IDLE;


            end case;

        end if;

    end process;

end behavioral;