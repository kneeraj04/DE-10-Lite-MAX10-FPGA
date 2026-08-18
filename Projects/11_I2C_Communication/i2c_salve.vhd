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

    signal address_byte : std_logic_vector(7 downto 0)
        := (others => '0');

    signal data_byte : std_logic_vector(7 downto 0)
        := (others => '0');


    ----------------------------------------------------------------
    -- BYTE / BIT CONTROL
    ----------------------------------------------------------------

    signal bit_count : integer range 0 to 7 := 7;

    -- 0 = receiving address
    -- 1 = receiving data
    -- 2 = transaction complete

    signal byte_count : integer range 0 to 2 := 0;


    ----------------------------------------------------------------
    -- ACK CONTROL
    ----------------------------------------------------------------

    signal byte_complete : std_logic := '0';

    signal ack_active : std_logic := '0';

    signal ack_drive : std_logic := '0';


begin

    ----------------------------------------------------------------
    -- OPEN-DRAIN SDA
    ----------------------------------------------------------------

    sda <= '0' when ack_drive = '1' else 'Z';


    ----------------------------------------------------------------
    -- RECEIVE DATA AND GENERATE ACK
    --
    -- This process models the behavior of a real I2C slave.
    --
    -- Data is sampled on rising SCL.
    -- ACK is prepared after the 8th bit.
    -- ACK is released after the 9th clock.
    ----------------------------------------------------------------

    process(scl)
    begin

        ------------------------------------------------------------
        -- SCL RISING EDGE
        ------------------------------------------------------------

        if rising_edge(scl) then

            --------------------------------------------------------
            -- During ACK clock, do NOT treat SDA as data.
            --------------------------------------------------------

            if ack_active = '1' then

                null;


            --------------------------------------------------------
            -- RECEIVE ADDRESS
            --------------------------------------------------------

            elsif byte_count = 0 then

                address_byte(bit_count) <= sda;

                if bit_count = 0 then

                    bit_count <= 7;
                    byte_complete <= '1';

                else

                    bit_count <= bit_count - 1;

                end if;


            --------------------------------------------------------
            -- RECEIVE DATA
            --------------------------------------------------------

            elsif byte_count = 1 then

                data_byte(bit_count) <= sda;

                if bit_count = 0 then

                    bit_count <= 7;
                    byte_complete <= '1';

                else

                    bit_count <= bit_count - 1;

                end if;

            end if;

        end if;


        ------------------------------------------------------------
        -- SCL FALLING EDGE
        ------------------------------------------------------------

        if falling_edge(scl) then

            --------------------------------------------------------
            -- ACK CLOCK HAS FINISHED
            --------------------------------------------------------

            if ack_active = '1' then

                -- Release SDA

                ack_drive <= '0';
                ack_active <= '0';

                -- Move to next byte

                if byte_count = 0 then

                    byte_count <= 1;

                elsif byte_count = 1 then

                    byte_count <= 2;

                end if;


            --------------------------------------------------------
            -- PREPARE ACK AFTER 8 DATA BITS
            --------------------------------------------------------

            elsif byte_complete = '1' then

                byte_complete <= '0';

                ----------------------------------------------------
                -- ADDRESS ACK
                ----------------------------------------------------

                if byte_count = 0 then

                    if address_byte(7 downto 1)
                        = SLAVE_ADDRESS then

                        -- Pull SDA LOW

                        ack_drive <= '1';

                    else

                        -- Wrong address: no ACK

                        ack_drive <= '0';

                    end if;

                    ack_active <= '1';


                ----------------------------------------------------
                -- DATA ACK
                ----------------------------------------------------

                elsif byte_count = 1 then

                    -- Always acknowledge received data
                    -- in this simple example.

                    ack_drive <= '1';

                    ack_active <= '1';

                end if;

            end if;

        end if;

    end process;

end Behavioral;