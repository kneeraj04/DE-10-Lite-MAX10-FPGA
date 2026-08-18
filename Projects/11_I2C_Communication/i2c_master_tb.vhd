library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity i2c_master_tb is
end i2c_master_tb;


architecture Behavioral of i2c_master_tb is

    signal clk   : std_logic := '0';
    signal reset : std_logic := '1';
    signal start : std_logic := '0';

    signal scl : std_logic;
    signal sda : std_logic;

    signal busy : std_logic;
    signal done : std_logic;

    signal ack_address : std_logic;
    signal ack_data    : std_logic;

begin

    ------------------------------------------------------------
    -- MASTER
    ------------------------------------------------------------

    master_inst : entity work.i2c_master

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
    -- SLAVE
    ------------------------------------------------------------

    slave_inst : entity work.i2c_slave

        port map (

            scl => scl,
            sda => sda,

            ack_address => ack_address,
            ack_data    => ack_data

        );


    ------------------------------------------------------------
    -- CLOCK
    --
    -- 50 MHz
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
        -- START
        --------------------------------------------------------

        start <= '1';

        wait for 20 ns;

        start <= '0';

        --------------------------------------------------------
        -- WAIT FOR TRANSACTION
        --------------------------------------------------------

        wait until done = '1';

        wait for 100 ns;

        --------------------------------------------------------
        -- END SIMULATION
        --------------------------------------------------------

        assert false
            report "I2C transaction completed"
            severity failure;

    end process;

end Behavioral;