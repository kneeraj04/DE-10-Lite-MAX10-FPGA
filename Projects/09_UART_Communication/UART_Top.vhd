
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



signal baud_tick : STD_LOGIC;


signal tx_signal : STD_LOGIC;

signal rx_signal : STD_LOGIC;


signal tx_busy : STD_LOGIC;


signal rx_data : STD_LOGIC_VECTOR(7 downto 0);


signal rx_valid : STD_LOGIC;



signal tx_request : STD_LOGIC := '0';



begin


------------------------------------------------
-- Generate transmit request
-- Sends 0x55 repeatedly
------------------------------------------------

process(MAX10_CLK1_50, KEY0)

variable count : integer range 0 to 50000000 :=0;


begin


if KEY0='0' then


    count :=0;

    tx_request <= '0';



elsif rising_edge(MAX10_CLK1_50) then


    if count=50000000 then


        count :=0;

        tx_request <= '1';


    else

        count := count+1;

        tx_request <= '0';


    end if;


end if;


end process;



------------------------------------------------
-- UART TX
------------------------------------------------

TX_INST: entity work.UART_TX

port map(

clk=>MAX10_CLK1_50,

reset_n=>KEY0,

baud_tick=>baud_tick,

tx_start=>tx_request,

tx_data=>"01010101",

tx=>tx_signal,

busy=>tx_busy

);



------------------------------------------------
-- Internal Loopback
------------------------------------------------

rx_signal <= tx_signal;



------------------------------------------------
-- UART RX
------------------------------------------------

RX_INST: entity work.UART_RX

port map(

clk=>MAX10_CLK1_50,

reset_n=>KEY0,

baud_tick=>baud_tick,

rx=>rx_signal,

data_out=>rx_data,

valid=>rx_valid

);



------------------------------------------------
-- Baud Generator
------------------------------------------------

BAUD_INST: entity work.Baud_Generator

port map(

clk=>MAX10_CLK1_50,

reset_n=>KEY0,

baud_tick=>baud_tick

);



------------------------------------------------
-- Display received data
-- LEDs are active LOW
------------------------------------------------

LEDR <= not ("00" & rx_data);



end Behavioral;