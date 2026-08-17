library ieee;
use ieee.std_logic_1164.all;

entity spi_top is
    port (
        CLOCK_50 : in  std_logic;
        KEY0     : in  std_logic;
        SW       : in  std_logic_vector(7 downto 0);
        LEDR     : out std_logic_vector(7 downto 0)
    );
end spi_top;


architecture behavioral of spi_top is

    -- SPI master signals
    signal start_signal : std_logic;
    signal miso_signal  : std_logic;
    signal mosi_signal  : std_logic;
    signal sclk_signal  : std_logic;
    signal cs_signal    : std_logic;

    signal rx_data      : std_logic_vector(7 downto 0);
    signal done_signal  : std_logic;

begin

    ----------------------------------------------------------------
    -- KEY0 is active LOW on the DE10-Lite
    ----------------------------------------------------------------
    start_signal <= not KEY0;


    ----------------------------------------------------------------
    -- SPI LOOPBACK
    --
    -- Whatever the master sends on MOSI comes back on MISO.
    ----------------------------------------------------------------
    miso_signal <= mosi_signal;


    ----------------------------------------------------------------
    -- SPI MASTER
    ----------------------------------------------------------------
    SPI_MASTER : entity work.spi_master
        port map (
            clk     => CLOCK_50,
            reset   => '0',

            start   => start_signal,
            tx_data => SW,

            miso    => miso_signal,

            mosi    => mosi_signal,
            sclk    => sclk_signal,
            cs      => cs_signal,

            rx_data => rx_data,
            done    => done_signal
        );


    ----------------------------------------------------------------
    -- Display received data on LEDs
    ----------------------------------------------------------------
    LEDR <= not rx_data;

end behavioral;