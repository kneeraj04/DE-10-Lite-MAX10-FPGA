library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity i2c_master is
    port (
        clk          : in    std_logic;
        reset        : in    std_logic;
        start        : in    std_logic;

        scl          : inout std_logic;
        sda          : inout std_logic;

        busy         : out std_logic;
        done         : out std_logic;
        ack_address  : out std_logic;
        ack_data     : out std_logic
    );
end i2c_master;


architecture Behavioral of i2c_master is

    ----------------------------------------------------------------
    -- 50 MHz CLOCK
    -- 100 kHz I2C CLOCK
    --
    -- 5 us = 250 FPGA clock cycles
    ----------------------------------------------------------------

    constant CLK_DIV : integer := 250;

    signal clk_count : integer range 0 to CLK_DIV-1 := 0;
    signal tick      : std_logic := '0';


    ----------------------------------------------------------------
    -- I2C STATES
    ----------------------------------------------------------------

    type state_type is (

        IDLE,

        START_A,
        START_B,

        ADDRESS_SETUP,
        ADDRESS_HIGH,
        ADDRESS_LOW,

        ADDRESS_ACK_SETUP,
        ADDRESS_ACK_HIGH,
        ADDRESS_ACK_SAMPLE,
        ADDRESS_ACK_LOW,

        DATA_SETUP,
        DATA_HIGH,
        DATA_LOW,

        DATA_ACK_SETUP,
        DATA_ACK_HIGH,
        DATA_ACK_SAMPLE,
        DATA_ACK_LOW,

        STOP_A,
        STOP_B,
        STOP_C,

        DONE_STATE

    );

    signal state : state_type := IDLE;


    ----------------------------------------------------------------
    -- ADDRESS AND DATA
    ----------------------------------------------------------------

    -- 7-bit address = 1010000
    -- Write bit    = 0
    --
    -- Complete address byte:
    -- 10100000

    constant ADDRESS_BYTE : std_logic_vector(7 downto 0)
        := "10100000";


    -- Data byte

    constant DATA_BYTE : std_logic_vector(7 downto 0)
        := "10101010";


    signal bit_count : integer range 0 to 7 := 7;


    ----------------------------------------------------------------
    -- OPEN-DRAIN CONTROL
    ----------------------------------------------------------------

    signal scl_low : std_logic := '0';
    signal sda_low : std_logic := '0';


