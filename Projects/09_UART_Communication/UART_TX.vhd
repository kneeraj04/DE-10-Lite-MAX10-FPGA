library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity UART_TX is

Port(

    clk       : in STD_LOGIC; -- FPGA clock
    reset_n   : in STD_LOGIC; -- Active LOW reset

    baud_tick : in STD_LOGIC; -- Timing pulse from baud generator

    tx_start  : in STD_LOGIC; -- Start transmission command
    tx_data   : in STD_LOGIC_VECTOR(7 downto 0); -- Data byte

    tx        : out STD_LOGIC; -- UART serial output
    busy      : out STD_LOGIC  -- Transmission status

);

end UART_TX;



architecture Behavioral of UART_TX is


type state_type is
(
    IDLE,       -- Waiting for data
    START_BIT,  -- Send start bit = 0
    DATA_BITS,  -- Send 8 data bits
    STOP_BIT    -- Send stop bit = 1
);


signal state : state_type := IDLE;


signal data_reg : STD_LOGIC_VECTOR(7 downto 0);


-- Counts transmitted bits
signal bit_count : integer range 0 to 7 :=0;



begin



process(clk,reset_n)

begin


if reset_n='0' then

    state <= IDLE;

    tx <= '1';       -- UART idle state

    busy <= '0';

    bit_count <= 0;



elsif rising_edge(clk) then



    -- Change UART output only at baud timing
    if baud_tick='1' then


        case state is



        when IDLE =>


            tx <= '1';

            busy <= '0';


            -- Start new transmission
            if tx_start='1' then

                data_reg <= tx_data;

                state <= START_BIT;

                busy <= '1';

            end if;



        when START_BIT =>


            -- UART frame starts with LOW bit
            tx <= '0';

            bit_count <= 0;

            state <= DATA_BITS;




        when DATA_BITS =>


            -- Send LSB first
            tx <= data_reg(bit_count);



            if bit_count=7 then

                state <= STOP_BIT;

            else

                bit_count <= bit_count + 1;

            end if;




        when STOP_BIT =>


            -- UART frame ends with HIGH stop bit
            tx <= '1';

            busy <= '0';

            bit_count <= 0;

            state <= IDLE;



        end case;


    end if;


end if;


end process;


end Behavioral;