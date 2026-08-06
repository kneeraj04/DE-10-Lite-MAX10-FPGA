library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity PWM_LED is

    Port (
        clk      : in  STD_LOGIC;   -- 50 MHz onboard clock
        key0     : in  STD_LOGIC;   -- KEY0 active LOW
        key1     : in  STD_LOGIC;   -- KEY1 active LOW
        led_pwm  : out STD_LOGIC    -- PWM output to LEDR0
    );

end PWM_LED;



architecture Behavioral of PWM_LED is


    -- 10-bit PWM counter
    -- Counts from 0 to 1023
    signal pwm_counter : unsigned(9 downto 0) := (others => '0');


begin


    ------------------------------------------------
    -- PWM Counter Generation
    ------------------------------------------------

    process(clk)

    begin

        if rising_edge(clk) then

            if pwm_counter = 1023 then

                pwm_counter <= (others => '0');

            else

                pwm_counter <= pwm_counter + 1;

            end if;

        end if;

    end process;



    ------------------------------------------------
    -- PWM Duty Cycle Selection
    --
    -- KEY1 pressed --> 100% brightness
    -- KEY0 pressed --> 50% brightness
    -- No key       --> LED OFF
    ------------------------------------------------

    process(pwm_counter, key0, key1)

    begin


        -- KEY1 pressed
        -- Full brightness

        if key1 = '0' then

            led_pwm <= '1';



        -- KEY0 pressed
        -- 50% duty cycle

        elsif key0 = '0' then


            if pwm_counter < 512 then

                led_pwm <= '1';

            else

                led_pwm <= '0';

            end if;



        -- No button pressed

        else

            led_pwm <= '0';


        end if;


    end process;


end Behavioral;