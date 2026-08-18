library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity i2c_master is
    port (
        clk       : in  std_logic;
        reset     : in  std_logic;
        start     : in  std_logic;

        scl       : out std_logic;
        sda       : inout std_logic;

        busy      : out std_logic;
        done      : out std_logic
    );
end i2c_master;


architecture Behavioral of i2c_master is

    type state_type is (
        IDLE,
        START_CONDITION,

        SEND_ADDRESS,
        ADDRESS_ACK,

        SEND_DATA,
        DATA_ACK,

        STOP_CONDITION,
        DONE_STATE
    );

    signal state : state_type := IDLE;

    signal scl_reg : std_logic := '1';

    signal sda_out : std_logic := '1';
    signal sda_oe  : std_logic := '0';

    signal bit_count : integer range 0 to 7 := 7;

    signal address_data : std_logic_vector(7 downto 0)
        := "10100000";

    signal data_data : std_logic_vector(7 downto 0)
        := "10101010";

    signal counter : integer range 0 to 2 := 0;

begin

    scl <= scl_reg;

    -- Drive SDA only when sda_oe = 1
    -- Otherwise release the SDA line.
    sda <= sda_out when sda_oe = '1' else 'Z';


    process(clk, reset)
    begin

        if reset = '1' then

            state     <= IDLE;
            scl_reg   <= '1';

            sda_out   <= '1';
            sda_oe    <= '0';

            bit_count <= 7;
            counter   <= 0;

            busy      <= '0';
            done      <= '0';

        elsif rising_edge(clk) then

            case state is

                ------------------------------------------------
                -- IDLE
                ------------------------------------------------

                when IDLE =>

                    scl_reg <= '1';

                    sda_oe <= '0';

                    busy <= '0';
                    done <= '0';

                    if start = '1' then

                        busy <= '1';

                        state <= START_CONDITION;

                    end if;


                ------------------------------------------------
                -- START
                ------------------------------------------------

                when START_CONDITION =>

                    -- SDA goes LOW while SCL is HIGH

                    scl_reg <= '1';

                    sda_out <= '0';
                    sda_oe  <= '1';

                    bit_count <= 7;

                    state <= SEND_ADDRESS;


                ------------------------------------------------
                -- SEND ADDRESS
                ------------------------------------------------

                when SEND_ADDRESS =>

                    busy <= '1';

                    if counter = 0 then

                        -- Put address bit on SDA

                        sda_out <= address_data(bit_count);
                        sda_oe  <= '1';

                        scl_reg <= '0';

                        counter <= 1;

                    elsif counter = 1 then

                        -- Clock HIGH

                        scl_reg <= '1';

                        counter <= 2;

                    else

                        -- Clock LOW

                        scl_reg <= '0';

                        counter <= 0;

                        if bit_count = 0 then

                            state <= ADDRESS_ACK;

                        else

                            bit_count <= bit_count - 1;

                        end if;

                    end if;


                ------------------------------------------------
                -- ADDRESS ACK
                ------------------------------------------------

                when ADDRESS_ACK =>

                    -- Master releases SDA

                    sda_oe <= '0';

                    scl_reg <= '0';

                    if counter = 0 then

                        counter <= 1;

                    elsif counter = 1 then

                        -- Slave should pull SDA LOW

                        scl_reg <= '1';

                        counter <= 2;

                    else

                        -- Finish ACK clock

                        scl_reg <= '0';

                        counter <= 0;

                        bit_count <= 7;

                        state <= SEND_DATA;

                    end if;


                ------------------------------------------------
                -- SEND DATA
                ------------------------------------------------

                when SEND_DATA =>

                    busy <= '1';

                    if counter = 0 then

                        sda_out <= data_data(bit_count);
                        sda_oe  <= '1';

                        scl_reg <= '0';

                        counter <= 1;

                    elsif counter = 1 then

                        scl_reg <= '1';

                        counter <= 2;

                    else

                        scl_reg <= '0';

                        counter <= 0;

                        if bit_count = 0 then

                            state <= DATA_ACK;

                        else

                            bit_count <= bit_count - 1;

                        end if;

                    end if;


                ------------------------------------------------
                -- DATA ACK
                ------------------------------------------------

                when DATA_ACK =>

                    -- Release SDA

                    sda_oe <= '0';

                    scl_reg <= '0';

                    if counter = 0 then

                        counter <= 1;

                    elsif counter = 1 then

                        scl_reg <= '1';

                        counter <= 2;

                    else

                        scl_reg <= '0';

                        counter <= 0;

                        state <= STOP_CONDITION;

                    end if;


                ------------------------------------------------
                -- STOP
                ------------------------------------------------

                when STOP_CONDITION =>

                    sda_out <= '0';
                    sda_oe  <= '1';

                    scl_reg <= '1';

                    -- SDA LOW -> HIGH while SCL HIGH

                    sda_out <= '1';

                    state <= DONE_STATE;


                ------------------------------------------------
                -- DONE
                ------------------------------------------------

                when DONE_STATE =>

                    sda_oe <= '0';

                    busy <= '0';
                    done <= '1';

                    state <= IDLE;

            end case;

        end if;

    end process;

end Behavioral;