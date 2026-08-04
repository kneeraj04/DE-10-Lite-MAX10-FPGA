library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Traffic_Timer_Top is

Port(
    CLOCK_50 : in STD_LOGIC;     -- DE10-Lite 50 MHz clock
    RESET   : in STD_LOGIC;      -- Reset switch

    LEDR0 : out STD_LOGIC;       -- Green LED
    LEDR1 : out STD_LOGIC;       -- Yellow LED
    LEDR2 : out STD_LOGIC        -- Red LED
);

end Traffic_Timer_Top;



architecture Behavioral of Traffic_Timer_Top is


signal timer_done : STD_LOGIC;   -- Timer signal to FSM

-- FSM output signals
signal Green_s  : STD_LOGIC;
signal Yellow_s : STD_LOGIC;
signal Red_s    : STD_LOGIC;
signal reset_fsm : STD_LOGIC;


begin


-- Active LOW reset conversion
reset_fsm <= not RESET;
------------------------------------------------
-- 2 Second Timer
-- 50 MHz clock = 100,000,000 cycles
------------------------------------------------

process(CLOCK_50, reset_fsm)

variable count : integer := 0;

begin


if reset_fsm ='1' then

    count := 0;
    timer_done <= '0';


elsif rising_edge(CLOCK_50) then


    if count = 99999999 then       -- 2 seconds

        count := 0;
        timer_done <= '1';         -- FSM changes state


    else

        count := count + 1;
        timer_done <= '0';


    end if;


end if;

end process;




------------------------------------------------
-- FSM Generated from SMF File
------------------------------------------------

FSM1: entity work.Traffic_Controller

port map(

    clock => CLOCK_50,

    reset => reset_fsm,

    timer_done => timer_done,

    Green  => Green_s,

    Yellow => Yellow_s,

    Red    => Red_s

);



------------------------------------------------
-- DE10-Lite LEDs are Active LOW
-- 0 = LED ON
------------------------------------------------

LEDR0 <= Green_s;      -- Green LED
LEDR1 <= Yellow_s;     -- Yellow LED
LEDR2 <= Red_s;        -- Red LED



end Behavioral;