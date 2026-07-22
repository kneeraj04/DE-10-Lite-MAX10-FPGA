library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Date_Display is
    Port (

        --On each segment display has 7 LEDs with decimal point---
        HEX0 : out STD_LOGIC_VECTOR(7 downto 0); -- Year (ones)
        HEX1 : out STD_LOGIC_VECTOR(7 downto 0); -- Year (tens)
        HEX2 : out STD_LOGIC_VECTOR(7 downto 0); -- Month (ones)
        HEX3 : out STD_LOGIC_VECTOR(7 downto 0); -- Month (tens)
        HEX4 : out STD_LOGIC_VECTOR(7 downto 0); -- Day (ones)
        HEX5 : out STD_LOGIC_VECTOR(7 downto 0)  -- Day (tens)
    );
end Date_Display;

architecture Behavioral of Date_Display is

    -- Digit to 7-segment decoder

    function SevenSeg(digit : integer) return STD_LOGIC_VECTOR is
    begin
        case digit is
            when 0 => return "11000000"; -- 0
            when 1 => return "11111001"; -- 1
            when 2 => return "10100100"; -- 2
            when 3 => return "10110000"; -- 3
            when 4 => return "10011001"; -- 4
            when 5 => return "10010010"; -- 5
            when 6 => return "10000010"; -- 6
            when 7 => return "11111000"; -- 7
            when 8 => return "10000000"; -- 8
            when 9 => return "10010000"; -- 9
            when others => return "11111111"; -- Blank
        end case;
    end function;

begin

    -- Example Birth Date : 04-01-96 (DD-MM-YY)

    HEX5 <= SevenSeg(0); -- DD (tens)
    HEX4 <= SevenSeg(4); -- DD (ones)

    HEX3 <= SevenSeg(0); -- MM (tens)
    HEX2 <= SevenSeg(1); -- MM (ones)

    HEX1 <= SevenSeg(9); -- YY (tens)
    HEX0 <= SevenSeg(6); -- YY (ones)

end Behavioral;