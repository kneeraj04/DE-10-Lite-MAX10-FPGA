library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;          -- Required for unsigned arithmetic

entity RunningLED is
    Port (
        CLK50 : in  STD_LOGIC;                     -- 50 MHz onboard clock
        LEDR  : out STD_LOGIC_VECTOR(9 downto 0)  -- 10 user LEDs
    );
end RunningLED;

architecture Behavioral of RunningLED is

    -- Counts the 50 MHz clock to create a slower timing signal
    signal div_counter : unsigned(25 downto 0) := (others => '0');

    -- Stores the currently active LED number (0 to 9)
    signal led_index : unsigned(3 downto 0) := (others => '0');

begin

    -- Sequential process: Executes on every rising edge of the clock
    process(CLK50)
    begin
        if rising_edge(CLK50) then

            -- Increment the clock divider counter every clock cycle
            div_counter <= div_counter + 1;

            -- After 50 million clock cycles (~1 second)
            if div_counter = 49999999 then

                -- Reset divider counter for the next second
                div_counter <= (others => '0');

                -- Move to the next LED
                if led_index = 9 then
                    -- Restart from LED0 after LED9
                    led_index <= (others => '0');
                else
                    -- Select the next LED
                    led_index <= led_index + 1;
                end if;

            end if;

        end if;
    end process;

    -- Combinational process: Turns ON only one LED
    process(led_index)
    begin

        -- Turn OFF all LEDs first
        LEDR <= (others => '0');

        -- Turn ON the selected LED
        case to_integer(led_index) is
            when 0 => LEDR(0) <= '1';
            when 1 => LEDR(1) <= '1';
            when 2 => LEDR(2) <= '1';
            when 3 => LEDR(3) <= '1';
            when 4 => LEDR(4) <= '1';
            when 5 => LEDR(5) <= '1';
            when 6 => LEDR(6) <= '1';
            when 7 => LEDR(7) <= '1';
            when 8 => LEDR(8) <= '1';
            when 9 => LEDR(9) <= '1';
            when others => null;
        end case;

    end process;

end Behavioral;