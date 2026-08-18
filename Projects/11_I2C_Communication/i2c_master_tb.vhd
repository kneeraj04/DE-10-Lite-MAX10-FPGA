library ieee;
use ieee.std_logic_1164.all;


entity i2c_master_tb is
end i2c_master_tb;


architecture behavioral of i2c_master_tb is

    signal clk : std_logic := '0';

    signal reset : std_logic := '1';

    signal start : std_logic := '0';

    signal slave_addr : std_logic_vector(6 downto 0)
                        := "1010000";

    signal data_in : std_logic_vector(7 downto 0)
                     := "10100101";

    signal scl : std_logic;

    signal sda : std_logic;

    signal busy : std_logic;

    signal done : std_logic;

    signal ack_error : std_logic;


begin

    ------------------------------------------------------------
    -- DUT
    ------------------------------------------------------------

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


    ------------------------------------------------------------
    -- FAST SIMULATION CLOCK
    --
    -- Clock period = 200 ps
    ------------------------------------------------------------

    clk_process : process
    begin

        while true loop

            clk <= '0';
            wait for 100 ps;

            clk <= '1';
            wait for 100 ps;

        end loop;

    end process;


    ------------------------------------------------------------
    -- TEST
    ------------------------------------------------------------

    test_process : process
    begin

        --------------------------------------------------------
        -- RESET
        --------------------------------------------------------

        reset <= '1';

        wait for 500 ps;

        reset <= '0';


        --------------------------------------------------------
        -- START TRANSACTION
        --------------------------------------------------------

        wait for 200 ps;

        start <= '1';

        wait for 200 ps;

        start <= '0';


        --------------------------------------------------------
        -- Wait for completion
        --------------------------------------------------------

        wait until done = '1';


        --------------------------------------------------------
        -- Display result
        --------------------------------------------------------

        report "======================================"
            severity note;

        report "I2C TRANSACTION COMPLETED"
            severity note;

        report "Address = 0x50"
            severity note;

        report "Data = 0xA5"
            severity note;

        report "======================================"
            severity note;


        wait;

    end process;


end behavioral;