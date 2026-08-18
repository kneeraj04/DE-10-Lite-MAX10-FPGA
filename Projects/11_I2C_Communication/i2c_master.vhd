library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity i2c_master is
    port (
        clk   : in    std_logic;   -- 50 MHz FPGA clock
        reset : in    std_logic;
        start : in    std_logic;

        scl   : inout std_logic;
        sda   : inout std_logic;

        busy  : out std_logic;
        done  : out std_logic;
        ack   : out std_logic
    );
end i2c_master;


architecture Behavioral of i2c_master is

    ------------------------------------------------------------
    -- I2C CLOCK
    --
    -- 50 MHz FPGA clock
    -- 100 kHz I2C clock
    --
    -- Half period = 5 us
    -- 50 MHz × 5 us = 250 clock cycles
    ------------------------------------------------------------

    constant CLK_DIV : integer := 250;

    signal clk_count : integer range 0 to CLK_DIV-1 := 0;

    signal tick : std_logic := '0';


    ------------------------------------------------------------
    -- I2C STATE MACHINE
    ------------------------------------------------------------

    type state_type is (
        IDLE,

        START_1,
        START_2,

        ADDRESS_LOW,
        ADDRESS_HIGH,

        ADDRESS_ACK_LOW,
        ADDRESS_ACK_HIGH,

        DATA_LOW,
        DATA_HIGH,

        DATA_ACK_LOW,
        DATA_ACK_HIGH,

        STOP_1,
        STOP_2,

        DONE_STATE
    );

    signal state : state_type := IDLE;


    ------------------------------------------------------------
    -- DATA
    ------------------------------------------------------------

    -- 7-bit slave address = 1010000
    -- Write bit = 0
    --
    -- Complete transmitted byte:
    -- 10100000
    ------------------------------------------------------------

    constant ADDRESS_BYTE : std_logic_vector(7 downto 0)
        := "10100000";


    -- Data = 10101010

    constant DATA_BYTE : std_logic_vector(7 downto 0)
        := "10101010";


    signal bit_count : integer range 0 to 7 := 7;


    ------------------------------------------------------------
    -- OPEN-DRAIN CONTROL
    ------------------------------------------------------------

    signal scl_drive_low : std_logic := '0';
    signal sda_drive_low : std_logic := '0';


