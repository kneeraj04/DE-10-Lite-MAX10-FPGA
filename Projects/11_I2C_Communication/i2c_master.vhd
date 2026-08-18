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

    --------------------------------------------------------------------
    -- 50 MHz FPGA clock
    -- Desired I2C clock = 100 kHz
    --
    -- 50 MHz / 100 kHz = 500 clock cycles
    -- Half period = 250 clock cycles
    --------------------------------------------------------------------
    constant CLK_DIV : integer := 250;

    signal clk_count : integer range 0 to CLK_DIV-1 := 0;
    signal i2c_tick  : std_logic := '0';


    --------------------------------------------------------------------
    -- FSM states
    --------------------------------------------------------------------
    type state_type is (
        IDLE,

        START_A,
        START_B,

        ADDR_LOW,
        ADDR_HIGH,

        ADDR_ACK_LOW,
        ADDR_ACK_HIGH,

        DATA_LOW,
        DATA_HIGH,

        DATA_ACK_LOW,
        DATA_ACK_HIGH,

        STOP_A,
        STOP_B
    );

    signal state : state_type := IDLE;


    --------------------------------------------------------------------
    -- Registers
    --------------------------------------------------------------------
    signal address_reg : std_logic_vector(7 downto 0);
    signal data_reg    : std_logic_vector(7 downto 0);

    signal bit_count : integer range 0 to 7 := 7;


    --------------------------------------------------------------------
    -- SCL and SDA control
    --------------------------------------------------------------------
    signal scl_reg : std_logic := '1';

    -- '1' = FPGA pulls SDA LOW
    -- '0' = FPGA releases SDA
    signal sda_drive_low : std_logic := '0';

