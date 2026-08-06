-- Copyright (C) 2016  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Intel and sold by Intel or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 16.1.0 Build 196 10/24/2016 SJ Lite Edition"

-- DATE "08/06/2026 22:52:42"

-- 
-- Device: Altera 10M50DAF484C7G Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hard_block IS
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic
	);
END hard_block;

-- Design Ports Information
-- ~ALTERA_TMS~	=>  Location: PIN_H2,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TCK~	=>  Location: PIN_G2,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TDI~	=>  Location: PIN_L4,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TDO~	=>  Location: PIN_M5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_CONFIG_SEL~	=>  Location: PIN_H10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_nCONFIG~	=>  Location: PIN_H9,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_nSTATUS~	=>  Location: PIN_G9,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_CONF_DONE~	=>  Location: PIN_F8,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default


ARCHITECTURE structure OF hard_block IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL \~ALTERA_TMS~~padout\ : std_logic;
SIGNAL \~ALTERA_TCK~~padout\ : std_logic;
SIGNAL \~ALTERA_TDI~~padout\ : std_logic;
SIGNAL \~ALTERA_CONFIG_SEL~~padout\ : std_logic;
SIGNAL \~ALTERA_nCONFIG~~padout\ : std_logic;
SIGNAL \~ALTERA_nSTATUS~~padout\ : std_logic;
SIGNAL \~ALTERA_CONF_DONE~~padout\ : std_logic;
SIGNAL \~ALTERA_TMS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TCK~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TDI~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_CONFIG_SEL~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nCONFIG~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nSTATUS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_CONF_DONE~~ibuf_o\ : std_logic;

BEGIN

ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
END structure;


LIBRARY ALTERA;
LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	PWM_LED IS
    PORT (
	clk : IN std_logic;
	key0 : IN std_logic;
	key1 : IN std_logic;
	led_pwm : BUFFER std_logic
	);
END PWM_LED;

-- Design Ports Information
-- led_pwm	=>  Location: PIN_A8,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- key0	=>  Location: PIN_B8,	 I/O Standard: 3.3 V Schmitt Trigger,	 Current Strength: Default
-- key1	=>  Location: PIN_A7,	 I/O Standard: 3.3 V Schmitt Trigger,	 Current Strength: Default
-- clk	=>  Location: PIN_P11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default


ARCHITECTURE structure OF PWM_LED IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_key0 : std_logic;
SIGNAL ww_key1 : std_logic;
SIGNAL ww_led_pwm : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC2~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \clk~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC2~~eoc\ : std_logic;
SIGNAL \led_pwm~output_o\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputclkctrl_outclk\ : std_logic;
SIGNAL \pwm_counter[0]~10_combout\ : std_logic;
SIGNAL \pwm_counter[0]~11\ : std_logic;
SIGNAL \pwm_counter[1]~12_combout\ : std_logic;
SIGNAL \pwm_counter[1]~13\ : std_logic;
SIGNAL \pwm_counter[2]~14_combout\ : std_logic;
SIGNAL \pwm_counter[2]~15\ : std_logic;
SIGNAL \pwm_counter[3]~16_combout\ : std_logic;
SIGNAL \pwm_counter[3]~17\ : std_logic;
SIGNAL \pwm_counter[4]~18_combout\ : std_logic;
SIGNAL \pwm_counter[4]~19\ : std_logic;
SIGNAL \pwm_counter[5]~20_combout\ : std_logic;
SIGNAL \pwm_counter[5]~21\ : std_logic;
SIGNAL \pwm_counter[6]~22_combout\ : std_logic;
SIGNAL \pwm_counter[6]~23\ : std_logic;
SIGNAL \pwm_counter[7]~24_combout\ : std_logic;
SIGNAL \pwm_counter[7]~25\ : std_logic;
SIGNAL \pwm_counter[8]~26_combout\ : std_logic;
SIGNAL \pwm_counter[8]~27\ : std_logic;
SIGNAL \pwm_counter[9]~28_combout\ : std_logic;
SIGNAL \key0~input_o\ : std_logic;
SIGNAL \key1~input_o\ : std_logic;
SIGNAL \led_pwm~0_combout\ : std_logic;
SIGNAL pwm_counter : std_logic_vector(9 DOWNTO 0);

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_clk <= clk;
ww_key0 <= key0;
ww_key1 <= key1;
led_pwm <= ww_led_pwm;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\~QUARTUS_CREATED_ADC2~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\clk~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk~input_o\);
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: LCCOMB_X44_Y52_N4
\~QUARTUS_CREATED_GND~I\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \~QUARTUS_CREATED_GND~I_combout\ = GND

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \~QUARTUS_CREATED_GND~I_combout\);

-- Location: IOOBUF_X46_Y54_N2
\led_pwm~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \led_pwm~0_combout\,
	devoe => ww_devoe,
	o => \led_pwm~output_o\);

-- Location: IOIBUF_X34_Y0_N29
\clk~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G19
\clk~inputclkctrl\ : fiftyfivenm_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk~inputclkctrl_outclk\);

