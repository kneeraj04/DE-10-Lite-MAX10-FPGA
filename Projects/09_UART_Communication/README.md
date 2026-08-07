library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Baud_Generator is
    Port(
        clk       : in  STD_LOGIC;
        reset_n   : in  STD_LOGIC;
        baud_tick : out STD_LOGIC
    );
end Baud_Generator;


architecture Behavioral of Baud_Generator is

    constant CLK_FREQ  : integer := 50000000;
    constant BAUD_RATE : integer := 9600;

    constant DIV_COUNT : integer := CLK_FREQ / BAUD_RATE;

    signal count : integer range 0 to DIV_COUNT-1 := 0;

begin

    process(clk, reset_n)

    begin

        if reset_n = '0' then

            count <= 0;
            baud_tick <= '0';

        elsif rising_edge(clk) then


            if count = DIV_COUNT-1 then

                count <= 0;
                baud_tick <= '1';

            else

                count <= count + 1;
                baud_tick <= '0';

            end if;

        end if;

    end process;

end Behavioral;