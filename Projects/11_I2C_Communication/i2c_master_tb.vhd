library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity i2c_master_tb is
end i2c_master_tb;


architecture behavioral of i2c_master_tb is

    --------------------------------------------------------------------
    -- DUT signals
    --------------------------------------------------------------------
    signal clk        : std_logic := '0';
    signal reset      : std_logic := '1';
    signal start      : std_logic := '0';

    signal slave_addr : std_logic_vector(6 downto 0) := "1010000";
    signal data_in    : std_logic_vector(7 downto 0) := "10100101";

    signal scl        : std_logic;
    signal sda        : std_logic;

    signal busy       : std_logic;
    signal done       : std_logic;
    signal ack_error  : std_logic;


    --------------------------------------------------------------------
    -- Simulation slave signals
    --------------------------------------------------------------------

    -- Slave pulls SDA LOW when generating ACK
    signal slave_sda_drive_low : std_logic := '0';

begin

    --------------------------------------------------------------------
    -- OPEN-DRAIN SDA BUS
    --
    -- Master can pull LOW or release.
    -- Slave can pull LOW or release.
    --------------------------------------------------------------------
    sda <= '0' when slave_sda_drive_low = '1' else 'Z';


    --------------------------------------------------------------------
    -- DUT
    --------------------------------------------------------------------
    DUT : entity work.i2c_master

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


    --------------------------------------------------------------------
    -- 50 MHz CLOCK
    --
    -- Period = 20 ns
    --------------------------------------------------------------------
    clk_process : process
    begin

        while true loop

            clk <= '0';
            wait for 10 ns;

            clk <= '1';
            wait for 10 ns;

        end loop;

    end process;


    --------------------------------------------------------------------
    -- TEST SEQUENCE
    --------------------------------------------------------------------
    stimulus_process : process
    begin

        ----------------------------------------------------------------
        -- RESET
        ----------------------------------------------------------------
        reset <= '1';

        wait for 200 ns;

        reset <= '0';

        wait for 200 ns;


        ----------------------------------------------------------------
        -- START I2C TRANSACTION
        ----------------------------------------------------------------

        start <= '1';

        wait for 20 ns;

        start <= '0';


        ----------------------------------------------------------------
        -- Wait for transaction to finish
        ----------------------------------------------------------------

        wait until done = '1';

        wait for 500 ns;


        ----------------------------------------------------------------
        -- Check result
        ----------------------------------------------------------------

        assert ack_error = '0'
            report "I2C transaction failed: ACK error detected"
            severity error;

        report "I2C WRITE transaction completed successfully"
            severity note;


        wait;

    end process;


    --------------------------------------------------------------------
    -- I2C SLAVE MODEL
    --------------------------------------------------------------------
    slave_process : process

        variable address_received : std_logic_vector(7 downto 0);
        variable data_received    : std_logic_vector(7 downto 0);

    begin

        ----------------------------------------------------------------
        -- Wait for START condition
        --
        -- START = SDA falling while SCL is HIGH
        ----------------------------------------------------------------

        wait until sda'event and sda = '0' and scl = '1';

        report "SLAVE: START detected"
            severity note;


        ----------------------------------------------------------------
        -- RECEIVE ADDRESS
        ----------------------------------------------------------------

        for i in 7 downto 0 loop

            wait until rising_edge(scl);

            address_received(i) := sda;

        end loop;


        report "SLAVE: Address received"
            severity note;


        ----------------------------------------------------------------
        -- ACK ADDRESS
        ----------------------------------------------------------------

        wait until falling_edge(scl);

        slave_sda_drive_low <= '1';

        wait until rising_edge(scl);

        wait until falling_edge(scl);

        slave_sda_drive_low <= '0';


        ----------------------------------------------------------------
        -- RECEIVE DATA
        ----------------------------------------------------------------

        for i in 7 downto 0 loop

            wait until rising_edge(scl);

            data_received(i) := sda;

        end loop;


        report "SLAVE: Data received"
            severity note;


        ----------------------------------------------------------------
        -- ACK DATA
        ----------------------------------------------------------------

        wait until falling_edge(scl);

        slave_sda_drive_low <= '1';

        wait until rising_edge(scl);

        wait until falling_edge(scl);

        slave_sda_drive_low <= '0';


        ----------------------------------------------------------------
        -- WAIT FOR STOP
        --
        -- STOP = SDA rising while SCL HIGH
        ----------------------------------------------------------------

        wait until sda'event and sda = '1' and scl = '1';

        report "SLAVE: STOP detected"
            severity note;


        ----------------------------------------------------------------
        -- VERIFY ADDRESS
        ----------------------------------------------------------------

        assert address_received = "10100000"
            report "ERROR: Incorrect I2C address received"
            severity error;


        ----------------------------------------------------------------
        -- VERIFY DATA
        ----------------------------------------------------------------

        assert data_received = "10100101"
            report "ERROR: Incorrect data received"
            severity error;


        report "SLAVE: Address and data verified successfully"
            severity note;


        wait;

    end process;

end behavioral;