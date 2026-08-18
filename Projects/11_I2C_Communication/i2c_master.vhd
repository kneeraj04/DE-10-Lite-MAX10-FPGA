library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

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
    -- CLOCK SETTINGS
    --
    -- FPGA clock = 50 MHz
    -- I2C clock  = 100 kHz
    --
    -- One half SCL period = 5 us
    --
    -- 50 MHz × 5 us = 250 clock cycles
    ----------------------------------------------------------------

    constant CLK_DIV : integer := 250;

    signal clk_count : integer range 0 to CLK_DIV-1 := 0;
    signal tick      : std_logic := '0';


    ----------------------------------------------------------------
    -- I2C STATE MACHINE
    ----------------------------------------------------------------

    type state_type is (
        IDLE,

        START_1,
        START_2,

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

        STOP_1,
        STOP_2,
        STOP_3,

        DONE_STATE
    );

    signal state : state_type := IDLE;


    ----------------------------------------------------------------
    -- I2C DATA
    ----------------------------------------------------------------

    -- 7-bit address:
    -- 1010000
    --
    -- Write bit:
    -- 0
    --
    -- Complete byte:
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

    signal scl_drive_low : std_logic := '0';
    signal sda_drive_low : std_logic := '0';


begin

    ----------------------------------------------------------------
    -- OPEN-DRAIN I2C OUTPUTS
    --
    -- Drive LOW:
    --     FPGA drives 0
    --
    -- Release:
    --     FPGA drives Z
    --     external pull-up makes line HIGH
    ----------------------------------------------------------------

    scl <= '0' when scl_drive_low = '1' else 'Z';

    sda <= '0' when sda_drive_low = '1' else 'Z';


    ----------------------------------------------------------------
    -- 50 MHz CLOCK -> 100 kHz I2C TIMING
    ----------------------------------------------------------------

    process(clk, reset)
    begin

        if reset = '1' then

            clk_count <= 0;
            tick      <= '0';

        elsif rising_edge(clk) then

            if clk_count = CLK_DIV - 1 then

                clk_count <= 0;
                tick      <= '1';

            else

                clk_count <= clk_count + 1;
                tick      <= '0';

            end if;

        end if;

    end process;


    ----------------------------------------------------------------
    -- I2C MASTER STATE MACHINE
    ----------------------------------------------------------------

    process(clk, reset)
    begin

        if reset = '1' then

            state <= IDLE;

            bit_count <= 7;

            scl_drive_low <= '0';
            sda_drive_low <= '0';

            busy <= '0';
            done <= '0';

            ack_address <= '0';
            ack_data    <= '0';


        elsif rising_edge(clk) then

            --------------------------------------------------------
            -- Default: DONE is a pulse
            --------------------------------------------------------

            done <= '0';


            --------------------------------------------------------
            -- IDLE
            --
            -- START is checked on every 50 MHz clock.
            -- Therefore even a short START pulse is detected.
            --------------------------------------------------------

            if state = IDLE then

                scl_drive_low <= '0';
                sda_drive_low <= '0';

                busy <= '0';

                ack_address <= '0';
                ack_data    <= '0';

                bit_count <= 7;


                if start = '1' then

                    busy  <= '1';
                    state <= START_1;

                end if;


            --------------------------------------------------------
            -- All other states advance only at the I2C timing tick
            --------------------------------------------------------

            elsif tick = '1' then

                case state is


                    =================================================
                    -- START CONDITION
                    =================================================

                    when START_1 =>

                        -- Bus idle:
                        -- SCL = HIGH
                        -- SDA = HIGH
                        --
                        -- START:
                        -- SDA HIGH -> LOW

                        scl_drive_low <= '0';
                        sda_drive_low <= '1';

                        state <= START_2;


                    when START_2 =>

                        -- Pull SCL LOW

                        scl_drive_low <= '1';

                        bit_count <= 7;

                        state <= ADDRESS_SETUP;


                    =================================================
                    -- ADDRESS TRANSMISSION
                    =================================================

                    when ADDRESS_SETUP =>

                        -- SDA must be stable while SCL is LOW

                        if ADDRESS_BYTE(bit_count) = '0' then

                            sda_drive_low <= '1';

                        else

                            sda_drive_low <= '0';

                        end if;

                        scl_drive_low <= '1';

                        state <= ADDRESS_HIGH;


                    when ADDRESS_HIGH =>

                        -- Release SCL.
                        -- Pull-up makes SCL HIGH.

                        scl_drive_low <= '0';

                        state <= ADDRESS_LOW;


                    when ADDRESS_LOW =>

                        -- Finish this bit by pulling SCL LOW

                        scl_drive_low <= '1';

                        if bit_count = 0 then

                            state <= ADDRESS_ACK_SETUP;

                        else

                            bit_count <= bit_count - 1;

                            state <= ADDRESS_SETUP;

                        end if;


                    =================================================
                    -- ADDRESS ACK
                    =================================================

                    when ADDRESS_ACK_SETUP =>

                        -- Master releases SDA.
                        -- Slave can now pull SDA LOW.

                        sda_drive_low <= '0';

                        scl_drive_low <= '1';

                        state <= ADDRESS_ACK_HIGH;


                    when ADDRESS_ACK_HIGH =>

                        -- Release SCL.

                        scl_drive_low <= '0';

                        -- Do NOT sample immediately.
                        -- Keep SCL HIGH for one complete timing period.

                        state <= ADDRESS_ACK_SAMPLE;


                    when ADDRESS_ACK_SAMPLE =>

                        -- Slave should now have SDA LOW.

                        if sda = '0' then

                            ack_address <= '1';

                        else

                            ack_address <= '0';

                        end if;

                        state <= ADDRESS_ACK_LOW;


                    when ADDRESS_ACK_LOW =>

                        -- Finish ACK clock

                        scl_drive_low <= '1';

                        bit_count <= 7;

                        state <= DATA_SETUP;


                    =================================================
                    -- DATA TRANSMISSION
                    =================================================

                    when DATA_SETUP =>

                        if DATA_BYTE(bit_count) = '0' then

                            sda_drive_low <= '1';

                        else

                            sda_drive_low <= '0';

                        end if;

                        scl_drive_low <= '1';

                        state <= DATA_HIGH;


                    when DATA_HIGH =>

                        -- SCL HIGH

                        scl_drive_low <= '0';

                        state <= DATA_LOW;


                    when DATA_LOW =>

                        -- SCL LOW

                        scl_drive_low <= '1';

                        if bit_count = 0 then

                            state <= DATA_ACK_SETUP;

                        else

                            bit_count <= bit_count - 1;

                            state <= DATA_SETUP;

                        end if;


                    =================================================
                    -- DATA ACK
                    =================================================

                    when DATA_ACK_SETUP =>

                        -- Master releases SDA

                        sda_drive_low <= '0';

                        scl_drive_low <= '1';

                        state <= DATA_ACK_HIGH;


                    when DATA_ACK_HIGH =>

                        -- Release SCL

                        scl_drive_low <= '0';

                        state <= DATA_ACK_SAMPLE;


                    when DATA_ACK_SAMPLE =>

                        -- Sample slave ACK

                        if sda = '0' then

                            ack_data <= '1';

                        else

                            ack_data <= '0';

                        end if;

                        state <= DATA_ACK_LOW;


                    when DATA_ACK_LOW =>

                        -- Finish ACK clock

                        scl_drive_low <= '1';

                        state <= STOP_1;


                    =================================================
                    -- STOP CONDITION
                    =================================================

                    when STOP_1 =>

                        -- Both lines LOW

                        scl_drive_low <= '1';
                        sda_drive_low <= '1';

                        state <= STOP_2;


                    when STOP_2 =>

                        -- Release SCL first

                        scl_drive_low <= '0';

                        -- Keep SDA LOW

                        sda_drive_low <= '1';

                        state <= STOP_3;


                    when STOP_3 =>

                        -- SCL is HIGH
                        --
                        -- Release SDA:
                        -- SDA LOW -> HIGH
                        --
                        -- This creates STOP.

                        scl_drive_low <= '0';
                        sda_drive_low <= '0';

                        state <= DONE_STATE;


                    =================================================
                    -- COMPLETE
                    =================================================

                    when DONE_STATE =>

                        busy <= '0';
                        done <= '1';

                        state <= IDLE;


                    when others =>

                        state <= IDLE;

                end case;

            end if;

        end if;

    end process;

end Behavioral;