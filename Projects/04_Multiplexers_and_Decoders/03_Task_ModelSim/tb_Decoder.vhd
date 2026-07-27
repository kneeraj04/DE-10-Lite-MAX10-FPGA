library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity tb_Decoder is
end tb_Decoder;


architecture simulation of tb_Decoder is


component Decoder

Port (
        A  : in  STD_LOGIC;
        B  : in  STD_LOGIC;
        Y0 : out STD_LOGIC;
        Y1 : out STD_LOGIC;
        Y2 : out STD_LOGIC;
        Y3 : out STD_LOGIC
);

end component;


signal A : STD_LOGIC := '0';
signal B : STD_LOGIC := '0';

signal Y0 : STD_LOGIC;
signal Y1 : STD_LOGIC;
signal Y2 : STD_LOGIC;
signal Y3 : STD_LOGIC;


begin


DUT: decoder2to4

port map(

A => A,
B => B,

Y0 => Y0,
Y1 => Y1,
Y2 => Y2,
Y3 => Y3

);


stimulus: process

begin


-- Input 00

A <= '0';
B <= '0';

wait for 10 ns;



-- Input 01

A <= '1';
B <= '0';

wait for 10 ns;



-- Input 10

A <= '0';
B <= '1';

wait for 10 ns;



-- Input 11

A <= '1';
B <= '1';

wait for 10 ns;



wait;

end process;


end simulation;