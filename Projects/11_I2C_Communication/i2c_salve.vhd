library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity i2c_slave is
    port (
        scl : in    std_logic;
        sda : inout std_logic;

        ack_address : out std_logic;
        ack_data    : out std_logic
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

    signal sda_drive : std_logic := '0';
    signal sda_enable : std_logic := '0';

begin

    ------------------------------------------------------------
    -- SDA open-drain behavior
    ------------------------------------------------------------

    sda <= '0' when sda_enable = '1' else 'Z';


    ------------------------------------------------------------
    -- Receive address and data
    ------------------------------------------------------------

    process(scl)
    begin

        if rising_edge(scl) then

            ----------------------------------------------------
            -- First byte = ADDRESS + WRITE
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
            -- Second byte = DATA
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
    -- Generate ACK after address
    ------------------------------------------------------------

    process(scl)
    begin

        if falling_edge(scl) then

            ----------------------------------------------------
            -- Address received
            ----------------------------------------------------

            if byte_count = 1 then

                if address_byte(7 downto 1) = SLAVE_ADDRESS then

                    -- ACK
                    sda_enable <= '1';

                    ack_address <= '1';

                end if;


            ----------------------------------------------------
            -- Data received
            ----------------------------------------------------

            elsif byte_count = 2 then

                -- ACK data

                sda_enable <= '1';

                ack_data <= '1';

            else

                sda_enable <= '0';

            end if;

        end if;

    end process;

end Behavioral;