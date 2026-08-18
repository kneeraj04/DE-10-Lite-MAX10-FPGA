library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity i2c_master_tb is
end i2c_master_tb;


architecture Behavioral of i2c_master_tb is

    signal clk   : std_logic := '0';
    signal reset : std_logic := '1';
    signal start : std_logic := '0';

    ------------------------------------------------------------
    -- I2C BUS
    ------------------------------------------------------------

    signal scl : std_logic := 'H';
    signal sda : std_logic := 'H';

    signal busy : std_logic;
    signal done : std_logic;
    signal ack  : std_logic;

begin

    ------------------------------------------------------------
    -- PULL-UP RESISTORS
    --
    -- Simulates the external I2C pull-up resistors
    ------------------------------------------------------------

    scl <= 'H';
    sda <= 'H';


    ------------------------------------------------------------
    -- I2C MASTER
    ------------------------------------------------------------

    master_inst : entity work.i2c_master

        port map (

            clk   => clk,
            reset => reset,
            start => start,

            scl   => scl,
            sda   => sda,

            busy  => busy,
            done  => done,
            ack   => ack

        );


    ------------------------------------------------------------
    -- I2C SLAVE
    ------------------------------------------------------------

    slave_inst : entity work.i2c_slave

        port map (

            scl => scl,
            sda => sda

        );


    ------------------------------------------------------------
    -- 50 MHz CLOCK
    -- Period = 20 ns
    ------------------------------------------------------------

    clk_process : process
    begin

        while true loop

            clk <= '0';
            wait for 10 ns;

            clk <= '1';
            wait for 10 ns;

        end loop;

    end process;


    ------------------------------------------------------------
    -- TEST SEQUENCE
    ------------------------------------------------------------

    stimulus_process : process
    begin

        --------------------------------------------------------
        -- RESET
        --------------------------------------------------------

        reset <= '1';

        wait for 100 ns;

        reset <= '0';


        --------------------------------------------------------
        -- WAIT
        --------------------------------------------------------

        wait for 100 ns;


        --------------------------------------------------------
        -- START I2C TRANSACTION
        --
        -- Keep START HIGH for 10 us.
        -- This gives the master enough time to detect it.
        --------------------------------------------------------

        start <= '1';

        wait for 10 us;

        start <= '0';


        --------------------------------------------------------
        -- WAIT FOR COMPLETE TRANSACTION
        --------------------------------------------------------

        wait until done = '1';

        wait for 100 ns;


        --------------------------------------------------------
        -- END SIMULATION
        --------------------------------------------------------

        assert false
            report "I2C transaction completed successfully"
            severity failure;

    end process;

end Behavioral;