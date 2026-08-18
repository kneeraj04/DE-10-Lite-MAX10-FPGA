library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity i2c_master is
    generic (
        CLK_FREQ : integer := 50000000;
        I2C_FREQ : integer := 100000
    );
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


architecture rtl of i2c_master is

    constant DIVIDER : integer := CLK_FREQ / (I2C_FREQ * 2);

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

    signal counter : integer range 0 to DIVIDER-1 := 0;
    signal tick    : std_logic := '0';

    signal scl_reg : std_logic := '1';

    -- Open-drain SDA
    -- 1 = pull SDA LOW
    -- 0 = release SDA
    signal sda_low : std_logic := '0';

    signal address_reg : std_logic_vector(7 downto 0);
    signal data_reg    : std_logic_vector(7 downto 0);

    signal bit_count : integer range 0 to 7 := 7;

begin

    ----------------------------------------------------------------
    -- SCL output
    ----------------------------------------------------------------
    scl <= scl_reg;


    ----------------------------------------------------------------
    -- SDA open-drain output
    ----------------------------------------------------------------
    sda <= '0' when sda_low = '1' else 'Z';


    ----------------------------------------------------------------
    -- Clock divider
    ----------------------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then

            if reset = '1' then

                counter <= 0;
                tick <= '0';

            else

                if counter = DIVIDER - 1 then
                    counter <= 0;
                    tick <= '1';
                else
                    counter <= counter + 1;
                    tick <= '0';
                end if;

            end if;
        end if;
    end process;


    ----------------------------------------------------------------
    -- I2C MASTER FSM
    ----------------------------------------------------------------
    process(clk)
    begin
        if rising_edge(clk) then

            if reset = '1' then

                state <= IDLE;

                scl_reg <= '1';
                sda_low <= '0';

                busy <= '0';
                done <= '0';
                ack_error <= '0';

                bit_count <= 7;

            else

                done <= '0';

                if tick = '1' then

                    case state is


                        ------------------------------------------------
                        -- IDLE
                        ------------------------------------------------
                        when IDLE =>

                            scl_reg <= '1';
                            sda_low <= '0';

                            busy <= '0';

                            if start = '1' then

                                address_reg <= slave_addr & '0';
                                data_reg <= data_in;

                                bit_count <= 7;

                                busy <= '1';
                                ack_error <= '0';

                                state <= START_A;

                            end if;


                        ------------------------------------------------
                        -- START CONDITION
                        ------------------------------------------------
                        when START_A =>

                            -- Bus idle

                            scl_reg <= '1';
                            sda_low <= '0';

                            state <= START_B;


                        when START_B =>

                            -- SDA HIGH -> LOW while SCL HIGH

                            scl_reg <= '1';
                            sda_low <= '1';

                            state <= ADDR_LOW;


                        ------------------------------------------------
                        -- ADDRESS BIT
                        ------------------------------------------------
                        when ADDR_LOW =>

                            -- Change SDA while SCL LOW

                            scl_reg <= '0';

                            if address_reg(bit_count) = '0' then
                                sda_low <= '1';
                            else
                                sda_low <= '0';
                            end if;

                            state <= ADDR_HIGH;


                        when ADDR_HIGH =>

                            -- Slave samples SDA here

                            scl_reg <= '1';

                            state <= ADDR_ACK_LOW;


                        ------------------------------------------------
                        -- ADDRESS ACK
                        ------------------------------------------------
                        when ADDR_ACK_LOW =>

                            -- Release SDA

                            scl_reg <= '0';
                            sda_low <= '0';

                            state <= ADDR_ACK_HIGH;


                        when ADDR_ACK_HIGH =>

                            -- Slave should pull SDA LOW

                            scl_reg <= '1';

                            if sda /= '0' then
                                ack_error <= '1';
                                state <= STOP_A;

                            elsif bit_count = 0 then

                                bit_count <= 7;
                                state <= DATA_LOW;

                            else

                                bit_count <= bit_count - 1;
                                state <= ADDR_LOW;

                            end if;


                        ------------------------------------------------
                        -- DATA BIT
                        ------------------------------------------------
                        when DATA_LOW =>

                            scl_reg <= '0';

                            if data_reg(bit_count) = '0' then
                                sda_low <= '1';
                            else
                                sda_low <= '0';
                            end if;

                            state <= DATA_HIGH;


                        when DATA_HIGH =>

                            scl_reg <= '1';

                            state <= DATA_ACK_LOW;


                        ------------------------------------------------
                        -- DATA ACK
                        ------------------------------------------------
                        when DATA_ACK_LOW =>

                            scl_reg <= '0';
                            sda_low <= '0';

                            state <= DATA_ACK_HIGH;


                        when DATA_ACK_HIGH =>

                            scl_reg <= '1';

                            if sda /= '0' then

                                ack_error <= '1';
                                state <= STOP_A;

                            elsif bit_count = 0 then

                                state <= STOP_A;

                            else

                                bit_count <= bit_count - 1;
                                state <= DATA_LOW;

                            end if;


                        ------------------------------------------------
                        -- STOP CONDITION
                        ------------------------------------------------
                        when STOP_A =>

                            scl_reg <= '0';
                            sda_low <= '1';

                            state <= STOP_B;


                        when STOP_B =>

                            -- SDA LOW -> HIGH while SCL HIGH

                            scl_reg <= '1';
                            sda_low <= '0';

                            busy <= '0';
                            done <= '1';

                            state <= IDLE;

                    end case;

                end if;
            end if;
        end if;
    end process;

end rtl;