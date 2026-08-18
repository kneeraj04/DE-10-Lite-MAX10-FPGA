library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity i2c_master is
    port (
        clk       : in  std_logic;
        reset     : in  std_logic;

        start     : in  std_logic;

        scl       : out std_logic;
        sda       : out std_logic;

        busy      : out std_logic;
        done      : out std_logic
    );
end i2c_master;


architecture Behavioral of i2c_master is

    type state_type is (
        IDLE,
        START_CONDITION,
        SEND_ADDRESS,
        SEND_DATA,
        STOP_CONDITION,
        DONE_STATE
    );

    signal state : state_type := IDLE;

    signal scl_reg : std_logic := '1';
    signal sda_reg : std_logic := '1';

    signal bit_count : integer range 0 to 7 := 7;

    -- 7-bit slave address = 1010000
    signal address_data : std_logic_vector(7 downto 0)
        := "10100000";

    -- Data to transmit = 10101010
    signal data_data : std_logic_vector(7 downto 0)
        := "10101010";

    signal counter : integer range 0 to 9 := 0;

begin

    scl <= scl_reg;
    sda <= sda_reg;

    process(clk, reset)
    begin

        if reset = '1' then

            state     <= IDLE;
            scl_reg   <= '1';
            sda_reg   <= '1';
            bit_count <= 7;
            counter   <= 0;
            busy      <= '0';
            done      <= '0';

        elsif rising_edge(clk) then

            case state is

                ------------------------------------------------
                -- IDLE
                ------------------------------------------------
                when IDLE =>

                    scl_reg <= '1';
                    sda_reg <= '1';

                    busy <= '0';
                    done <= '0';

                    if start = '1' then

                        busy <= '1';

                        state <= START_CONDITION;

                    end if;


                ------------------------------------------------
                -- START CONDITION
                --
                -- SDA changes from HIGH to LOW
                -- while SCL is HIGH
                ------------------------------------------------
                when START_CONDITION =>

                    scl_reg <= '1';
                    sda_reg <= '0';

                    bit_count <= 7;

                    state <= SEND_ADDRESS;


                ------------------------------------------------
                -- SEND ADDRESS
                ------------------------------------------------
                when SEND_ADDRESS =>

                    busy <= '1';

                    if counter = 0 then

                        -- Put data on SDA
                        sda_reg <= address_data(bit_count);

                        -- Pull SCL LOW
                        scl_reg <= '0';

                        counter <= 1;

                    elsif counter = 1 then

                        -- Generate SCL HIGH
                        scl_reg <= '1';

                        counter <= 2;

                    else

                        -- Generate SCL LOW again
                        scl_reg <= '0';

                        counter <= 0;

                        if bit_count = 0 then

                            bit_count <= 7;
                            state <= SEND_DATA;

                        else

                            bit_count <= bit_count - 1;

                        end if;

                    end if;


                ------------------------------------------------
                -- SEND DATA
                ------------------------------------------------
                when SEND_DATA =>

                    busy <= '1';

                    if counter = 0 then

                        sda_reg <= data_data(bit_count);

                        scl_reg <= '0';

                        counter <= 1;

                    elsif counter = 1 then

                        scl_reg <= '1';

                        counter <= 2;

                    else

                        scl_reg <= '0';

                        counter <= 0;

                        if bit_count = 0 then

                            state <= STOP_CONDITION;

                        else

                            bit_count <= bit_count - 1;

                        end if;

                    end if;


                ------------------------------------------------
                -- STOP CONDITION
                --
                -- SDA changes LOW -> HIGH
                -- while SCL is HIGH
                ------------------------------------------------
                when STOP_CONDITION =>

                    scl_reg <= '1';
                    sda_reg <= '1';

                    state <= DONE_STATE;


                ------------------------------------------------
                -- DONE
                ------------------------------------------------
                when DONE_STATE =>

                    busy <= '0';
                    done <= '1';

                    state <= IDLE;

            end case;

        end if;

    end process;

end Behavioral;