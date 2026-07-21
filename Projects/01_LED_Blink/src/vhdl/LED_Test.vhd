library IEEE;                           -- Standard VHDL library
use IEEE.STD_LOGIC_1164.ALL;            -- Defines std_logic data type
use IEEE.NUMERIC_STD.ALL;               -- Required for unsigned counters

entity LED_Test is

port (

    clk : in std_logic;                 -- 50 MHz onboard clock
    led : out std_logic                 -- Output connected to LEDR0

);

end LED_Test;

architecture Behavioral of LED_Test is

    -- Counter to create a 3-second delay
    signal counter : unsigned(27 downto 0) := (others => '0');

    -- Stores current LED state (ON/OFF)
    signal led_state : std_logic := '0';

begin

    -- Process executes on every clock edge
    process(clk)

    begin

        -- Execute only on the rising edge of the clock
        if rising_edge(clk) then

            -- Check if 3 seconds have elapsed
            if counter = 149999999 then

                -- Reset counter
                counter <= (others => '0');

                -- Toggle LED state
                led_state <= not led_state;

            else

                -- Increment counter every clock cycle
                counter <= counter + 1;

            end if;

        end if;

    end process;

    -- DE10-Lite LEDs are active LOW
    led <= not led_state;

end Behavioral;