-- Location: LCCOMB_X47_Y53_N10
\pwm_counter[0]~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \pwm_counter[0]~10_combout\ = pwm_counter(0) $ (VCC)
-- \pwm_counter[0]~11\ = CARRY(pwm_counter(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => pwm_counter(0),
	datad => VCC,
	combout => \pwm_counter[0]~10_combout\,
	cout => \pwm_counter[0]~11\);

-- Location: FF_X47_Y53_N11
\pwm_counter[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pwm_counter[0]~10_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pwm_counter(0));

-- Location: LCCOMB_X47_Y53_N12
\pwm_counter[1]~12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \pwm_counter[1]~12_combout\ = (pwm_counter(1) & (!\pwm_counter[0]~11\)) # (!pwm_counter(1) & ((\pwm_counter[0]~11\) # (GND)))
-- \pwm_counter[1]~13\ = CARRY((!\pwm_counter[0]~11\) # (!pwm_counter(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => pwm_counter(1),
	datad => VCC,
	cin => \pwm_counter[0]~11\,
	combout => \pwm_counter[1]~12_combout\,
	cout => \pwm_counter[1]~13\);

-- Location: FF_X47_Y53_N13
\pwm_counter[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pwm_counter[1]~12_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pwm_counter(1));

-- Location: LCCOMB_X47_Y53_N14
\pwm_counter[2]~14\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \pwm_counter[2]~14_combout\ = (pwm_counter(2) & (\pwm_counter[1]~13\ $ (GND))) # (!pwm_counter(2) & (!\pwm_counter[1]~13\ & VCC))
-- \pwm_counter[2]~15\ = CARRY((pwm_counter(2) & !\pwm_counter[1]~13\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => pwm_counter(2),
	datad => VCC,
	cin => \pwm_counter[1]~13\,
	combout => \pwm_counter[2]~14_combout\,
	cout => \pwm_counter[2]~15\);

-- Location: FF_X47_Y53_N15
\pwm_counter[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pwm_counter[2]~14_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pwm_counter(2));

-- Location: LCCOMB_X47_Y53_N16
\pwm_counter[3]~16\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \pwm_counter[3]~16_combout\ = (pwm_counter(3) & (!\pwm_counter[2]~15\)) # (!pwm_counter(3) & ((\pwm_counter[2]~15\) # (GND)))
-- \pwm_counter[3]~17\ = CARRY((!\pwm_counter[2]~15\) # (!pwm_counter(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => pwm_counter(3),
	datad => VCC,
	cin => \pwm_counter[2]~15\,
	combout => \pwm_counter[3]~16_combout\,
	cout => \pwm_counter[3]~17\);

-- Location: FF_X47_Y53_N17
\pwm_counter[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pwm_counter[3]~16_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pwm_counter(3));

-- Location: LCCOMB_X47_Y53_N18
\pwm_counter[4]~18\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \pwm_counter[4]~18_combout\ = (pwm_counter(4) & (\pwm_counter[3]~17\ $ (GND))) # (!pwm_counter(4) & (!\pwm_counter[3]~17\ & VCC))
-- \pwm_counter[4]~19\ = CARRY((pwm_counter(4) & !\pwm_counter[3]~17\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => pwm_counter(4),
	datad => VCC,
	cin => \pwm_counter[3]~17\,
	combout => \pwm_counter[4]~18_combout\,
	cout => \pwm_counter[4]~19\);

-- Location: FF_X47_Y53_N19
\pwm_counter[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pwm_counter[4]~18_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pwm_counter(4));

-- Location: LCCOMB_X47_Y53_N20
\pwm_counter[5]~20\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \pwm_counter[5]~20_combout\ = (pwm_counter(5) & (!\pwm_counter[4]~19\)) # (!pwm_counter(5) & ((\pwm_counter[4]~19\) # (GND)))
-- \pwm_counter[5]~21\ = CARRY((!\pwm_counter[4]~19\) # (!pwm_counter(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => pwm_counter(5),
	datad => VCC,
	cin => \pwm_counter[4]~19\,
	combout => \pwm_counter[5]~20_combout\,
	cout => \pwm_counter[5]~21\);

-- Location: FF_X47_Y53_N21
\pwm_counter[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pwm_counter[5]~20_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pwm_counter(5));

-- Location: LCCOMB_X47_Y53_N22
\pwm_counter[6]~22\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \pwm_counter[6]~22_combout\ = (pwm_counter(6) & (\pwm_counter[5]~21\ $ (GND))) # (!pwm_counter(6) & (!\pwm_counter[5]~21\ & VCC))
-- \pwm_counter[6]~23\ = CARRY((pwm_counter(6) & !\pwm_counter[5]~21\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => pwm_counter(6),
	datad => VCC,
	cin => \pwm_counter[5]~21\,
	combout => \pwm_counter[6]~22_combout\,
	cout => \pwm_counter[6]~23\);

-- Location: FF_X47_Y53_N23
\pwm_counter[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pwm_counter[6]~22_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pwm_counter(6));

-- Location: LCCOMB_X47_Y53_N24
\pwm_counter[7]~24\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \pwm_counter[7]~24_combout\ = (pwm_counter(7) & (!\pwm_counter[6]~23\)) # (!pwm_counter(7) & ((\pwm_counter[6]~23\) # (GND)))
-- \pwm_counter[7]~25\ = CARRY((!\pwm_counter[6]~23\) # (!pwm_counter(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => pwm_counter(7),
	datad => VCC,
	cin => \pwm_counter[6]~23\,
	combout => \pwm_counter[7]~24_combout\,
	cout => \pwm_counter[7]~25\);

-- Location: FF_X47_Y53_N25
\pwm_counter[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pwm_counter[7]~24_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pwm_counter(7));

-- Location: LCCOMB_X47_Y53_N26
\pwm_counter[8]~26\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \pwm_counter[8]~26_combout\ = (pwm_counter(8) & (\pwm_counter[7]~25\ $ (GND))) # (!pwm_counter(8) & (!\pwm_counter[7]~25\ & VCC))
-- \pwm_counter[8]~27\ = CARRY((pwm_counter(8) & !\pwm_counter[7]~25\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => pwm_counter(8),
	datad => VCC,
	cin => \pwm_counter[7]~25\,
	combout => \pwm_counter[8]~26_combout\,
	cout => \pwm_counter[8]~27\);

-- Location: FF_X47_Y53_N27
\pwm_counter[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pwm_counter[8]~26_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pwm_counter(8));

-- Location: LCCOMB_X47_Y53_N28
\pwm_counter[9]~28\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \pwm_counter[9]~28_combout\ = \pwm_counter[8]~27\ $ (pwm_counter(9))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111111110000",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => pwm_counter(9),
	cin => \pwm_counter[8]~27\,
	combout => \pwm_counter[9]~28_combout\);

-- Location: FF_X47_Y53_N29
\pwm_counter[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \pwm_counter[9]~28_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => pwm_counter(9));

-- Location: IOIBUF_X46_Y54_N29
\key0~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_key0,
	o => \key0~input_o\);

-- Location: IOIBUF_X49_Y54_N29
\key1~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_key1,
	o => \key1~input_o\);

-- Location: LCCOMB_X47_Y53_N4
\led_pwm~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \led_pwm~0_combout\ = ((!pwm_counter(9) & !\key0~input_o\)) # (!\key1~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => pwm_counter(9),
	datac => \key0~input_o\,
	datad => \key1~input_o\,
	combout => \led_pwm~0_combout\);

-- Location: UNVM_X0_Y40_N40
\~QUARTUS_CREATED_UNVM~\ : fiftyfivenm_unvm
-- pragma translate_off
GENERIC MAP (
	addr_range1_end_addr => -1,
	addr_range1_offset => -1,
	addr_range2_offset => -1,
	is_compressed_image => "false",
	is_dual_boot => "false",
	is_eram_skip => "false",
	max_ufm_valid_addr => -1,
	max_valid_addr => -1,
	min_ufm_valid_addr => -1,
	min_valid_addr => -1,
	part_name => "quartus_created_unvm",
	reserve_block => "true")
-- pragma translate_on
PORT MAP (
	nosc_ena => \~QUARTUS_CREATED_GND~I_combout\,
	xe_ye => \~QUARTUS_CREATED_GND~I_combout\,
	se => \~QUARTUS_CREATED_GND~I_combout\,
	busy => \~QUARTUS_CREATED_UNVM~~busy\);

-- Location: ADCBLOCK_X43_Y52_N0
\~QUARTUS_CREATED_ADC1~\ : fiftyfivenm_adcblock
-- pragma translate_off
GENERIC MAP (
	analog_input_pin_mask => 0,
	clkdiv => 1,
	device_partname_fivechar_prefix => "none",
	is_this_first_or_second_adc => 1,
	prescalar => 0,
	pwd => 1,
	refsel => 0,
	reserve_block => "true",
	testbits => 66,
	tsclkdiv => 1,
	tsclksel => 0)
-- pragma translate_on
PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC1~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC1~~eoc\);

-- Location: ADCBLOCK_X43_Y51_N0
\~QUARTUS_CREATED_ADC2~\ : fiftyfivenm_adcblock
-- pragma translate_off
GENERIC MAP (
	analog_input_pin_mask => 0,
	clkdiv => 1,
	device_partname_fivechar_prefix => "none",
	is_this_first_or_second_adc => 2,
	prescalar => 0,
	pwd => 1,
	refsel => 0,
	reserve_block => "true",
	testbits => 66,
	tsclkdiv => 1,
	tsclksel => 0)
-- pragma translate_on
PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC2~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC2~~eoc\);

ww_led_pwm <= \led_pwm~output_o\;
END structure;


