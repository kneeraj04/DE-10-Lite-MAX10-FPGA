library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity UART_Top is


Port(

    MAX10_CLK1_50 : in STD_LOGIC;

    KEY0 : in STD_LOGIC;

    LEDR0 : out STD_LOGIC


);


end UART_Top;



architecture Behavioral of UART_Top is



signal baud_tick : STD_LOGIC;


signal tx_signal : STD_LOGIC;

signal rx_signal : STD_LOGIC;


signal tx_busy : STD_LOGIC;


signal tx_start : STD_LOGIC;


signal rx_valid : STD_LOGIC;


signal rx_data : STD_LOGIC_VECTOR(7 downto 0);



signal counter : integer range 0 to 50000000 :=0;



begin


-- UART loopback

rx_signal <= tx_signal;



-- send command periodically

process(MAX10_CLK1_50, KEY0)

begin


if KEY0='0' then


    counter <=0;
    tx_start <= '0';



elsif rising_edge(MAX10_CLK1_50) then


    if counter=50000000 then

        counter <=0;
        tx_start <= '1';

    else

        counter <= counter+1;
        tx_start <= '0';

    end if;


end if;


end process;



UART_TX_INST: entity work.UART_TX

port map(

clk=>MAX10_CLK1_50,
reset_n=>KEY0,
baud_tick=>baud_tick,

tx_start=>tx_start,

tx_data=>"01010101",

tx=>tx_signal,

tx_busy=>tx_busy

);



UART_RX_INST: entity work.UART_RX

port map(

clk=>MAX10_CLK1_50,
reset_n=>KEY0,

baud_tick=>baud_tick,

rx=>rx_signal,

rx_data=>rx_data,

rx_valid=>rx_valid

);



BAUD_INST: entity work.Baud_Generator

port map(

clk=>MAX10_CLK1_50,

reset_n=>KEY0,

baud_tick=>baud_tick

);



-- LED active LOW

LEDR0 <= not rx_valid;

end Behavioral;