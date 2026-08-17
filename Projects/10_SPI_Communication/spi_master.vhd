library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity spi_master is
    port (
        clk       : in  std_logic;                       -- 50 MHz clock
        reset     : in  std_logic;                       -- active HIGH reset
        start     : in  std_logic;                       -- start transmission
        tx_data   : in  std_logic_vector(7 downto 0);   -- data to transmit

        miso      : in  std_logic;                       -- slave -> master
        mosi      : out std_logic;                       -- master -> slave
        sclk      : out std_logic;                       -- SPI clock
        cs        : out std_logic;                       -- chip select

        rx_data   : out std_logic_vector(7 downto 0);   -- received data
        done      : out std_logic                        -- transmission complete
    );
end spi_master;


architecture behavioral of spi_master is

    -- 50 MHz / (2 * 25) = 1 MHz SPI clock
    constant CLK_DIV : integer := 25;

    signal clk_count : integer range 0 to CLK_DIV-1 := 0;

    signal spi_clk   : std_logic := '0';
    signal cs_reg    : std_logic := '1';

    signal tx_reg    : std_logic_vector(7 downto 0) := (others => '0');
    signal rx_reg    : std_logic_vector(7 downto 0) := (others => '0');

    signal bit_count : integer range 0 to 7 := 7;

    signal busy      : std_logic := '0';
    signal done_reg  : std_logic := '0';

begin

    sclk    <= spi_clk;
    cs      <= cs_reg;
    rx_data <= rx_reg;
    done    <= done_reg;

    -- MOSI sends the current MSB
    mosi <= tx_reg(7);


    process(clk, reset)
    begin

        if reset = '1' then

            clk_count <= 0;
            spi_clk   <= '0';
            cs_reg    <= '1';

            tx_reg    <= (others => '0');
            rx_reg    <= (others => '0');

            bit_count <= 7;

            busy      <= '0';
            done_reg  <= '0';

        elsif rising_edge(clk) then

            -- DONE is normally LOW
            done_reg <= '0';

            -- Start a new SPI transmission
            if start = '1' and busy = '0' then

                tx_reg    <= tx_data;
                rx_reg    <= (others => '0');

                bit_count <= 7;

                cs_reg    <= '0';
                spi_clk   <= '0';

                busy      <= '1';

                clk_count <= 0;

            elsif busy = '1' then

                -- Clock divider
                if clk_count = CLK_DIV-1 then

                    clk_count <= 0;

                    -- Rising edge of SPI clock
                    if spi_clk = '0' then

                        spi_clk <= '1';

                        -- Sample MISO
                        rx_reg(bit_count) <= miso;

                    -- Falling edge of SPI clock
                    else

                        spi_clk <= '0';

                        -- Last bit transmitted
                        if bit_count = 0 then

                            cs_reg   <= '1';
                            busy     <= '0';
                            done_reg <= '1';

                        else

                            -- Move to next bit
                            bit_count <= bit_count - 1;

                            -- Shift transmitter
                            tx_reg <= tx_reg(6 downto 0) & '0';

                        end if;

                    end if;

                else

                    clk_count <= clk_count + 1;

                end if;

            end if;

        end if;

    end process;

end behavioral;