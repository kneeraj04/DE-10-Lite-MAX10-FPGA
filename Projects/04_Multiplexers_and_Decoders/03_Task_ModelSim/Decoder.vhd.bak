library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder is
    Port (
        A  : in  STD_LOGIC;
        B  : in  STD_LOGIC;
        Y0 : out STD_LOGIC;
        Y1 : out STD_LOGIC;
        Y2 : out STD_LOGIC;
        Y3 : out STD_LOGIC
    );
end Decoder;


architecture Behavioral of Decoder is

begin

    process(A,B)
    begin

        case (B & A) is

            when "00" =>
                Y0 <= '1';
                Y1 <= '0';
                Y2 <= '0';
                Y3 <= '0';

            when "01" =>
                Y0 <= '0';
                Y1 <= '1';
                Y2 <= '0';
                Y3 <= '0';

            when "10" =>
                Y0 <= '0';
                Y1 <= '0';
                Y2 <= '1';
                Y3 <= '0';

            when "11" =>
                Y0 <= '0';
                Y1 <= '0';
                Y2 <= '0';
                Y3 <= '1';

            when others =>
                Y0 <= '0';
                Y1 <= '0';
                Y2 <= '0';
                Y3 <= '0';

        end case;

    end process;

end Behavioral;