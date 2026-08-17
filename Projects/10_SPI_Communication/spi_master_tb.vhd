library ieee;
use ieee.std_logic_1164.all;

entity spi_master_tb is
end spi_master_tb;

architecture behavior of spi_master_tb is

    -- Component declaration
    component spi_master
        port (
            clk       : in  std_logic;
            reset     : in  std_logic;
            start     : in  std_logic;
            tx_data   : in  std_logic_vector(7 downto 0);

            miso      : in  std_logic;
            mosi      : out std_logic;
            sclk      : out std_logic;
            cs        : out std_logic;

            rx_data   : out std_logic_vector(7 downto 0);
            done      : out std_logic
        );
    end component;

    -- Signals
    signal clk       : std_logic := '0';
    signal reset     : std_logic := '1';
    signal start     : std_logic := '0';

    signal tx_data   : std_logic_vector(7 downto 0) := "10110010";

    signal miso      : std_logic := '0';
    signal mosi      : std_logic;
    signal sclk      : std_logic;
    signal cs        : std_logic;

    signal rx_data   : std_logic_vector(7 downto 0);
    signal done      : std_logic;

begin

    -- Instantiate SPI master
    DUT : spi_master
        port map (
            clk       => clk,
            reset     => reset,
            start     => start,
            tx_data   => tx_data,

            miso      => miso,
            mosi      => mosi,
            sclk      => sclk,
            cs        => cs,

            rx_data   => rx_data,
            done      => done
        );


    -- 50 MHz clock
    clk <= not clk after 10 ns;


    -- Test sequence
    process
    begin

        -- Reset
        reset <= '1';
        wait for 100 ns;

        reset <= '0';
        wait for 100 ns;

        -- Start SPI transmission
        start <= '1';
        wait for 20 ns;
        start <= '0';

        -- Wait until transmission finishes
        wait until done = '1';

        wait for 100 ns;

        -- Stop simulation
        assert false
            report "SPI TEST FINISHED"
            severity failure;

    end process;


    -- Simple SPI slave
    process
    begin

        wait until cs = '0';

        -- Send 01011011 through MISO
        miso <= '0';
        wait until sclk = '0';

        miso <= '1';
        wait until sclk = '1';

        miso <= '0';
        wait until sclk = '0';

        miso <= '1';
        wait until sclk = '1';

        miso <= '1';
        wait until sclk = '0';

        miso <= '0';
        wait until sclk = '1';

        miso <= '1';
        wait until sclk = '0';

        miso <= '1';

        wait until cs = '1';

    end process;

end behavior;