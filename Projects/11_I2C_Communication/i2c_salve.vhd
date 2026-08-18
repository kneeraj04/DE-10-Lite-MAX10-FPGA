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
    -- BIT COUNTER
    ----------------------------------------------------------------

    signal bit_count : integer range 0 to 7 := 7;


    ----------------------------------------------------------------
    -- BYTE COUNTER
    --
    -- 0 = address
    -- 1 = data
    -- 2 = complete
    ----------------------------------------------------------------

    signal byte_count : integer range 0 to 2 := 0;


    ----------------------------------------------------------------
    -- ACK
    ----------------------------------------------------------------

    signal ack_drive : std_logic := '0';


    ----------------------------------------------------------------
    -- BYTE COMPLETE FLAG
    ----------------------------------------------------------------

    signal byte_complete : std_logic := '0';


begin

    ----------------------------------------------------------------
    -- OPEN-DRAIN SDA
    ----------------------------------------------------------------

    sda <= '0' when ack_drive = '1' else 'Z';


    ----------------------------------------------------------------
    -- RECEIVE DATA
    --
    -- I2C data is sampled on the rising edge of SCL.
    ----------------------------------------------------------------

    process(scl)
    begin

        if rising_edge(scl) then

            --------------------------------------------------------
            -- ADDRESS BYTE
            --------------------------------------------------------

            if byte_count = 0 then

                address_byte(bit_count) <= sda;

                if bit_count = 0 then

                    bit_count <= 7;
                    byte_complete <= '1';

                else

                    bit_count <= bit_count - 1;

                end if;


            --------------------------------------------------------
            -- DATA BYTE
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


        ----------------------------------------------------------------
        -- PREPARE ACK AFTER 8TH BIT
        ----------------------------------------------------------------

        if falling_edge(scl) then

            if byte_complete = '1' then

                byte_complete <= '0';


                --------------------------------------------------------
                -- ADDRESS ACK
                --------------------------------------------------------

                if byte_count = 0 then

                    if address_byte(7 downto 1) = SLAVE_ADDRESS then

                        ack_drive <= '1';

                    else

                        ack_drive <= '0';

                    end if;

                    byte_count <= 1;


                --------------------------------------------------------
                -- DATA ACK
                --------------------------------------------------------

                elsif byte_count = 1 then

                    -- Always ACK the data in this simple example.

                    ack_drive <= '1';

                    byte_count <= 2;

                end if;

            end if;


            ----------------------------------------------------------------
            -- RELEASE ACK AFTER ACK CLOCK
            ----------------------------------------------------------------

            if byte_count = 1 and byte_complete = '0' then

                -- This condition is intentionally not used here
                -- for normal data reception.
                null;

            end if;

        end if;

    end process;


    ----------------------------------------------------------------
    -- RELEASE SDA AFTER ACK CLOCK
    --
    -- A small simulation process is used to release the ACK line
    -- when the ACK clock has completed.
    ----------------------------------------------------------------

    process(scl)
    begin

        if rising_edge(scl) then

            if ack_drive = '1' then

                ack_drive <= '0';

            end if;

        end if;

    end process;

end Behavioral;