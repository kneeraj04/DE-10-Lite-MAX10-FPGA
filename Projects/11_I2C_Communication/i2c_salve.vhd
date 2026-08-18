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
    -- RECEIVED BYTES
    ----------------------------------------------------------------

    signal address_byte : std_logic_vector(7 downto 0)
        := (others => '0');

    signal data_byte : std_logic_vector(7 downto 0)
        := (others => '0');


    ----------------------------------------------------------------
    -- CONTROL
    ----------------------------------------------------------------

    -- 7 down to 0 bits
    signal bit_count : integer range 0 to 7 := 7;


    -- 0 = receiving address
    -- 1 = receiving data
    -- 2 = transaction finished

    signal byte_count : integer range 0 to 2 := 0;


    ----------------------------------------------------------------
    -- ACK CONTROL
    ----------------------------------------------------------------

    signal ack_drive : std_logic := '0';

    signal ack_active : std_logic := '0';


begin

    ----------------------------------------------------------------
    -- OPEN-DRAIN SDA
    --
    -- ACK:
    --     ack_drive = 1 -> SDA LOW
    --
    -- No ACK:
    --     ack_drive = 0 -> SDA released
    ----------------------------------------------------------------

    sda <= '0' when ack_drive = '1' else 'Z';


    ----------------------------------------------------------------
    -- I2C SLAVE PROCESS
    ----------------------------------------------------------------

    process(scl)
    begin

        ----------------------------------------------------------------
        -- RISING EDGE OF SCL
        --
        -- Normal I2C data is sampled here.
        ----------------------------------------------------------------

        if rising_edge(scl) then

            ------------------------------------------------------------
            -- IMPORTANT:
            --
            -- If ACK is active, this rising edge is the 9th clock.
            -- DO NOT release SDA here.
            --
            -- SDA must remain LOW while SCL is HIGH.
            ------------------------------------------------------------

            if ack_active = '1' then

                null;


            ------------------------------------------------------------
            -- RECEIVE ADDRESS
            ------------------------------------------------------------

            elsif byte_count = 0 then

                address_byte(bit_count) <= sda;

                if bit_count = 0 then

                    bit_count <= 7;

                else

                    bit_count <= bit_count - 1;

                end if;


            ------------------------------------------------------------
            -- RECEIVE DATA
            ------------------------------------------------------------

            elsif byte_count = 1 then

                data_byte(bit_count) <= sda;

                if bit_count = 0 then

                    bit_count <= 7;

                else

                    bit_count <= bit_count - 1;

                end if;

            end if;

        end if;


        ----------------------------------------------------------------
        -- FALLING EDGE OF SCL
        ----------------------------------------------------------------

        if falling_edge(scl) then

            ------------------------------------------------------------
            -- IF ACK WAS ALREADY ACTIVE
            --
            -- The 9th clock has now finished.
            -- SCL has gone LOW.
            --
            -- NOW it is safe to release SDA.
            ------------------------------------------------------------

            if ack_active = '1' then

                ack_drive  <= '0';
                ack_active <= '0';


            ------------------------------------------------------------
            -- ADDRESS ACK
            --
            -- bit_count = 7 means the previous byte contained
            -- all 8 bits.
            ------------------------------------------------------------

            elsif byte_count = 0 and bit_count = 7 then

                if address_byte(7 downto 1) = SLAVE_ADDRESS then

                    -- Pull SDA LOW for ACK

                    ack_drive  <= '1';
                    ack_active <= '1';

                else

                    -- Wrong address -> no ACK

                    ack_drive  <= '0';
                    ack_active <= '0';

                end if;

                -- Next byte will be DATA

                byte_count <= 1;


            ------------------------------------------------------------
            -- DATA ACK
            ------------------------------------------------------------

            elsif byte_count = 1 and bit_count = 7 then

                -- Always ACK the received data

                ack_drive  <= '1';
                ack_active <= '1';

                -- Transaction data byte received

                byte_count <= 2;

            end if;

        end if;

    end process;

end Behavioral;