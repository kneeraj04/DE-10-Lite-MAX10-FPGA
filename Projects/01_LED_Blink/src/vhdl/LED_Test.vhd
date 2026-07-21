library IEEE;   --standard library for VHDL
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity LED_Test is

port (
	
	 clk : in std_logic;   --50MHz Clock input
    led : out std_logic  --EXTERN connect FPGA pin to LED
);

end LED_Test;

architecture Behavioral of LED_Test is

    signal counter : unsigned(27 downto 0) := (others => '0');
    signal led_state : std_logic := '0';

begin

    process (clk)
	 
    begin
	 
		  if rising_edge (clk) then
		  
			if counter = 149999999 then
			
				counter <= (others => '0');
            led_state <= not led_state;

          else

                counter <= counter + 1;
					 
			 end if;
			end if ;
    end process;
	 
	  led <= not led_state;

end Behavioral;