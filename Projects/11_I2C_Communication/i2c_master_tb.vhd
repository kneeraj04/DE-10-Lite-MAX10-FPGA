library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity i2c_master_tb is
end i2c_master_tb;


architecture Behavioral of i2c_master_tb is

    --------------------------------------------------------------------
    -- CLOCK
    --------------------------------------------------------------------

    signal clk : std_logic := '0';

    constant CLK_PERIOD : time := 10 ns;


    --------------------------------------------------------------------
    -- RESET
    --------------------------------------------------------------------

    signal reset_n : std_logic := '0';


    --------------------------------------------------------------------
    -- MASTER INPUTS
    --------------------------------------------------------------------

    signal start : std_logic := '0';

    signal slave_addr : std_logic_vector(6 downto 0)
        := "1010000";

    signal data_in : std_logic_vector(7 downto 0)
        := "01010101";


    --------------------------------------------------------------------
    -- MASTER OUTPUTS
    --------------------------------------------------------------------

    signal busy : std_logic;

    signal done : std_logic;

    signal scl : std_logic;

    signal sda_out : std_logic;

    signal sda_in : std_logic := '1';


begin

    --------------------------------------------------------------------
    -- CLOCK GENERATION
    --------------------------------------------------------------------

    clk <= not clk after CLK_PERIOD / 2;


    --------------------------------------------------------------------
    -- I2C MASTER
    --------------------------------------------------------------------

    DUT : entity work.i2c_master

        generic map (
            CLK_DIV => 4
        )

        port map (

            clk        => clk,

            reset_n    => reset_n,

            start      => start,

            slave_addr => slave_addr,

            data_in    => data_in,

            busy       => busy,

            done       => done,

            scl        => scl,

            sda_out    => sda_out,

            sda_in     => sda_in

        );


    --------------------------------------------------------------------
    -- TEST SEQUENCE
    --------------------------------------------------------------------

    process

    begin

        ---------------------------------------------------------------
        -- RESET
        ---------------------------------------------------------------

        reset_n <= '0';

        wait for 100 ns;

        reset_n <= '1';

        wait for 100 ns;


        ---------------------------------------------------------------
        -- START I2C TRANSACTION
        ---------------------------------------------------------------

        start <= '1';

        wait for CLK_PERIOD;

        start <= '0';


        ---------------------------------------------------------------
        -- WAIT UNTIL TRANSACTION FINISHES
        ---------------------------------------------------------------

        wait until done = '1';

        wait for 100 ns;


        ---------------------------------------------------------------
        -- END SIMULATION
        ---------------------------------------------------------------

        assert false
            report "I2C transaction completed."
            severity failure;

    end process;


    --------------------------------------------------------------------
    -- SIMPLE SLAVE ACK MODEL
    --
    -- When the master releases SDA during the ACK phase,
    -- this model pulls SDA LOW.
    --------------------------------------------------------------------

    process(scl, sda_out)

    begin

        if scl = '1' and sda_out = '1' then

            sda_in <= '0';

        else

            sda_in <= '1';

        end if;

    end process;


end Behavioral;