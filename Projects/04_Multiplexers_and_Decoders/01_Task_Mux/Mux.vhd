library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux is
    Port (
        SW   : in  STD_LOGIC_VECTOR(5 downto 0);
        LEDR : out STD_LOGIC_VECTOR(0 downto 0)
    );
end Mux;

architecture Behavioral of MUX4to1 is
begin

    process(SW)
    begin
        case SW(5 downto 4) is      -- S1 S0
            when "00" =>
                LEDR(0) <= SW(0);

            when "01" =>
                LEDR(0) <= SW(1);

            when "10" =>
                LEDR(0) <= SW(2);

            when "11" =>
                LEDR(0) <= SW(3);

            when others =>
                LEDR(0) <= '0';
        end case;
    end process;

end Behavioral;