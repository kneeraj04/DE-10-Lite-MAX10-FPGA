
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity UART_TX is

Port(

    clk       : in STD_LOGIC;
    reset_n   : in STD_LOGIC;

    baud_tick : in STD_LOGIC;

    tx_start  : in STD_LOGIC;
    tx_data   : in STD_LOGIC_VECTOR(7 downto 0);

    tx        : out STD_LOGIC;
    busy      : out STD_LOGIC

);

end UART_TX;



architecture Behavioral of UART_TX is


type state_type is
(
    IDLE,
    START_BIT,
    DATA_BITS,
    STOP_BIT
);


signal state : state_type := IDLE;


signal data_reg : STD_LOGIC_VECTOR(7 downto 0);

signal bit_count : integer range 0 to 7 :=0;


begin



process(clk, reset_n)

begin


if reset_n='0' then


    state <= IDLE;

    tx <= '1';

    busy <= '0';



elsif rising_edge(clk) then



    if baud_tick='1' then



        case state is



        when IDLE =>


            tx <= '1';

            busy <= '0';



            if tx_start='1' then


                data_reg <= tx_data;

                state <= START_BIT;

                busy <= '1';


            end if;




        when START_BIT =>


            tx <= '0';

            bit_count <= 0;

            state <= DATA_BITS;




        when DATA_BITS =>


            tx <= data_reg(bit_count);



            if bit_count=7 then

                state <= STOP_BIT;


            else

                bit_count <= bit_count+1;


            end if;




        when STOP_BIT =>


            tx <= '1';

            state <= IDLE;



        end case;



    end if;



end if;


end process;



end Behavioral;