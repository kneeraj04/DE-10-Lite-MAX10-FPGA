library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity led_alternating is

    Port (
        CLOCK_50 : in  STD_LOGIC;              -- 50 MHz board clock
        LEDR     : out STD_LOGIC_VECTOR(9 downto 0) -- 10 LEDs
    );

end led_alternating;



architecture Behavioral of led_alternating is


    signal counter : unsigned(25 downto 0) := (others=>'0'); -- clock counter
    signal led_pos : unsigned(3 downto 0) := "0000";          -- LED number


begin


    -- Creates 1 second delay and changes LED position
    process(CLOCK_50)

    begin

        if rising_edge(CLOCK_50) then             -- execute on clock edge


            if counter = 50_000_000-1 then        -- wait 1 second

                counter <= (others=>'0');         -- reset counter


                if led_pos = 9 then               -- if LED9 reached

                    led_pos <= "0000";            -- go back to LED0

                else

                    led_pos <= led_pos + 1;       -- next LED

                end if;


            else

                counter <= counter + 1;            -- count clock cycles

            end if;


        end if;

    end process;



    -- Converts LED position into LED output
    process(led_pos)

    begin

        LEDR <= (others=>'0');                    -- turn OFF all LEDs


        case led_pos is

            when "0000" => LEDR(0) <= '1';        -- LED0 ON
            when "0001" => LEDR(1) <= '1';        -- LED1 ON
            when "0010" => LEDR(2) <= '1';        -- LED2 ON
            when "0011" => LEDR(3) <= '1';        -- LED3 ON
            when "0100" => LEDR(4) <= '1';        -- LED4 ON
            when "0101" => LEDR(5) <= '1';        -- LED5 ON
            when "0110" => LEDR(6) <= '1';        -- LED6 ON
            when "0111" => LEDR(7) <= '1';        -- LED7 ON
            when "1000" => LEDR(8) <= '1';        -- LED8 ON
            when "1001" => LEDR(9) <= '1';        -- LED9 ON

            when others => LEDR <= (others=>'0'); -- safety case

        end case;

    end process;


end Behavioral;