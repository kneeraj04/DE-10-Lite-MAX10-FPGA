library ieee;
use ieee.std_logic_1164.all;


entity i2c_master_tb is
end i2c_master_tb;


architecture sim of i2c_master_tb is

    signal clk   : std_logic := '0';
    signal reset : std_logic := '1';
    signal start : std_logic := '0';

    signal slave_addr : std_logic_vector(6 downto 0)
                        := "1010000";       -- 0x50

    signal data_in : std_logic_vector(7 downto 0)
                     := "10100101";        -- 0xA5

    signal scl : std_logic;

    signal sda : std_logic := 'H';

    signal busy      : std_logic;
    signal done      : std_logic;
    signal ack_error : std_logic;

    signal slave_drive_low : std_logic := '0';

begin

    ----------------------------------------------------------------
    -- Pull-up resistor
    --
    -- When nobody pulls SDA LOW:
    -- SDA = HIGH
    ----------------------------------------------------------------
    sda <= 'H';


    ----------------------------------------------------------------
    -- Simulated slave ACK
    ----------------------------------------------------------------
    sda <= '0' when slave_drive_low = '1' else 'Z';


    ----------------------------------------------------------------
    -- MASTER
    ----------------------------------------------------------------
    DUT : entity work.i2c_master
        generic map (
            CLK_FREQ => 50000000,
            I2C_FREQ => 5000000
        )
        port map (
            clk        => clk,
            reset      => reset,
            start      => start,
            slave_addr => slave_addr,
            data_in    => data_in,
            scl        => scl,
            sda        => sda,
            busy       => busy,
            done       => done,
            ack_error  => ack_error
        );


    ----------------------------------------------------------------
    -- FAST SIMULATION CLOCK
    -- 200 ps period
    ----------------------------------------------------------------
    clk_process : process
    begin

        while true loop

            clk <= '0';
            wait for 100 ps;

            clk <= '1';
            wait for 100 ps;

        end loop;

    end process;


    ----------------------------------------------------------------
    -- START TRANSACTION
    ----------------------------------------------------------------
    stimulus : process
    begin

        reset <= '1';

        wait for 500 ps;

        reset <= '0';

        wait for 500 ps;

        start <= '1';

        wait for 200 ps;

        start <= '0';

        wait until done = '1';

        report "I2C transaction completed"
            severity note;

        wait;

    end process;


    ----------------------------------------------------------------
    -- SIMPLE SLAVE ACK MODEL
    ----------------------------------------------------------------
    slave_ack : process
    begin

        -- Wait until master releases SDA for address ACK
        wait until scl = '0';

        -- Wait a little before ACK
        wait for 100 ps;

        slave_drive_low <= '1';

        wait until scl = '1';

        wait for 100 ps;

        slave_drive_low <= '0';


        -- Wait for data ACK
        wait until scl = '0';

        wait for 100 ps;

        slave_drive_low <= '1';

        wait until scl = '1';

        wait for 100 ps;

        slave_drive_low <= '0';

        wait;

    end process;

end sim;