library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity UART_RX is

Port(

    clk        : in STD_LOGIC;
    reset_n    : in STD_LOGIC;

    baud_tick  : in STD_LOGIC;

    rx         : in STD_LOGIC;

    rx_data    : out STD_LOGIC_VECTOR(7 downto 0);

    rx_valid   : out STD_LOGIC

);

end UART_RX;



architecture Behavioral of UART_RX is


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
    rx_valid <= '0';



elsif rising_edge(clk) then


    rx_valid <= '0';



    if baud_tick='1' then


        case state is



        when IDLE =>


            if rx='0' then

                state <= START_BIT;

            end if;



        when START_BIT =>


            state <= DATA_BITS;
            bit_count <=0;



        when DATA_BITS =>


            data_reg(bit_count) <= rx;


            if bit_count=7 then

                state <= STOP_BIT;

            else

                bit_count <= bit_count+1;

            end if;



        when STOP_BIT =>


            rx_data <= data_reg;

            rx_valid <= '1';

            state <= IDLE;



        end case;


    end if;


end if;


end process;


end Behavioral;