library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity i2c_master is
    port (
        clk   : in    std_logic;
        reset : in    std_logic;
        start : in    std_logic;

        scl   : inout std_logic;
        sda   : inout std_logic;

        busy  : out std_logic;
        done  : out std_logic
    );
end i2c_master;


architecture Behavioral of i2c_master is

    ----------------------------------------------------------------
    -- CLOCK SETTINGS
    --
    -- FPGA clock = 50 MHz
    -- I2C clock  = 100 kHz
    --
    -- 50 MHz / 100 kHz = 500
    -- Therefore:
    -- 250 clocks = 5 us
    -- One complete SCL period = 10 us
    ----------------------------------------------------------------

    constant CLK_DIV : integer := 250;

    signal clk_count : integer range 0 to CLK_DIV-1 := 0;
    signal tick      : std_logic := '0';


    ----------------------------------------------------------------
    -- I2C ADDRESS AND DATA
    ----------------------------------------------------------------

    -- 7-bit slave address = 1010000
    -- Write bit = 0
    -- Complete byte = 10100000

    constant ADDRESS_BYTE : std_logic_vector(7 downto 0)
        := "10100000";


    -- Data = 10101010

    constant DATA_BYTE : std_logic_vector(7 downto 0)
        := "10101010";


    signal bit_count : integer range 0 to 7 := 7;


    ----------------------------------------------------------------
    -- STATE MACHINE
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
        ADDRESS_ACK_LOW,

        DATA_SETUP,
        DATA_HIGH,
        DATA_LOW,

        DATA_ACK_SETUP,
        DATA_ACK_HIGH,
        DATA_ACK_LOW,

        STOP_1,
        STOP_2,
        STOP_3,

        DONE_STATE

    );

    signal state : state_type := IDLE;


    ----------------------------------------------------------------
    -- OPEN-DRAIN CONTROL
    ----------------------------------------------------------------

    signal scl_drive_low : std_logic := '0';
    signal sda_drive_low : std_logic := '0';


begin

    ----------------------------------------------------------------
    -- OPEN-DRAIN I2C OUTPUT
    --
    -- Drive LOW when requested.
    -- Otherwise release the line.
    ----------------------------------------------------------------

    scl <= '0' when scl_drive_low = '1' else 'Z';

    sda <= '0' when sda_drive_low = '1' else 'Z';


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

            scl_drive_low <= '0';
            sda_drive_low <= '0';

            busy <= '0';
            done <= '0';


        elsif rising_edge(clk) then

            --------------------------------------------------------
            -- IDLE
            --------------------------------------------------------

            if state = IDLE then

                scl_drive_low <= '0';
                sda_drive_low <= '0';

                busy <= '0';


                if start = '1' then

                    busy <= '1';
                    done <= '0';

                    bit_count <= 7;

                    state <= START_1;

                end if;


            --------------------------------------------------------
            -- TRANSACTION
            --------------------------------------------------------

            elsif tick = '1' then

                case state is


                    ------------------------------------------------
                    -- START
                    ------------------------------------------------

                    when START_1 =>

                        -- SCL HIGH
                        -- SDA HIGH -> LOW

                        scl_drive_low <= '0';
                        sda_drive_low <= '1';

                        state <= START_2;


                    when START_2 =>

                        -- Pull SCL LOW

                        scl_drive_low <= '1';

                        bit_count <= 7;

                        state <= ADDRESS_SETUP;


                    ------------------------------------------------
                    -- ADDRESS
                    ------------------------------------------------

                    when ADDRESS_SETUP =>

                        if ADDRESS_BYTE(bit_count) = '0' then

                            sda_drive_low <= '1';

                        else

                            sda_drive_low <= '0';

                        end if;

                        scl_drive_low <= '1';

                        state <= ADDRESS_HIGH;


                    when ADDRESS_HIGH =>

                        -- SCL HIGH

                        scl_drive_low <= '0';

                        state <= ADDRESS_LOW;


                    when ADDRESS_LOW =>

                        -- SCL LOW

                        scl_drive_low <= '1';

                        if bit_count = 0 then

                            state <= ADDRESS_ACK_SETUP;

                        else

                            bit_count <= bit_count - 1;

                            state <= ADDRESS_SETUP;

                        end if;


                    ------------------------------------------------
                    -- ADDRESS ACK
                    ------------------------------------------------

                    when ADDRESS_ACK_SETUP =>

                        -- Master releases SDA.

                        sda_drive_low <= '0';

                        -- SCL LOW.

                        scl_drive_low <= '1';

                        state <= ADDRESS_ACK_HIGH;


                    when ADDRESS_ACK_HIGH =>

                        -- Release SCL.

                        scl_drive_low <= '0';

                        -- SDA is now controlled by slave.

                        state <= ADDRESS_ACK_LOW;


                    when ADDRESS_ACK_LOW =>

                        -- SCL LOW again.

                        scl_drive_low <= '1';

                        -- We have observed the ACK period.

                        bit_count <= 7;

                        state <= DATA_SETUP;


                    ------------------------------------------------
                    -- DATA
                    ------------------------------------------------

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


                    ------------------------------------------------
                    -- DATA ACK
                    ------------------------------------------------

                    when DATA_ACK_SETUP =>

                        -- Release SDA.

                        sda_drive_low <= '0';

                        -- SCL LOW.

                        scl_drive_low <= '1';

                        state <= DATA_ACK_HIGH;


                    when DATA_ACK_HIGH =>

                        -- Release SCL.

                        scl_drive_low <= '0';

                        -- Slave controls SDA.

                        state <= DATA_ACK_LOW;


                    when DATA_ACK_LOW =>

                        -- Finish ACK clock.

                        scl_drive_low <= '1';

                        state <= STOP_1;


                    ------------------------------------------------
                    -- STOP
                    ------------------------------------------------

                    when STOP_1 =>

                        -- Both lines LOW.

                        scl_drive_low <= '1';
                        sda_drive_low <= '1';

                        state <= STOP_2;


                    when STOP_2 =>

                        -- Release SCL.

                        scl_drive_low <= '0';

                        -- SDA remains LOW.

                        sda_drive_low <= '1';

                        state <= STOP_3;


                    when STOP_3 =>

                        -- SCL HIGH.
                        -- SDA LOW -> HIGH.

                        scl_drive_low <= '0';
                        sda_drive_low <= '0';

                        state <= DONE_STATE;


                    ------------------------------------------------
                    -- DONE
                    ------------------------------------------------

                    when DONE_STATE =>

                        busy <= '0';
                        done <= '1';

                        -- Stay here until reset.

                        state <= DONE_STATE;


                    ------------------------------------------------
                    -- SAFETY
                    ------------------------------------------------

                    when others =>

                        state <= IDLE;

                end case;

            end if;

        end if;

    end process;

end Behavioral;