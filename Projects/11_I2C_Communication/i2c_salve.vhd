library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity i2c_slave is
    port (
        scl : in    std_logic;
        sda : inout std_logic
    );
end i2c_slave;


architecture Behavioral of i2c_slave is

    ----------------------------------------------------------------
    -- SLAVE ADDRESS
    ----------------------------------------------------------------

    constant SLAVE_ADDRESS : std_logic_vector(6 downto 0)
        := "1010000";


    ----------------------------------------------------------------
    -- RECEIVED DATA
    ----------------------------------------------------------------

    signal received_address : std_logic_vector(7 downto 0)
        := (others => '0');

    signal received_data : std_logic_vector(7 downto 0)
        := (others => '0');


    ----------------------------------------------------------------
    -- CONTROL
    ----------------------------------------------------------------

    signal bit_count : integer range 0 to 7 := 7;

    signal byte_count : integer range 0 to 2 := 0;


    ----------------------------------------------------------------
    -- ACK CONTROL
    ----------------------------------------------------------------

    signal ack_drive : std_logic := '0';

    signal ack_active : std_logic := '0';


begin

    ----------------------------------------------------------------
    -- OPEN-DRAIN SDA
    ----------------------------------------------------------------

    sda <= '0' when ack_drive = '1' else 'Z';


    ----------------------------------------------------------------
    -- SLAVE PROCESS
    ----------------------------------------------------------------

    process(scl)
    begin

        ------------------------------------------------------------
        -- RISING EDGE
        ------------------------------------------------------------

        if rising_edge(scl) then

            --------------------------------------------------------
            -- ACK PERIOD
            --
            -- Keep SDA LOW during the entire 9th clock.
            --------------------------------------------------------

            if ack_active = '1' then

                null;


            --------------------------------------------------------
            -- ADDRESS
            --------------------------------------------------------

            elsif byte_count = 0 then

                received_address(bit_count) <= sda;

                if bit_count = 0 then

                    bit_count <= 7;

                else

                    bit_count <= bit_count - 1;

                end if;


            --------------------------------------------------------
            -- DATA
            --------------------------------------------------------

            elsif byte_count = 1 then

                received_data(bit_count) <= sda;

                if bit_count = 0 then

                    bit_count <= 7;

                else

                    bit_count <= bit_count - 1;

                end if;

            end if;

        end if;


        ------------------------------------------------------------
        -- FALLING EDGE
        ------------------------------------------------------------

        if falling_edge(scl) then

            --------------------------------------------------------
            -- END ACK CLOCK
            --------------------------------------------------------

            if ack_active = '1' then

                ack_drive <= '0';
                ack_active <= '0';


            --------------------------------------------------------
            -- ADDRESS ACK
            --------------------------------------------------------

            elsif byte_count = 0 and bit_count = 7 then

                if received_address(7 downto 1)
                    = SLAVE_ADDRESS then

                    ack_drive <= '1';
                    ack_active <= '1';

                else

                    ack_drive <= '0';
                    ack_active <= '0';

                end if;

                byte_count <= 1;


            --------------------------------------------------------
            -- DATA ACK
            --------------------------------------------------------

            elsif byte_count = 1 and bit_count = 7 then

                ack_drive <= '1';
                ack_active <= '1';

                byte_count <= 2;

            end if;

        end if;

    end process;

end Behavioral;