begin

    ----------------------------------------------------------------
    -- OPEN-DRAIN OUTPUTS
    ----------------------------------------------------------------

    scl <= '0' when scl_low = '1' else 'Z';

    sda <= '0' when sda_low = '1' else 'Z';


    ----------------------------------------------------------------
    -- CLOCK DIVIDER
    ----------------------------------------------------------------

    process(clk, reset)
    begin

        if reset = '1' then

            clk_count <= 0;
            tick <= '0';

        elsif rising_edge(clk) then

            if clk_count = CLK_DIV-1 then

                clk_count <= 0;
                tick <= '1';

            else

                clk_count <= clk_count + 1;
                tick <= '0';

            end if;

        end if;

    end process;


    ----------------------------------------------------------------
    -- MASTER STATE MACHINE
    ----------------------------------------------------------------

    process(clk, reset)
    begin

        if reset = '1' then

            state <= IDLE;

            bit_count <= 7;

            scl_low <= '0';
            sda_low <= '0';

            busy <= '0';
            done <= '0';

            ack_address <= '0';
            ack_data <= '0';


        elsif rising_edge(clk) then

            ----------------------------------------------------------------
            -- IDLE
            ----------------------------------------------------------------

            if state = IDLE then

                scl_low <= '0';
                sda_low <= '0';

                busy <= '0';

                bit_count <= 7;


                if start = '1' then

                    busy <= '1';

                    done <= '0';

                    ack_address <= '0';
                    ack_data <= '0';

                    state <= START_A;

                end if;


            ----------------------------------------------------------------
            -- OTHER STATES
            ----------------------------------------------------------------

            elsif tick = '1' then

                case state is


                    --------------------------------------------------------
                    -- START CONDITION
                    --------------------------------------------------------

                    when START_A =>

                        -- Bus initially:
                        -- SCL = HIGH
                        -- SDA = HIGH
                        --
                        -- Generate START:
                        -- SDA HIGH -> LOW

                        scl_low <= '0';
                        sda_low <= '1';

                        state <= START_B;


                    when START_B =>

                        -- Pull SCL LOW

                        scl_low <= '1';

                        bit_count <= 7;

                        state <= ADDRESS_SETUP;


                    --------------------------------------------------------
                    -- ADDRESS
                    --------------------------------------------------------

                    when ADDRESS_SETUP =>

                        -- Put address bit on SDA

                        if ADDRESS_BYTE(bit_count) = '0' then

                            sda_low <= '1';

                        else

                            sda_low <= '0';

                        end if;

                        scl_low <= '1';

                        state <= ADDRESS_HIGH;


                    when ADDRESS_HIGH =>

                        -- Release SCL
                        -- Pull-up makes it HIGH

                        scl_low <= '0';

                        state <= ADDRESS_LOW;


                    when ADDRESS_LOW =>

                        -- Finish clock by pulling SCL LOW

                        scl_low <= '1';

                        if bit_count = 0 then

                            state <= ADDRESS_ACK_SETUP;

                        else

                            bit_count <= bit_count - 1;

                            state <= ADDRESS_SETUP;

                        end if;


                    --------------------------------------------------------
                    -- ADDRESS ACK
                    --------------------------------------------------------

                    when ADDRESS_ACK_SETUP =>

                        -- Master releases SDA

                        sda_low <= '0';

                        -- SCL LOW

                        scl_low <= '1';

                        state <= ADDRESS_ACK_HIGH;


                    when ADDRESS_ACK_HIGH =>

                        -- Release SCL

                        scl_low <= '0';

                        state <= ADDRESS_ACK_SAMPLE;


                    when ADDRESS_ACK_SAMPLE =>

                        -- Slave should pull SDA LOW

                        if sda = '0' then

                            ack_address <= '1';

                        else

                            ack_address <= '0';

                        end if;

                        state <= ADDRESS_ACK_LOW;


                    when ADDRESS_ACK_LOW =>

                        -- Finish ACK clock

                        scl_low <= '1';

                        bit_count <= 7;

                        state <= DATA_SETUP;


                    --------------------------------------------------------
                    -- DATA
                    --------------------------------------------------------

                    when DATA_SETUP =>

                        if DATA_BYTE(bit_count) = '0' then

                            sda_low <= '1';

                        else

                            sda_low <= '0';

                        end if;

                        scl_low <= '1';

                        state <= DATA_HIGH;


                    when DATA_HIGH =>

                        -- SCL HIGH

                        scl_low <= '0';

                        state <= DATA_LOW;


                    when DATA_LOW =>

                        -- SCL LOW

                        scl_low <= '1';

                        if bit_count = 0 then

                            state <= DATA_ACK_SETUP;

                        else

                            bit_count <= bit_count - 1;

                            state <= DATA_SETUP;

                        end if;


                    --------------------------------------------------------
                    -- DATA ACK
                    --------------------------------------------------------

                    when DATA_ACK_SETUP =>

                        -- Release SDA

                        sda_low <= '0';

                        scl_low <= '1';

                        state <= DATA_ACK_HIGH;


                    when DATA_ACK_HIGH =>

                        -- Release SCL

                        scl_low <= '0';

                        state <= DATA_ACK_SAMPLE;


                    when DATA_ACK_SAMPLE =>

                        if sda = '0' then

                            ack_data <= '1';

                        else

                            ack_data <= '0';

                        end if;

                        state <= DATA_ACK_LOW;


                    when DATA_ACK_LOW =>

                        -- Finish ACK clock

                        scl_low <= '1';

                        state <= STOP_A;


                    --------------------------------------------------------
                    -- STOP
                    --------------------------------------------------------

                    when STOP_A =>

                        -- Both LOW

                        scl_low <= '1';
                        sda_low <= '1';

                        state <= STOP_B;


                    when STOP_B =>

                        -- Release SCL

                        scl_low <= '0';

                        -- Keep SDA LOW

                        sda_low <= '1';

                        state <= STOP_C;


                    when STOP_C =>

                        -- SCL HIGH
                        -- SDA LOW -> HIGH
                        --
                        -- STOP condition

                        scl_low <= '0';
                        sda_low <= '0';

                        state <= DONE_STATE;


                    --------------------------------------------------------
                    -- DONE
                    --------------------------------------------------------

                    when DONE_STATE =>

                        -- Keep DONE HIGH

                        busy <= '0';
                        done <= '1';

                        state <= DONE_STATE;


                    --------------------------------------------------------
                    -- SAFETY
                    --------------------------------------------------------

                    when others =>

                        state <= IDLE;

                end case;

            end if;

        end if;

    end process;

end Behavioral;