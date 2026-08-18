library ieee;
use ieee.std_logic_1164.all;

entity i2c_master_tb is
end i2c_master_tb;


architecture behavior of i2c_master_tb is

    ----------------------------------------------------------------
    -- Signals
    ----------------------------------------------------------------

    signal clk : std_logic := '0';

    signal reset : std_logic := '1';

    signal start : std_logic := '0';


    ----------------------------------------------------------------
    -- I2C data
    ----------------------------------------------------------------

    signal slave_addr : std_logic_vector(6 downto 0)
                        := "1010000";

    signal data_in : std_logic_vector(7 downto 0)
                     := "01010101";


    ----------------------------------------------------------------
    -- I2C signals
    ----------------------------------------------------------------

    signal scl : std_logic;

    signal sda : std_logic;


    ----------------------------------------------------------------
    -- Status
    ----------------------------------------------------------------

    signal busy : std_logic;

    signal done : std_logic;


begin


    ----------------------------------------------------------------
    -- 500 ps simulation clock
    --
    -- Half period = 250 ps
    -- Full period = 500 ps
    ----------------------------------------------------------------

    clk <= not clk after 250 ps;


    ----------------------------------------------------------------
    -- I2C MASTER
    --
    -- CLK_DIV = 2 for fast simulation
    ----------------------------------------------------------------

    DUT : entity work.i2c_master

        generic map (

            CLK_DIV => 2

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

            done       => done

        );


    ----------------------------------------------------------------
    -- SIMULATED I2C SLAVE
    --
    -- Generates ACK after address
    -- and after data.
    ----------------------------------------------------------------

    slave_ack : process

    begin

        ------------------------------------------------------------
        -- Wait for START command
        ------------------------------------------------------------

        wait until start = '1';


        ------------------------------------------------------------
        -- Wait until address transmission is finished
        ------------------------------------------------------------

        wait for 10 ns;


        ------------------------------------------------------------
        -- ADDRESS ACK
        ------------------------------------------------------------

        wait until scl = '0';

        sda <= '0';

        wait until scl = '1';

        wait until scl = '0';

        sda <= 'Z';


        ------------------------------------------------------------
        -- Wait for data transmission
        ------------------------------------------------------------

        wait for 10 ns;


        ------------------------------------------------------------
        -- DATA ACK
        ------------------------------------------------------------

        wait until scl = '0';

        sda <= '0';

        wait until scl = '1';

        wait until scl = '0';

        sda <= 'Z';


        wait;

    end process;


    ----------------------------------------------------------------
    -- TEST SEQUENCE
    ----------------------------------------------------------------

    stimulus : process

    begin

        ------------------------------------------------------------
        -- RESET
        ------------------------------------------------------------

        reset <= '1';

        wait for 1 ns;

        reset <= '0';

        wait for 1 ns;


        ------------------------------------------------------------
        -- START TRANSACTION
        ------------------------------------------------------------

        start <= '1';

        wait for 500 ps;

        start <= '0';


        ------------------------------------------------------------
        -- Wait for transaction to finish
        ------------------------------------------------------------

        wait until done = '1';

        wait for 1 ns;


        ------------------------------------------------------------
        -- End simulation
        ------------------------------------------------------------

        assert false
            report "I2C simulation completed successfully"
            severity failure;

    end process;


end behavior;