library IEEE;   //standard library for VHDL
use IEEE.STD_LOGIC_1164.ALL;

entity LED_Test is

port (
    led : out std_logic  //EXTERN connect FPGA pin to LED
);

end LED_Test;

architecture Behavioral of LED_Test is

begin

    process
    begin
        led <= '1';
        wait for 1000 ms;
        led <= '0';
        wait for 1000 ms;

    end process;

end Behavioral;