begin

    --------------------------------------------------------------------
    -- Output SCL
    --------------------------------------------------------------------
    scl <= scl_reg;


    --------------------------------------------------------------------
    -- Open-drain SDA
    --------------------------------------------------------------------
    sda <= '0' when sda_drive_low = '1' else 'Z';


    --------------------------------------------------------------------
    -- I2C clock divider
    --------------------------------------------------------------------
    process(clk)
    begin

        if rising_edge(clk) then

            if reset = '1' then

                clk_count <= 0;
                i2c_tick  <= '0';

            else

                if clk_count = CLK_DIV - 1 then

                    clk_count <= 0;
                    i2c_tick  <= '1';

                else

                    clk_count <= clk_count + 1;
                    i2c_tick  <= '0';

                end if;

            end if;

        end if;

    end process;


    --------------------------------------------------------------------
    -- I2C MASTER FSM
    --------------------------------------------------------------------
    process(clk)
    begin

        if rising_edge(clk) then

            if reset = '1' then

                state <= IDLE;

                scl_reg       <= '1';
                sda_drive_low <= '0';

                address_reg <= (others => '0');
                data_reg    <= (others => '0');

                bit_count <= 7;

                busy      <= '0';
                done      <= '0';
                ack_error <= '0';

            else

                -- done is a pulse
                done <= '0';


                if i2c_tick = '1' then

                    case state is


                        ----------------------------------------------------
                        -- IDLE
                        ----------------------------------------------------
                        when IDLE =>

                            scl_reg       <= '1';
                            sda_drive_low <= '0';

                            busy      <= '0';
                            ack_error <= '0';

                            if start = '1' then

                                address_reg <= slave_addr & '0';
                                data_reg    <= data_in;

                                bit_count <= 7;

                                busy <= '1';

                                state <= START_A;

                            end if;


                        ----------------------------------------------------
                        -- START_A
                        --
                        -- Bus idle:
                        -- SCL = HIGH
                        -- SDA = HIGH
                        ----------------------------------------------------
                        when START_A =>

                            scl_reg       <= '1';
                            sda_drive_low <= '0';

                            state <= START_B;


                        ----------------------------------------------------
                        -- START_B
                        --
                        -- START condition:
                        -- SCL = HIGH
                        -- SDA HIGH -> LOW
                        ----------------------------------------------------
                        when START_B =>

                            scl_reg       <= '1';
                            sda_drive_low <= '1';

                            state <= ADDR_LOW;


                        ----------------------------------------------------
                        -- ADDRESS LOW
                        ----------------------------------------------------
                        when ADDR_LOW =>

                            scl_reg <= '0';

                            if address_reg(bit_count) = '0' then
                                sda_drive_low <= '1';
                            else
                                sda_drive_low <= '0';
                            end if;

                            state <= ADDR_HIGH;


                        ----------------------------------------------------
                        -- ADDRESS HIGH
                        ----------------------------------------------------
                        when ADDR_HIGH =>

                            scl_reg <= '1';

                            state <= ADDR_ACK_LOW;


                        ----------------------------------------------------
                        -- ADDRESS ACK LOW
                        --
                        -- Release SDA
                        ----------------------------------------------------
                        when ADDR_ACK_LOW =>

                            scl_reg       <= '0';
                            sda_drive_low <= '0';

                            state <= ADDR_ACK_HIGH;


                        ----------------------------------------------------
                        -- ADDRESS ACK HIGH
                        --
                        -- Slave places ACK on SDA
                        ----------------------------------------------------
                        when ADDR_ACK_HIGH =>

                            scl_reg <= '1';

                            if sda = '0' then

                                -- ACK received

                                if bit_count = 0 then

                                    bit_count <= 7;

                                    state <= DATA_LOW;

                                else

                                    bit_count <= bit_count - 1;

                                    state <= ADDR_LOW;

                                end if;

                            else

                                -- NACK

                                ack_error <= '1';

                                state <= STOP_A;

                            end if;


                        ----------------------------------------------------
                        -- DATA LOW
                        ----------------------------------------------------
                        when DATA_LOW =>

                            scl_reg <= '0';

                            if data_reg(bit_count) = '0' then
                                sda_drive_low <= '1';
                            else
                                sda_drive_low <= '0';
                            end if;

                            state <= DATA_HIGH;


                        ----------------------------------------------------
                        -- DATA HIGH
                        ----------------------------------------------------
                        when DATA_HIGH =>

                            scl_reg <= '1';

                            state <= DATA_ACK_LOW;


                        ----------------------------------------------------
                        -- DATA ACK LOW
                        ----------------------------------------------------
                        when DATA_ACK_LOW =>

                            scl_reg       <= '0';
                            sda_drive_low <= '0';

                            state <= DATA_ACK_HIGH;


                        ----------------------------------------------------
                        -- DATA ACK HIGH
                        ----------------------------------------------------
                        when DATA_ACK_HIGH =>

                            scl_reg <= '1';

                            if sda = '0' then

                                -- ACK received

                                if bit_count = 0 then

                                    state <= STOP_A;

                                else

                                    bit_count <= bit_count - 1;

                                    state <= DATA_LOW;

                                end if;

                            else

                                -- NACK

                                ack_error <= '1';

                                state <= STOP_A;

                            end if;


                        ----------------------------------------------------
                        -- STOP_A
                        --
                        -- Prepare STOP:
                        -- SCL LOW
                        -- SDA LOW
                        ----------------------------------------------------
                        when STOP_A =>

                            scl_reg       <= '0';
                            sda_drive_low <= '1';

                            state <= STOP_B;


                        ----------------------------------------------------
                        -- STOP_B
                        --
                        -- STOP:
                        -- SCL HIGH
                        -- SDA LOW -> HIGH
                        ----------------------------------------------------
                        when STOP_B =>

                            scl_reg       <= '1';
                            sda_drive_low <= '0';

                            busy <= '0';
                            done <= '1';

                            state <= IDLE;


                    end case;

                end if;

            end if;

        end if;

    end process;

end behavioral;