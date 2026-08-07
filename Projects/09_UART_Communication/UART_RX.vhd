library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity UART_RX is

Port(

    clk       : in STD_LOGIC;  -- FPGA clock
    reset_n   : in STD_LOGIC;  -- Active LOW reset

    baud_tick : in STD_LOGIC;  -- UART timing pulse

    rx        : in STD_LOGIC;  -- Serial RX input

    data_out  : out STD_LOGIC_VECTOR(7 downto 0); -- Received byte

    valid     : out STD_LOGIC  -- Indicates new byte received

);

end UART_RX;



architecture Behavioral of UART_RX is


-- UART receiver states
type state_type is
(
    IDLE,       -- Waiting for start bit
    START_BIT,  -- Start bit detected
    DATA_BITS,  -- Receiving 8 data bits
    STOP_BIT    -- Receiving stop bit
);


signal state : state_type := IDLE;


-- Stores received byte
signal data_reg : STD_LOGIC_VECTOR(7 downto 0);


-- Counts received bits
signal bit_count : integer range 0 to 7 := 0;



begin


process(clk, reset_n)

begin


    ------------------------------------------------
    -- RESET
    ------------------------------------------------

    if reset_n = '0' then

        state     <= IDLE;

        data_reg  <= (others => '0');

        data_out  <= (others => '0');

        bit_count <= 0;

        valid     <= '0';



    elsif rising_edge(clk) then


        -- valid is normally LOW
        -- It becomes HIGH for one clock when
        -- a complete byte has been received.

        valid <= '0';



        ------------------------------------------------
        -- UART timing
        ------------------------------------------------

        if baud_tick = '1' then


            case state is



                ------------------------------------------------
                -- IDLE
                ------------------------------------------------

                when IDLE =>

                    -- UART start bit is LOW

                    if rx = '0' then

                        state <= START_BIT;

                    end if;



                ------------------------------------------------
                -- START BIT
                ------------------------------------------------

                when START_BIT =>

                    -- Start bit has occupied one baud period.
                    -- Now prepare to receive D0.

                    bit_count <= 0;

                    state <= DATA_BITS;



                ------------------------------------------------
                -- DATA BITS
                ------------------------------------------------

                when DATA_BITS =>

                    -- UART sends LSB first.
                    -- Therefore first received bit goes to bit 0.

                    data_reg(bit_count) <= rx;


                    if bit_count = 7 then

                        -- All 8 bits received

                        state <= STOP_BIT;


                    else

                        -- Move to next bit

                        bit_count <= bit_count + 1;

                    end if;



                ------------------------------------------------
                -- STOP BIT
                ------------------------------------------------

                when STOP_BIT =>

                    -- Transfer received byte to output

                    data_out <= data_reg;

                    -- Tell the top module that a new byte
                    -- has been completely received

                    valid <= '1';

                    -- Ready for next UART frame

                    state <= IDLE;



            end case;


        end if;


    end if;


end process;


end Behavioral;