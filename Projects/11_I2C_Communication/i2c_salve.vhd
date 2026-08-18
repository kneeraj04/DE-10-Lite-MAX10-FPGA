library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity i2c_slave is
    port (
        scl : inout std_logic;
        sda : inout std_logic
    );
end i2c_slave;


architecture Behavioral of i2c_slave is

    constant SLAVE_ADDRESS : std_logic_vector(6 downto 0)
        := "1010000";

    signal address_byte : std_logic_vector(7 downto 0)
        := (others => '0');

    signal data_byte : std_logic_vector(7 downto 0)
        := (others => '0');

    signal bit_count : integer range 0 to 7 := 7;

    signal byte_count : integer range 0 to 2 := 0;

    signal ack_drive : std_logic := '0';

begin

    ------------------------------------------------------------
    -- Slave never drives SCL in this simple example
    ------------------------------------------------------------

    scl <= 'Z';


    ------------------------------------------------------------
    -- Open-drain SDA
    ------------------------------------------------------------

    sda <= '0' when ack_drive = '1' else 'Z';


    ------------------------------------------------------------
    -- Receive data
    ------------------------------------------------------------

    process(scl)
    begin

        if rising_edge(scl) then

            ----------------------------------------------------
            -- ADDRESS BYTE
            ----------------------------------------------------

            if byte_count = 0 then

                address_byte(bit_count) <= sda;

                if bit_count = 0 then

                    bit_count <= 7;
                    byte_count <= 1;

                else

                    bit_count <= bit_count - 1;

                end if;


            ----------------------------------------------------
            -- DATA BYTE
            ----------------------------------------------------

            elsif byte_count = 1 then

                data_byte(bit_count) <= sda;

                if bit_count = 0 then

                    bit_count <= 7;
                    byte_count <= 2;

                else

                    bit_count <= bit_count - 1;

                end if;

            end if;

        end if;

    end process;


    ------------------------------------------------------------
    -- ACK generation
    ------------------------------------------------------------

    process(scl)
    begin

        if falling_edge(scl) then

            ----------------------------------------------------
            -- ACK ADDRESS
            ----------------------------------------------------

            if byte_count = 1 then

                if address_byte(7 downto 1)
                    = SLAVE_ADDRESS then

                    ack_drive <= '1';

                end if;


            ----------------------------------------------------
            -- ACK DATA
            ----------------------------------------------------

            elsif byte_count = 2 then

                ack_drive <= '1';

            else

                ack_drive <= '0';

            end if;

        end if;

    end process;

end Behavioral;