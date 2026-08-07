library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity UART_Top is

Port(

    MAX10_CLK1_50 : in STD_LOGIC;

    KEY0          : in STD_LOGIC;

    LEDR          : out STD_LOGIC_VECTOR(9 downto 0)

);

end UART_Top;



architecture Behavioral of UART_Top is


------------------------------------------------
-- UART Signals
------------------------------------------------

signal baud_tick : STD_LOGIC;


-- TX line
signal tx_signal : STD_LOGIC;


-- Internal loopback
signal rx_signal : STD_LOGIC;


-- Data signals
signal tx_data : STD_LOGIC_VECTOR(7 downto 0);

signal rx_data : STD_LOGIC_VECTOR(7 downto 0);



-- TX control
signal tx_request : STD_LOGIC := '0';

signal tx_busy : STD_LOGIC;



-- RX status
signal rx_valid : STD_LOGIC;



begin


------------------------------------------------
-- Data to transmit
------------------------------------------------

tx_data <= "01010101";



------------------------------------------------
-- Baud Generator
------------------------------------------------

BAUD_INST : entity work.Baud_Generator

port map(

    clk       => MAX10_CLK1_50,

    reset_n   => KEY0,

    baud_tick => baud_tick

);



------------------------------------------------
-- UART TX
------------------------------------------------

TX_INST : entity work.UART_TX

port map(

    clk       => MAX10_CLK1_50,

    reset_n   => KEY0,

    baud_tick => baud_tick,

    tx_start  => tx_request,

    tx_data   => tx_data,

    tx        => tx_signal,

    busy      => tx_busy

);



------------------------------------------------
-- Internal Loopback
------------------------------------------------

rx_signal <= tx_signal;



------------------------------------------------
-- UART RX
------------------------------------------------

RX_INST : entity work.UART_RX

port map(

    clk       => MAX10_CLK1_50,

    reset_n   => KEY0,

    baud_tick => baud_tick,

    rx        => rx_signal,

    data_out  => rx_data,

    valid     => rx_valid

);



------------------------------------------------
-- TX Request Generator
--
-- Generate transmission every 1 second
--
-- tx_request remains HIGH until
-- UART_TX accepts the request
------------------------------------------------

process(MAX10_CLK1_50, KEY0)

variable count : integer range 0 to 50000000 := 0;


begin


    if KEY0 = '0' then

        count := 0;

        tx_request <= '0';



    elsif rising_edge(MAX10_CLK1_50) then



        ------------------------------------------------
        -- After 1 second request transmission
        ------------------------------------------------

        if count = 50000000 then


            count := 0;

            tx_request <= '1';



        ------------------------------------------------
        -- UART has started transmission
        ------------------------------------------------

        elsif tx_busy = '1' then


            tx_request <= '0';



        else


            count := count + 1;


        end if;


    end if;


end process;



------------------------------------------------
-- Display received UART data
--
-- DE10-Lite LEDs are ACTIVE LOW
--
-- rx_data = 01010101
--
-- LED output = 10101010
--
-- LEDs:
-- OFF ON OFF ON OFF ON OFF ON
------------------------------------------------

LEDR(7 downto 0) <= not rx_data;



-- Unused LEDs OFF

LEDR(9 downto 8) <= "11";



end Behavioral;