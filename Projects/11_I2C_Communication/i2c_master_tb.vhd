library ieee;
use ieee.std_logic_1164.all;


entity i2c_master_tb is
end i2c_master_tb;


architecture behavior of i2c_master_tb is

    ----------------------------------------------------------------
    -- 500 ps simulation clock
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
    -- I2C bus
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
    -- 500 ps clock
    --
    -- 250 ps HIGH
    -- 250 ps LOW
    ----------------------------------------------------------------

    clk <= not clk after 250 ps;


    ----------------------------------------------------------------
    -- I2C MASTER
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
    -- Slave only drives SDA LOW during ACK.
    -- Otherwise SDA is released.
    ----------------------------------------------------------------

    slave : process

    begin

        ------------------------------------------------------------
        -- Initially release SDA
        ------------------------------------------------------------

        sda <= 'Z';


        ------------------------------------------------------------
        -- Wait for master START command
        ------------------------------------------------------------

        wait until start = '1';


        ------------------------------------------------------------
        -- ADDRESS
        --
        -- Wait for 8 SCL rising edges.
        ------------------------------------------------------------

        for i in 0 to 7 loop

            wait until rising_edge(scl);

        end loop;


        ------------------------------------------------------------
        -- ADDRESS ACK
        ------------------------------------------------------------

        -- Wait until SCL is LOW
        wait until scl = '0';

        -- Slave pulls SDA LOW
        sda <= '0';

        -- Wait for ACK clock HIGH
        wait until rising_edge(scl);

        -- Wait for ACK clock LOW
        wait until falling_edge(scl);

        -- Release SDA
        sda <= 'Z';


        ------------------------------------------------------------
        -- DATA
        --
        -- Wait for 8 SCL rising edges.
        ------------------------------------------------------------

        for i in 0 to 7 loop

            wait until rising_edge(scl);

        end loop;


        ------------------------------------------------------------
        -- DATA ACK
        ------------------------------------------------------------

        -- Wait until SCL is LOW
        wait until scl = '0';

        -- Slave pulls SDA LOW
        sda <= '0';

        -- Wait for ACK clock HIGH
        wait until rising_edge(scl);

        -- Wait for ACK clock LOW
        wait until falling_edge(scl);

        -- Release SDA
        sda <= 'Z';


        ------------------------------------------------------------
        -- End of slave activity
        ------------------------------------------------------------

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
        -- START I2C transaction
        ------------------------------------------------------------

        start <= '1';

        wait for 500 ps;

        start <= '0';


        ------------------------------------------------------------
        -- Wait until complete
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