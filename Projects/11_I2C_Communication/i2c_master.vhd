library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity i2c_master is
    port (
        clk        : in    std_logic;
        reset      : in    std_logic;
        start      : in    std_logic;

        slave_addr : in    std_logic_vector(6 downto 0);
        data_in    : in    std_logic_vector(7 downto 0);

        scl        : out   std_logic;
        sda        : inout std_logic;

        busy       : out   std_logic;
        done       : out   std_logic;
        ack_error  : out   std_logic
    );
end i2c_master;


architecture behavioral of i2c_master is

    ----------------------------------------------------------------
    -- I2C MASTER FSM STATES
    ----------------------------------------------------------------
    type state_type is (
        IDLE,
        START_COND,
        SEND_ADDRESS,
        ADDRESS_ACK,
        SEND_DATA,
        DATA_ACK,
        STOP_COND
    );

    signal state : state_type := IDLE;


    ----------------------------------------------------------------
    -- DATA REGISTERS
    ----------------------------------------------------------------
    signal address_reg : std_logic_vector(7 downto 0);
    signal data_reg    : std_logic_vector(7 downto 0);

    signal bit_count : integer range 0 to 7 := 7;


    ----------------------------------------------------------------
    -- I2C SIGNAL CONTROL
    ----------------------------------------------------------------
    signal scl_reg : std_logic := '1';

    -- '1' = pull SDA LOW
    -- '0' = release SDA
    signal sda_low : std_logic := '0';


begin

    ----------------------------------------------------------------
    -- SCL OUTPUT
    ----------------------------------------------------------------
    scl <= scl_reg;


    ----------------------------------------------------------------
    -- SDA OPEN-DRAIN STYLE OUTPUT
    ----------------------------------------------------------------
    sda <= '0' when sda_low = '1' else 'Z';


    ----------------------------------------------------------------
    -- MAIN I2C FSM
    ----------------------------------------------------------------
    process(clk)
    begin

        if rising_edge(clk) then

            --------------------------------------------------------
            -- RESET
            --------------------------------------------------------
            if reset = '1' then

                state <= IDLE;

                scl_reg <= '1';
                sda_low <= '0';

                busy      <= '0';
                done      <= '0';
                ack_error <= '0';

                address_reg <= (others => '0');
                data_reg    <= (others => '0');

                bit_count <= 7;


            --------------------------------------------------------
            -- NORMAL OPERATION
            --------------------------------------------------------
            else

                -- DONE is normally LOW
                done <= '0';


                case state is


                    ------------------------------------------------
                    -- IDLE
                    ------------------------------------------------
                    when IDLE =>

                        scl_reg <= '1';
                        sda_low <= '0';

                        busy <= '0';

                        if start = '1' then

                            -- Combine 7-bit address + WRITE bit
                            address_reg <= slave_addr & '0';

                            data_reg <= data_in;

                            bit_count <= 7;

                            busy <= '1';

                            state <= START_COND;

                        end if;


                    ------------------------------------------------
                    -- START CONDITION
                    ------------------------------------------------
                    when START_COND =>

                        -- SCL HIGH
                        -- SDA HIGH -> LOW

                        scl_reg <= '1';
                        sda_low <= '1';

                        state <= SEND_ADDRESS;


                    ------------------------------------------------
                    -- SEND ADDRESS
                    ------------------------------------------------
                    when SEND_ADDRESS =>

                        -- SCL LOW

                        scl_reg <= '0';


                        -- Send current address bit

                        if address_reg(bit_count) = '0' then

                            sda_low <= '1';

                        else

                            sda_low <= '0';

                        end if;


                        state <= ADDRESS_ACK;


                    ------------------------------------------------
                    -- ADDRESS ACK
                    ------------------------------------------------
                    when ADDRESS_ACK =>

                        -- Release SDA

                        sda_low <= '0';


                        -- SCL HIGH

                        scl_reg <= '1';


                        -- For this simple simulation,
                        -- assume slave ACK is received.

                        if bit_count = 0 then

                            bit_count <= 7;

                            state <= SEND_DATA;

                        else

                            bit_count <= bit_count - 1;

                            state <= SEND_ADDRESS;

                        end if;


                    ------------------------------------------------
                    -- SEND DATA
                    ------------------------------------------------
                    when SEND_DATA =>

                        -- SCL LOW

                        scl_reg <= '0';


                        -- Send current data bit

                        if data_reg(bit_count) = '0' then

                            sda_low <= '1';

                        else

                            sda_low <= '0';

                        end if;


                        state <= DATA_ACK;


                    ------------------------------------------------
                    -- DATA ACK
                    ------------------------------------------------
                    when DATA_ACK =>

                        -- Release SDA

                        sda_low <= '0';


                        -- SCL HIGH

                        scl_reg <= '1';


                        -- Assume ACK

                        if bit_count = 0 then

                            state <= STOP_COND;

                        else

                            bit_count <= bit_count - 1;

                            state <= SEND_DATA;

                        end if;


                    ------------------------------------------------
                    -- STOP CONDITION
                    ------------------------------------------------
                    when STOP_COND =>

                        -- SCL HIGH
                        -- SDA LOW -> HIGH

                        scl_reg <= '1';
                        sda_low <= '0';

                        busy <= '0';

                        done <= '1';

                        state <= IDLE;


                end case;

            end if;

        end if;

    end process;

end behavioral;