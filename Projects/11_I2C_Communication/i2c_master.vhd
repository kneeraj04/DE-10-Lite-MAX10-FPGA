library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity i2c_master is

    generic (
        CLK_DIV : integer := 4
    );

    port (
        clk        : in  std_logic;
        reset_n    : in  std_logic;

        start      : in  std_logic;
        slave_addr : in  std_logic_vector(6 downto 0);
        data_in    : in  std_logic_vector(7 downto 0);

        busy       : out std_logic;
        done       : out std_logic;

        scl        : out std_logic;
        sda_out    : out std_logic;
        sda_in     : in  std_logic
    );

end i2c_master;


architecture Behavioral of i2c_master is

    --------------------------------------------------------------------
    -- I2C MASTER STATES
    --------------------------------------------------------------------

    type state_type is (
        IDLE,
        START_CONDITION,

        ADDRESS_LOW,
        ADDRESS_HIGH,
        ADDRESS_ACK,

        DATA_LOW,
        DATA_HIGH,
        DATA_ACK,

        STOP_CONDITION,

        DONE_STATE
    );

    signal state : state_type := IDLE;


    --------------------------------------------------------------------
    -- CLOCK DIVIDER
    --------------------------------------------------------------------

    signal clk_count : integer range 0 to CLK_DIV-1 := 0;
    signal tick      : std_logic := '0';


    --------------------------------------------------------------------
    -- I2C OUTPUT REGISTERS
    --------------------------------------------------------------------

    signal scl_reg : std_logic := '1';
    signal sda_reg : std_logic := '1';


    --------------------------------------------------------------------
    -- DATA REGISTERS
    --------------------------------------------------------------------

    signal address_reg : std_logic_vector(7 downto 0);
    signal data_reg    : std_logic_vector(7 downto 0);

    signal bit_count : integer range 0 to 7 := 7;

begin

    --------------------------------------------------------------------
    -- OUTPUTS
    --------------------------------------------------------------------

    scl     <= scl_reg;
    sda_out <= sda_reg;

    busy <= '1' when state /= IDLE and state /= DONE_STATE else '0';

    done <= '1' when state = DONE_STATE else '0';


    --------------------------------------------------------------------
    -- CLOCK DIVIDER
    --
    -- Simulation:
    --
    -- FPGA clock = 10 ns
    -- CLK_DIV    = 4
    --
    -- One I2C timing tick occurs every 4 FPGA clock cycles.
    --------------------------------------------------------------------

    process(clk, reset_n)

    begin

        if reset_n = '0' then

            clk_count <= 0;
            tick      <= '0';

        elsif rising_edge(clk) then

            if clk_count = CLK_DIV-1 then

                clk_count <= 0;
                tick      <= '1';

            else

                clk_count <= clk_count + 1;
                tick      <= '0';

            end if;

        end if;

    end process;


    --------------------------------------------------------------------
    -- I2C MASTER FSM
    --------------------------------------------------------------------

    process(clk, reset_n)

    begin

        if reset_n = '0' then

            state       <= IDLE;

            scl_reg     <= '1';
            sda_reg     <= '1';

            address_reg <= (others => '0');
            data_reg    <= (others => '0');

            bit_count   <= 7;


        elsif rising_edge(clk) then

            if tick = '1' then

                case state is


                    ----------------------------------------------------
                    -- IDLE
                    ----------------------------------------------------

                    when IDLE =>

                        scl_reg <= '1';
                        sda_reg <= '1';

                        if start = '1' then

                            -- Address + WRITE bit
                            address_reg <= slave_addr & '0';

                            -- Store data
                            data_reg <= data_in;

                            -- Start from MSB
                            bit_count <= 7;

                            state <= START_CONDITION;

                        end if;


                    ----------------------------------------------------
                    -- START CONDITION
                    --
                    -- SDA: HIGH -> LOW
                    -- SCL: remains HIGH
                    ----------------------------------------------------

                    when START_CONDITION =>

                        scl_reg <= '1';
                        sda_reg <= '0';

                        state <= ADDRESS_LOW;


                    ----------------------------------------------------
                    -- ADDRESS LOW
                    --
                    -- SCL LOW
                    -- Put address bit on SDA
                    ----------------------------------------------------

                    when ADDRESS_LOW =>

                        scl_reg <= '0';

                        sda_reg <= address_reg(bit_count);

                        state <= ADDRESS_HIGH;


                    ----------------------------------------------------
                    -- ADDRESS HIGH
                    --
                    -- SCL HIGH
                    --
                    -- Slave reads the address bit here.
                    ----------------------------------------------------

                    when ADDRESS_HIGH =>

                        scl_reg <= '1';

                        if bit_count = 0 then

                            state <= ADDRESS_ACK;

                        else

                            bit_count <= bit_count - 1;

                            state <= ADDRESS_LOW;

                        end if;


                    ----------------------------------------------------
                    -- ADDRESS ACK
                    --
                    -- Master releases SDA.
                    --
                    -- Slave should pull SDA LOW.
                    ----------------------------------------------------

                    when ADDRESS_ACK =>

                        scl_reg <= '1';
                        sda_reg <= '1';

                        -- ACK is available on sda_in
                        -- We continue for this first learning version.

                        bit_count <= 7;

                        state <= DATA_LOW;


                    ----------------------------------------------------
                    -- DATA LOW
                    --
                    -- SCL LOW
                    -- Put data bit on SDA
                    ----------------------------------------------------

                    when DATA_LOW =>

                        scl_reg <= '0';

                        sda_reg <= data_reg(bit_count);

                        state <= DATA_HIGH;


                    ----------------------------------------------------
                    -- DATA HIGH
                    --
                    -- SCL HIGH
                    --
                    -- Slave reads data bit here.
                    ----------------------------------------------------

                    when DATA_HIGH =>

                        scl_reg <= '1';

                        if bit_count = 0 then

                            state <= DATA_ACK;

                        else

                            bit_count <= bit_count - 1;

                            state <= DATA_LOW;

                        end if;


                    ----------------------------------------------------
                    -- DATA ACK
                    ----------------------------------------------------

                    when DATA_ACK =>

                        scl_reg <= '1';

                        -- Release SDA
                        sda_reg <= '1';

                        state <= STOP_CONDITION;


                    ----------------------------------------------------
                    -- STOP CONDITION
                    --
                    -- SDA: LOW -> HIGH
                    -- SCL: HIGH
                    ----------------------------------------------------

                    when STOP_CONDITION =>

                        scl_reg <= '1';
                        sda_reg <= '1';

                        state <= DONE_STATE;


                    ----------------------------------------------------
                    -- DONE
                    ----------------------------------------------------

                    when DONE_STATE =>

                        state <= IDLE;


                end case;

            end if;

        end if;

    end process;

end Behavioral;