begin

    ------------------------------------------------------------
    -- REAL I2C OPEN-DRAIN OUTPUTS
    --
    -- We NEVER actively drive HIGH.
    --
    -- Drive LOW  -> '0'
    -- Release    -> 'Z'
    ------------------------------------------------------------

    scl <= '0' when scl_drive_low = '1' else 'Z';

    sda <= '0' when sda_drive_low = '1' else 'Z';


    ------------------------------------------------------------
    -- CLOCK DIVIDER
    --
    -- 50 MHz → 100 kHz I2C timing
    ------------------------------------------------------------

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


    ------------------------------------------------------------
    -- I2C MASTER STATE MACHINE
    ------------------------------------------------------------

    process(clk, reset)
    begin

        if reset = '1' then

            state <= IDLE;

            bit_count <= 7;

            scl_drive_low <= '0';
            sda_drive_low <= '0';

            busy <= '0';
            done <= '0';
            ack <= '0';

        elsif rising_edge(clk) then

            ----------------------------------------------------
            -- State machine advances on I2C timing tick
            ----------------------------------------------------

            if tick = '1' then

                case state is


                    ------------------------------------------------
                    -- IDLE
                    ------------------------------------------------

                    when IDLE =>

                        scl_drive_low <= '0';
                        sda_drive_low <= '0';

                        busy <= '0';
                        done <= '0';
                        ack <= '0';

                        bit_count <= 7;

                        if start = '1' then

                            busy <= '1';

                            state <= START_1;

                        end if;


                    ------------------------------------------------
                    -- START CONDITION
                    --
                    -- Bus idle:
                    -- SCL = HIGH
                    -- SDA = HIGH
                    --
                    -- START:
                    -- SDA HIGH → LOW
                    -- while SCL HIGH
                    ------------------------------------------------

                    when START_1 =>

                        scl_drive_low <= '0';
                        sda_drive_low <= '1';

                        state <= START_2;


                    when START_2 =>

                        scl_drive_low <= '1';

                        state <= ADDRESS_LOW;


                    ------------------------------------------------
                    -- ADDRESS LOW
                    ------------------------------------------------

                    when ADDRESS_LOW =>

                        -- Put current bit on SDA

                        if ADDRESS_BYTE(bit_count) = '0' then

                            sda_drive_low <= '1';

                        else

                            sda_drive_low <= '0';

                        end if;

                        scl_drive_low <= '1';

                        state <= ADDRESS_HIGH;


                    ------------------------------------------------
                    -- ADDRESS HIGH
                    ------------------------------------------------

                    when ADDRESS_HIGH =>

                        -- Release SCL HIGH

                        scl_drive_low <= '0';

                        if bit_count = 0 then

                            state <= ADDRESS_ACK_LOW;

                        else

                            bit_count <= bit_count - 1;

                            state <= ADDRESS_LOW;

                        end if;


                    ------------------------------------------------
                    -- ADDRESS ACK
                    ------------------------------------------------

                    when ADDRESS_ACK_LOW =>

                        -- Release SDA.
                        -- Slave can now generate ACK.

                        sda_drive_low <= '0';

                        scl_drive_low <= '1';

                        state <= ADDRESS_ACK_HIGH;


                    when ADDRESS_ACK_HIGH =>

                        -- SCL HIGH

                        scl_drive_low <= '0';

                        -- ACK = SDA LOW

                        if sda = '0' then

                            ack <= '1';

                        else

                            ack <= '0';

                        end if;

                        bit_count <= 7;

                        state <= DATA_LOW;


                    ------------------------------------------------
                    -- DATA LOW
                    ------------------------------------------------

                    when DATA_LOW =>

                        if DATA_BYTE(bit_count) = '0' then

                            sda_drive_low <= '1';

                        else

                            sda_drive_low <= '0';

                        end if;

                        scl_drive_low <= '1';

                        state <= DATA_HIGH;


                    ------------------------------------------------
                    -- DATA HIGH
                    ------------------------------------------------

                    when DATA_HIGH =>

                        scl_drive_low <= '0';

                        if bit_count = 0 then

                            state <= DATA_ACK_LOW;

                        else

                            bit_count <= bit_count - 1;

                            state <= DATA_LOW;

                        end if;


                    ------------------------------------------------
                    -- DATA ACK
                    ------------------------------------------------

                    when DATA_ACK_LOW =>

                        sda_drive_low <= '0';

                        scl_drive_low <= '1';

                        state <= DATA_ACK_HIGH;


                    when DATA_ACK_HIGH =>

                        scl_drive_low <= '0';

                        if sda = '0' then

                            ack <= '1';

                        else

                            ack <= '0';

                        end if;

                        state <= STOP_1;


                    ------------------------------------------------
                    -- STOP CONDITION
                    ------------------------------------------------

                    when STOP_1 =>

                        -- SDA LOW
                        -- SCL LOW

                        sda_drive_low <= '1';
                        scl_drive_low <= '1';

                        state <= STOP_2;


                    when STOP_2 =>

                        -- Release SCL first

                        scl_drive_low <= '0';

                        -- Then release SDA
                        -- SDA LOW → HIGH
                        -- while SCL HIGH

                        sda_drive_low <= '0';

                        state <= DONE_STATE;


                    ------------------------------------------------
                    -- DONE
                    ------------------------------------------------

                    when DONE_STATE =>

                        busy <= '0';
                        done <= '1';

                        state <= IDLE;


                end case;

            end if;

        end if;

    end process;

end Behavioral;