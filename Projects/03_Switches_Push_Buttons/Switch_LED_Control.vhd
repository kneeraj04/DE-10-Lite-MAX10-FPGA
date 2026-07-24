library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Switch_LED_Control is

    Port (
        SW   : in  STD_LOGIC_VECTOR(9 downto 0);  -- Slide switches
        KEY  : in  STD_LOGIC_VECTOR(1 downto 0);  -- Push buttons
        LEDR : out STD_LOGIC_VECTOR(9 downto 0)   -- Red LEDs
    );

end Switch_LED_Control;


architecture Behavioral of Switch_LED_Control is

begin

    -- Switches directly control LEDs
    LEDR(0) <= SW(0);  
    LEDR(1) <= SW(1);  
    LEDR(2) <= SW(2);  
    LEDR(3) <= SW(3);  
    LEDR(4) <= SW(4);  
    LEDR(5) <= SW(5);  
    LEDR(6) <= SW(6);  
    LEDR(7) <= SW(7);  

    -- Push buttons are active LOW, therefore inverted
    LEDR(8) <= NOT KEY(0);  -- KEY0 pressed -> LEDR8 ON
    LEDR(9) <= NOT KEY(1);  -- KEY1 pressed -> LEDR9 ON


end Behavioral;