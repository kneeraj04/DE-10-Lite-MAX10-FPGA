library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity i2c_slave is
    port (
        scl : in    std_logic;
        sda : inout std_logic
    );
end i2c_slave;


architecture Behavioral of i2c_slave is

    constant SLAVE_ADDRESS : std_logic_vector(6 downto 0)
        := "1010000";

    signal sda_out : std_logic := '1';
    signal sda_oe  : std_logic := '0';

    signal address_received : std_logic_vector(6 downto 0)
        := (others => '0');

    signal data_received : std_logic_vector(7 downto 0)
        := (others => '0');

    signal bit_count : integer range 0 to 7 := 7;

    signal ack_address : std_logic := '0';
    signal ack_data    : std_logic := '0';

begin

    sda <= sda_out when sda_oe = '1' else 'Z';


    ------------------------------------------------------------
    -- Receive address and data
    ------------------------------------------------------------

    process(scl)
    begin

        if rising_edge(scl) then

            if bit_count > 0 then

                address_received(bit_count - 1)
                    <= sda;

                bit_count <= bit_count - 1;

            else

                bit_count <= 7;

                -- Address check
                if address_received = SLAVE_ADDRESS then

                    ack_address <= '1';

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

            if ack_address = '1' then

                -- Pull SDA LOW = ACK

                sda_out <= '0';
                sda_oe  <= '1';

                ack_address <= '0';

            elsif ack_data = '1' then

                sda_out <= '0';
                sda_oe  <= '1';

                ack_data <= '0';

            else

                sda_oe <= '0';

            end if;

        end if;

    end process;

end Behavioral;