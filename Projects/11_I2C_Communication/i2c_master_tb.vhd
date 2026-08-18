library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity i2c_master_tb is
end i2c_master_tb;


architecture Behavioral of i2c_master_tb is

    -- Clock
    signal clk : std_logic := '0';

    -- Reset
    signal reset : std_logic := '1';

    -- Start command
    signal start : std_logic := '0';

    -- I2C signals
    signal scl : std_logic;
    signal sda : std_logic;

    -- Status
    signal busy : std_logic;
    signal done : std_logic;

begin

    ------------------------------------------------------------
    -- DUT
    ------------------------------------------------------------

    uut : entity work.i2c_master

        port map (

            clk   => clk,
            reset => reset,

            start => start,

            scl   => scl,
            sda   => sda,

            busy  => busy,
            done  => done

        );


    ------------------------------------------------------------
    -- CLOCK GENERATION
    --
    -- Clock period = 20 ns
    -- Frequency = 50 MHz
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
        -- Wait before starting
        --------------------------------------------------------

        wait for 100 ns;

        --------------------------------------------------------
        -- Start I2C transmission
        --------------------------------------------------------

        start <= '1';

        wait for 20 ns;

        start <= '0';

        --------------------------------------------------------
        -- Wait until transmission finishes
        --------------------------------------------------------

        wait until done = '1';

        wait for 100 ns;

        --------------------------------------------------------
        -- End simulation
        --------------------------------------------------------

        assert false
            report "I2C simulation completed successfully"
            severity failure;

    end process;

end Behavioral;