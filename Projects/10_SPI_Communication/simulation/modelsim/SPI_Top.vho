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

-- DATE "08/17/2026 20:06:26"

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

ENTITY 	spi_top IS
    PORT (
	CLOCK_50 : IN std_logic;
	KEY0 : IN std_logic;
	SW : IN std_logic_vector(7 DOWNTO 0);
	LEDR : BUFFER std_logic_vector(7 DOWNTO 0)
	);
END spi_top;

-- Design Ports Information
-- LEDR[0]	=>  Location: PIN_A8,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- LEDR[1]	=>  Location: PIN_A9,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- LEDR[2]	=>  Location: PIN_A10,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- LEDR[3]	=>  Location: PIN_B10,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- LEDR[4]	=>  Location: PIN_D13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- LEDR[5]	=>  Location: PIN_C13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- LEDR[6]	=>  Location: PIN_E14,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- LEDR[7]	=>  Location: PIN_D14,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: 8mA
-- KEY0	=>  Location: PIN_B8,	 I/O Standard: 3.3 V Schmitt Trigger,	 Current Strength: Default
-- CLOCK_50	=>  Location: PIN_N14,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- SW[7]	=>  Location: PIN_A14,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- SW[6]	=>  Location: PIN_A13,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- SW[5]	=>  Location: PIN_B12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- SW[4]	=>  Location: PIN_A12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- SW[3]	=>  Location: PIN_C12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- SW[2]	=>  Location: PIN_D12,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- SW[1]	=>  Location: PIN_C11,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default
-- SW[0]	=>  Location: PIN_C10,	 I/O Standard: 3.3-V LVTTL,	 Current Strength: Default


ARCHITECTURE structure OF spi_top IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_CLOCK_50 : std_logic;
SIGNAL ww_KEY0 : std_logic;
SIGNAL ww_SW : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_LEDR : std_logic_vector(7 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC2~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \CLOCK_50~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC2~~eoc\ : std_logic;
SIGNAL \LEDR[0]~output_o\ : std_logic;
SIGNAL \LEDR[1]~output_o\ : std_logic;
SIGNAL \LEDR[2]~output_o\ : std_logic;
SIGNAL \LEDR[3]~output_o\ : std_logic;
SIGNAL \LEDR[4]~output_o\ : std_logic;
SIGNAL \LEDR[5]~output_o\ : std_logic;
SIGNAL \LEDR[6]~output_o\ : std_logic;
SIGNAL \LEDR[7]~output_o\ : std_logic;
SIGNAL \CLOCK_50~input_o\ : std_logic;
SIGNAL \CLOCK_50~inputclkctrl_outclk\ : std_logic;
SIGNAL \KEY0~input_o\ : std_logic;
SIGNAL \SPI_MASTER|clk_count[0]~7_combout\ : std_logic;
SIGNAL \SPI_MASTER|Equal0~0_combout\ : std_logic;
SIGNAL \SPI_MASTER|clk_count[4]~18_combout\ : std_logic;
SIGNAL \SPI_MASTER|clk_count[4]~17_combout\ : std_logic;
SIGNAL \SPI_MASTER|clk_count[0]~8\ : std_logic;
SIGNAL \SPI_MASTER|clk_count[1]~9_combout\ : std_logic;
SIGNAL \SPI_MASTER|clk_count[1]~10\ : std_logic;
SIGNAL \SPI_MASTER|clk_count[2]~11_combout\ : std_logic;
SIGNAL \SPI_MASTER|clk_count[2]~12\ : std_logic;
SIGNAL \SPI_MASTER|clk_count[3]~13_combout\ : std_logic;
SIGNAL \SPI_MASTER|clk_count[3]~14\ : std_logic;
SIGNAL \SPI_MASTER|clk_count[4]~15_combout\ : std_logic;
SIGNAL \SPI_MASTER|Decoder0~5_combout\ : std_logic;
SIGNAL \SPI_MASTER|bit_count[2]~2_combout\ : std_logic;
SIGNAL \SPI_MASTER|spi_clk~2_combout\ : std_logic;
SIGNAL \SPI_MASTER|spi_clk~3_combout\ : std_logic;
SIGNAL \SPI_MASTER|spi_clk~q\ : std_logic;
SIGNAL \SPI_MASTER|tx_reg~1_combout\ : std_logic;
SIGNAL \SPI_MASTER|tx_reg~4_combout\ : std_logic;
SIGNAL \SPI_MASTER|bit_count[0]~4_combout\ : std_logic;
SIGNAL \SPI_MASTER|bit_count[1]~3_combout\ : std_logic;
SIGNAL \SPI_MASTER|busy~2_combout\ : std_logic;
SIGNAL \SPI_MASTER|busy~3_combout\ : std_logic;
SIGNAL \SPI_MASTER|busy~4_combout\ : std_logic;
SIGNAL \SPI_MASTER|busy~q\ : std_logic;
SIGNAL \SPI_MASTER|process_0~0_combout\ : std_logic;
SIGNAL \SW[5]~input_o\ : std_logic;
SIGNAL \SW[3]~input_o\ : std_logic;
SIGNAL \SW[2]~input_o\ : std_logic;
SIGNAL \SW[1]~input_o\ : std_logic;
SIGNAL \SW[0]~input_o\ : std_logic;
SIGNAL \SPI_MASTER|tx_reg~11_combout\ : std_logic;
SIGNAL \SPI_MASTER|tx_reg~10_combout\ : std_logic;
SIGNAL \SPI_MASTER|tx_reg[7]~2_combout\ : std_logic;
SIGNAL \SPI_MASTER|tx_reg[7]~3_combout\ : std_logic;
SIGNAL \SPI_MASTER|tx_reg~9_combout\ : std_logic;
SIGNAL \SPI_MASTER|tx_reg~8_combout\ : std_logic;
SIGNAL \SW[4]~input_o\ : std_logic;
SIGNAL \SPI_MASTER|tx_reg~7_combout\ : std_logic;
SIGNAL \SPI_MASTER|tx_reg~6_combout\ : std_logic;
SIGNAL \SW[6]~input_o\ : std_logic;
SIGNAL \SPI_MASTER|tx_reg~5_combout\ : std_logic;
SIGNAL \SW[7]~input_o\ : std_logic;
SIGNAL \SPI_MASTER|tx_reg~0_combout\ : std_logic;
SIGNAL \SPI_MASTER|Decoder0~4_combout\ : std_logic;
SIGNAL \SPI_MASTER|Decoder0~12_combout\ : std_logic;
SIGNAL \SPI_MASTER|rx_reg~0_combout\ : std_logic;
SIGNAL \SPI_MASTER|Decoder0~6_combout\ : std_logic;
SIGNAL \SPI_MASTER|rx_reg~1_combout\ : std_logic;
SIGNAL \SPI_MASTER|Decoder0~7_combout\ : std_logic;
SIGNAL \SPI_MASTER|rx_reg~2_combout\ : std_logic;
SIGNAL \SPI_MASTER|Decoder0~8_combout\ : std_logic;
SIGNAL \SPI_MASTER|rx_reg~3_combout\ : std_logic;
SIGNAL \SPI_MASTER|Decoder0~13_combout\ : std_logic;
SIGNAL \SPI_MASTER|rx_reg~4_combout\ : std_logic;
SIGNAL \SPI_MASTER|Decoder0~9_combout\ : std_logic;
SIGNAL \SPI_MASTER|rx_reg~5_combout\ : std_logic;
SIGNAL \SPI_MASTER|Decoder0~10_combout\ : std_logic;
SIGNAL \SPI_MASTER|rx_reg~6_combout\ : std_logic;
SIGNAL \SPI_MASTER|Decoder0~11_combout\ : std_logic;
SIGNAL \SPI_MASTER|rx_reg~7_combout\ : std_logic;
SIGNAL \SPI_MASTER|clk_count\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \SPI_MASTER|rx_reg\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \SPI_MASTER|tx_reg\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \SPI_MASTER|bit_count\ : std_logic_vector(2 DOWNTO 0);
SIGNAL \SPI_MASTER|ALT_INV_rx_reg\ : std_logic_vector(7 DOWNTO 0);

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_CLOCK_50 <= CLOCK_50;
ww_KEY0 <= KEY0;
ww_SW <= SW;
LEDR <= ww_LEDR;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\~QUARTUS_CREATED_ADC2~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\CLOCK_50~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \CLOCK_50~input_o\);
\SPI_MASTER|ALT_INV_rx_reg\(7) <= NOT \SPI_MASTER|rx_reg\(7);
\SPI_MASTER|ALT_INV_rx_reg\(6) <= NOT \SPI_MASTER|rx_reg\(6);
\SPI_MASTER|ALT_INV_rx_reg\(5) <= NOT \SPI_MASTER|rx_reg\(5);
\SPI_MASTER|ALT_INV_rx_reg\(4) <= NOT \SPI_MASTER|rx_reg\(4);
\SPI_MASTER|ALT_INV_rx_reg\(3) <= NOT \SPI_MASTER|rx_reg\(3);
\SPI_MASTER|ALT_INV_rx_reg\(2) <= NOT \SPI_MASTER|rx_reg\(2);
\SPI_MASTER|ALT_INV_rx_reg\(1) <= NOT \SPI_MASTER|rx_reg\(1);
\SPI_MASTER|ALT_INV_rx_reg\(0) <= NOT \SPI_MASTER|rx_reg\(0);
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: LCCOMB_X44_Y47_N24
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
\LEDR[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \SPI_MASTER|ALT_INV_rx_reg\(0),
	devoe => ww_devoe,
	o => \LEDR[0]~output_o\);

-- Location: IOOBUF_X46_Y54_N23
\LEDR[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \SPI_MASTER|ALT_INV_rx_reg\(1),
	devoe => ww_devoe,
	o => \LEDR[1]~output_o\);

-- Location: IOOBUF_X51_Y54_N16
\LEDR[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \SPI_MASTER|ALT_INV_rx_reg\(2),
	devoe => ww_devoe,
	o => \LEDR[2]~output_o\);

-- Location: IOOBUF_X46_Y54_N9
\LEDR[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \SPI_MASTER|ALT_INV_rx_reg\(3),
	devoe => ww_devoe,
	o => \LEDR[3]~output_o\);

-- Location: IOOBUF_X56_Y54_N30
\LEDR[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \SPI_MASTER|ALT_INV_rx_reg\(4),
	devoe => ww_devoe,
	o => \LEDR[4]~output_o\);

-- Location: IOOBUF_X58_Y54_N23
\LEDR[5]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \SPI_MASTER|ALT_INV_rx_reg\(5),
	devoe => ww_devoe,
	o => \LEDR[5]~output_o\);

-- Location: IOOBUF_X66_Y54_N23
\LEDR[6]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \SPI_MASTER|ALT_INV_rx_reg\(6),
	devoe => ww_devoe,
	o => \LEDR[6]~output_o\);

-- Location: IOOBUF_X56_Y54_N9
\LEDR[7]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \SPI_MASTER|ALT_INV_rx_reg\(7),
	devoe => ww_devoe,
	o => \LEDR[7]~output_o\);

-- Location: IOIBUF_X78_Y29_N22
\CLOCK_50~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_CLOCK_50,
	o => \CLOCK_50~input_o\);

-- Location: CLKCTRL_G9
\CLOCK_50~inputclkctrl\ : fiftyfivenm_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \CLOCK_50~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \CLOCK_50~inputclkctrl_outclk\);

-- Location: IOIBUF_X46_Y54_N29
\KEY0~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_KEY0,
	o => \KEY0~input_o\);

-- Location: LCCOMB_X56_Y51_N18
\SPI_MASTER|clk_count[0]~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|clk_count[0]~7_combout\ = \SPI_MASTER|clk_count\(0) $ (VCC)
-- \SPI_MASTER|clk_count[0]~8\ = CARRY(\SPI_MASTER|clk_count\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \SPI_MASTER|clk_count\(0),
	datad => VCC,
	combout => \SPI_MASTER|clk_count[0]~7_combout\,
	cout => \SPI_MASTER|clk_count[0]~8\);

-- Location: LCCOMB_X56_Y51_N16
\SPI_MASTER|Equal0~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|Equal0~0_combout\ = (!\SPI_MASTER|clk_count\(2) & (!\SPI_MASTER|clk_count\(0) & (\SPI_MASTER|clk_count\(3) & !\SPI_MASTER|clk_count\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|clk_count\(2),
	datab => \SPI_MASTER|clk_count\(0),
	datac => \SPI_MASTER|clk_count\(3),
	datad => \SPI_MASTER|clk_count\(1),
	combout => \SPI_MASTER|Equal0~0_combout\);

-- Location: LCCOMB_X56_Y51_N30
\SPI_MASTER|clk_count[4]~18\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|clk_count[4]~18_combout\ = (\KEY0~input_o\ & (((\SPI_MASTER|clk_count\(4) & \SPI_MASTER|Equal0~0_combout\)))) # (!\KEY0~input_o\ & (((\SPI_MASTER|clk_count\(4) & \SPI_MASTER|Equal0~0_combout\)) # (!\SPI_MASTER|busy~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000100010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \KEY0~input_o\,
	datab => \SPI_MASTER|busy~q\,
	datac => \SPI_MASTER|clk_count\(4),
	datad => \SPI_MASTER|Equal0~0_combout\,
	combout => \SPI_MASTER|clk_count[4]~18_combout\);

-- Location: LCCOMB_X55_Y51_N4
\SPI_MASTER|clk_count[4]~17\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|clk_count[4]~17_combout\ = (\SPI_MASTER|busy~q\) # (!\KEY0~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010111110101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \KEY0~input_o\,
	datac => \SPI_MASTER|busy~q\,
	combout => \SPI_MASTER|clk_count[4]~17_combout\);

-- Location: FF_X56_Y51_N19
\SPI_MASTER|clk_count[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|clk_count[0]~7_combout\,
	sclr => \SPI_MASTER|clk_count[4]~18_combout\,
	ena => \SPI_MASTER|clk_count[4]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|clk_count\(0));

-- Location: LCCOMB_X56_Y51_N20
\SPI_MASTER|clk_count[1]~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|clk_count[1]~9_combout\ = (\SPI_MASTER|clk_count\(1) & (!\SPI_MASTER|clk_count[0]~8\)) # (!\SPI_MASTER|clk_count\(1) & ((\SPI_MASTER|clk_count[0]~8\) # (GND)))
-- \SPI_MASTER|clk_count[1]~10\ = CARRY((!\SPI_MASTER|clk_count[0]~8\) # (!\SPI_MASTER|clk_count\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|clk_count\(1),
	datad => VCC,
	cin => \SPI_MASTER|clk_count[0]~8\,
	combout => \SPI_MASTER|clk_count[1]~9_combout\,
	cout => \SPI_MASTER|clk_count[1]~10\);

-- Location: FF_X56_Y51_N21
\SPI_MASTER|clk_count[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|clk_count[1]~9_combout\,
	sclr => \SPI_MASTER|clk_count[4]~18_combout\,
	ena => \SPI_MASTER|clk_count[4]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|clk_count\(1));

-- Location: LCCOMB_X56_Y51_N22
\SPI_MASTER|clk_count[2]~11\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|clk_count[2]~11_combout\ = (\SPI_MASTER|clk_count\(2) & (\SPI_MASTER|clk_count[1]~10\ $ (GND))) # (!\SPI_MASTER|clk_count\(2) & (!\SPI_MASTER|clk_count[1]~10\ & VCC))
-- \SPI_MASTER|clk_count[2]~12\ = CARRY((\SPI_MASTER|clk_count\(2) & !\SPI_MASTER|clk_count[1]~10\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \SPI_MASTER|clk_count\(2),
	datad => VCC,
	cin => \SPI_MASTER|clk_count[1]~10\,
	combout => \SPI_MASTER|clk_count[2]~11_combout\,
	cout => \SPI_MASTER|clk_count[2]~12\);

-- Location: FF_X56_Y51_N23
\SPI_MASTER|clk_count[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|clk_count[2]~11_combout\,
	sclr => \SPI_MASTER|clk_count[4]~18_combout\,
	ena => \SPI_MASTER|clk_count[4]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|clk_count\(2));

-- Location: LCCOMB_X56_Y51_N24
\SPI_MASTER|clk_count[3]~13\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|clk_count[3]~13_combout\ = (\SPI_MASTER|clk_count\(3) & (!\SPI_MASTER|clk_count[2]~12\)) # (!\SPI_MASTER|clk_count\(3) & ((\SPI_MASTER|clk_count[2]~12\) # (GND)))
-- \SPI_MASTER|clk_count[3]~14\ = CARRY((!\SPI_MASTER|clk_count[2]~12\) # (!\SPI_MASTER|clk_count\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|clk_count\(3),
	datad => VCC,
	cin => \SPI_MASTER|clk_count[2]~12\,
	combout => \SPI_MASTER|clk_count[3]~13_combout\,
	cout => \SPI_MASTER|clk_count[3]~14\);

-- Location: FF_X56_Y51_N25
\SPI_MASTER|clk_count[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|clk_count[3]~13_combout\,
	sclr => \SPI_MASTER|clk_count[4]~18_combout\,
	ena => \SPI_MASTER|clk_count[4]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|clk_count\(3));

-- Location: LCCOMB_X56_Y51_N26
\SPI_MASTER|clk_count[4]~15\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|clk_count[4]~15_combout\ = \SPI_MASTER|clk_count\(4) $ (!\SPI_MASTER|clk_count[3]~14\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010110100101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|clk_count\(4),
	cin => \SPI_MASTER|clk_count[3]~14\,
	combout => \SPI_MASTER|clk_count[4]~15_combout\);

-- Location: FF_X56_Y51_N27
\SPI_MASTER|clk_count[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|clk_count[4]~15_combout\,
	sclr => \SPI_MASTER|clk_count[4]~18_combout\,
	ena => \SPI_MASTER|clk_count[4]~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|clk_count\(4));

-- Location: LCCOMB_X54_Y51_N8
\SPI_MASTER|Decoder0~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|Decoder0~5_combout\ = (\SPI_MASTER|bit_count\(0) & \SPI_MASTER|bit_count\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \SPI_MASTER|bit_count\(0),
	datad => \SPI_MASTER|bit_count\(1),
	combout => \SPI_MASTER|Decoder0~5_combout\);

-- Location: LCCOMB_X55_Y51_N8
\SPI_MASTER|bit_count[2]~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|bit_count[2]~2_combout\ = (\SPI_MASTER|process_0~0_combout\ & (\SPI_MASTER|bit_count\(2) $ (((\SPI_MASTER|Decoder0~5_combout\ & !\SPI_MASTER|tx_reg~4_combout\))))) # (!\SPI_MASTER|process_0~0_combout\ & (((\SPI_MASTER|bit_count\(2) & 
-- !\SPI_MASTER|tx_reg~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000001111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|Decoder0~5_combout\,
	datab => \SPI_MASTER|process_0~0_combout\,
	datac => \SPI_MASTER|bit_count\(2),
	datad => \SPI_MASTER|tx_reg~4_combout\,
	combout => \SPI_MASTER|bit_count[2]~2_combout\);

-- Location: FF_X55_Y51_N9
\SPI_MASTER|bit_count[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|bit_count[2]~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|bit_count\(2));

-- Location: LCCOMB_X55_Y51_N2
\SPI_MASTER|spi_clk~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|spi_clk~2_combout\ = (\SPI_MASTER|busy~q\ & (\SPI_MASTER|clk_count\(4) & \SPI_MASTER|Equal0~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \SPI_MASTER|busy~q\,
	datac => \SPI_MASTER|clk_count\(4),
	datad => \SPI_MASTER|Equal0~0_combout\,
	combout => \SPI_MASTER|spi_clk~2_combout\);

-- Location: LCCOMB_X55_Y51_N26
\SPI_MASTER|spi_clk~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|spi_clk~3_combout\ = (\KEY0~input_o\ & ((\SPI_MASTER|spi_clk~q\ $ (\SPI_MASTER|spi_clk~2_combout\)))) # (!\KEY0~input_o\ & (\SPI_MASTER|busy~q\ & (\SPI_MASTER|spi_clk~q\ $ (\SPI_MASTER|spi_clk~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \KEY0~input_o\,
	datab => \SPI_MASTER|busy~q\,
	datac => \SPI_MASTER|spi_clk~q\,
	datad => \SPI_MASTER|spi_clk~2_combout\,
	combout => \SPI_MASTER|spi_clk~3_combout\);

-- Location: FF_X55_Y51_N27
\SPI_MASTER|spi_clk\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|spi_clk~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|spi_clk~q\);

-- Location: LCCOMB_X55_Y51_N28
\SPI_MASTER|tx_reg~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|tx_reg~1_combout\ = ((\SPI_MASTER|bit_count\(1) & (\SPI_MASTER|bit_count\(2) & \SPI_MASTER|bit_count\(0)))) # (!\SPI_MASTER|spi_clk~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|bit_count\(1),
	datab => \SPI_MASTER|bit_count\(2),
	datac => \SPI_MASTER|spi_clk~q\,
	datad => \SPI_MASTER|bit_count\(0),
	combout => \SPI_MASTER|tx_reg~1_combout\);

-- Location: LCCOMB_X55_Y51_N0
\SPI_MASTER|tx_reg~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|tx_reg~4_combout\ = (((\SPI_MASTER|tx_reg~1_combout\) # (!\SPI_MASTER|busy~q\)) # (!\SPI_MASTER|Equal0~0_combout\)) # (!\SPI_MASTER|clk_count\(4))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|clk_count\(4),
	datab => \SPI_MASTER|Equal0~0_combout\,
	datac => \SPI_MASTER|busy~q\,
	datad => \SPI_MASTER|tx_reg~1_combout\,
	combout => \SPI_MASTER|tx_reg~4_combout\);

-- Location: LCCOMB_X55_Y51_N24
\SPI_MASTER|bit_count[0]~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|bit_count[0]~4_combout\ = (\SPI_MASTER|bit_count\(0) & (\SPI_MASTER|tx_reg~4_combout\ $ (((!\KEY0~input_o\ & !\SPI_MASTER|busy~q\))))) # (!\SPI_MASTER|bit_count\(0) & (!\SPI_MASTER|tx_reg~4_combout\ & ((\KEY0~input_o\) # 
-- (\SPI_MASTER|busy~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110000000011110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \KEY0~input_o\,
	datab => \SPI_MASTER|busy~q\,
	datac => \SPI_MASTER|bit_count\(0),
	datad => \SPI_MASTER|tx_reg~4_combout\,
	combout => \SPI_MASTER|bit_count[0]~4_combout\);

-- Location: FF_X55_Y51_N25
\SPI_MASTER|bit_count[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|bit_count[0]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|bit_count\(0));

-- Location: LCCOMB_X55_Y51_N22
\SPI_MASTER|bit_count[1]~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|bit_count[1]~3_combout\ = (\SPI_MASTER|process_0~0_combout\ & (\SPI_MASTER|bit_count\(1) $ (((\SPI_MASTER|bit_count\(0) & !\SPI_MASTER|tx_reg~4_combout\))))) # (!\SPI_MASTER|process_0~0_combout\ & (((\SPI_MASTER|bit_count\(1) & 
-- !\SPI_MASTER|tx_reg~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000001111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|process_0~0_combout\,
	datab => \SPI_MASTER|bit_count\(0),
	datac => \SPI_MASTER|bit_count\(1),
	datad => \SPI_MASTER|tx_reg~4_combout\,
	combout => \SPI_MASTER|bit_count[1]~3_combout\);

-- Location: FF_X55_Y51_N23
\SPI_MASTER|bit_count[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|bit_count[1]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|bit_count\(1));

-- Location: LCCOMB_X55_Y51_N12
\SPI_MASTER|busy~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|busy~2_combout\ = (((!\SPI_MASTER|spi_clk~q\) # (!\SPI_MASTER|bit_count\(2))) # (!\SPI_MASTER|bit_count\(0))) # (!\SPI_MASTER|bit_count\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|bit_count\(1),
	datab => \SPI_MASTER|bit_count\(0),
	datac => \SPI_MASTER|bit_count\(2),
	datad => \SPI_MASTER|spi_clk~q\,
	combout => \SPI_MASTER|busy~2_combout\);

-- Location: LCCOMB_X55_Y51_N6
\SPI_MASTER|busy~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|busy~3_combout\ = (\SPI_MASTER|busy~q\ & ((\SPI_MASTER|busy~2_combout\) # ((!\SPI_MASTER|Equal0~0_combout\) # (!\SPI_MASTER|clk_count\(4)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|busy~2_combout\,
	datab => \SPI_MASTER|busy~q\,
	datac => \SPI_MASTER|clk_count\(4),
	datad => \SPI_MASTER|Equal0~0_combout\,
	combout => \SPI_MASTER|busy~3_combout\);

-- Location: LCCOMB_X55_Y51_N14
\SPI_MASTER|busy~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|busy~4_combout\ = (\SPI_MASTER|busy~3_combout\) # ((!\KEY0~input_o\ & !\SPI_MASTER|busy~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \KEY0~input_o\,
	datac => \SPI_MASTER|busy~q\,
	datad => \SPI_MASTER|busy~3_combout\,
	combout => \SPI_MASTER|busy~4_combout\);

-- Location: FF_X55_Y51_N15
\SPI_MASTER|busy\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|busy~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|busy~q\);

-- Location: LCCOMB_X55_Y51_N20
\SPI_MASTER|process_0~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|process_0~0_combout\ = (\KEY0~input_o\) # (\SPI_MASTER|busy~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \KEY0~input_o\,
	datac => \SPI_MASTER|busy~q\,
	combout => \SPI_MASTER|process_0~0_combout\);

-- Location: IOIBUF_X49_Y54_N1
\SW[5]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(5),
	o => \SW[5]~input_o\);

-- Location: IOIBUF_X54_Y54_N29
\SW[3]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(3),
	o => \SW[3]~input_o\);

-- Location: IOIBUF_X51_Y54_N1
\SW[2]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(2),
	o => \SW[2]~input_o\);

-- Location: IOIBUF_X51_Y54_N22
\SW[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(1),
	o => \SW[1]~input_o\);

-- Location: IOIBUF_X51_Y54_N29
\SW[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(0),
	o => \SW[0]~input_o\);

-- Location: LCCOMB_X55_Y51_N30
\SPI_MASTER|tx_reg~11\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|tx_reg~11_combout\ = (\SPI_MASTER|process_0~0_combout\ & (((\SPI_MASTER|tx_reg\(0) & \SPI_MASTER|tx_reg~4_combout\)))) # (!\SPI_MASTER|process_0~0_combout\ & (\SW[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SW[0]~input_o\,
	datab => \SPI_MASTER|process_0~0_combout\,
	datac => \SPI_MASTER|tx_reg\(0),
	datad => \SPI_MASTER|tx_reg~4_combout\,
	combout => \SPI_MASTER|tx_reg~11_combout\);

-- Location: FF_X55_Y51_N31
\SPI_MASTER|tx_reg[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|tx_reg~11_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|tx_reg\(0));

-- Location: LCCOMB_X54_Y51_N18
\SPI_MASTER|tx_reg~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|tx_reg~10_combout\ = (\SPI_MASTER|busy~q\ & (((\SPI_MASTER|tx_reg\(0))))) # (!\SPI_MASTER|busy~q\ & ((\KEY0~input_o\ & ((\SPI_MASTER|tx_reg\(0)))) # (!\KEY0~input_o\ & (\SW[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SW[1]~input_o\,
	datab => \SPI_MASTER|busy~q\,
	datac => \SPI_MASTER|tx_reg\(0),
	datad => \KEY0~input_o\,
	combout => \SPI_MASTER|tx_reg~10_combout\);

-- Location: LCCOMB_X55_Y51_N10
\SPI_MASTER|tx_reg[7]~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|tx_reg[7]~2_combout\ = (\SPI_MASTER|busy~q\ & ((\SPI_MASTER|clk_count\(4)))) # (!\SPI_MASTER|busy~q\ & (!\KEY0~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010100000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \KEY0~input_o\,
	datac => \SPI_MASTER|busy~q\,
	datad => \SPI_MASTER|clk_count\(4),
	combout => \SPI_MASTER|tx_reg[7]~2_combout\);

-- Location: LCCOMB_X54_Y51_N24
\SPI_MASTER|tx_reg[7]~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|tx_reg[7]~3_combout\ = (\SPI_MASTER|tx_reg[7]~2_combout\ & (((!\SPI_MASTER|tx_reg~1_combout\ & \SPI_MASTER|Equal0~0_combout\)) # (!\SPI_MASTER|busy~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|busy~q\,
	datab => \SPI_MASTER|tx_reg~1_combout\,
	datac => \SPI_MASTER|tx_reg[7]~2_combout\,
	datad => \SPI_MASTER|Equal0~0_combout\,
	combout => \SPI_MASTER|tx_reg[7]~3_combout\);

-- Location: FF_X54_Y51_N19
\SPI_MASTER|tx_reg[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|tx_reg~10_combout\,
	ena => \SPI_MASTER|tx_reg[7]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|tx_reg\(1));

-- Location: LCCOMB_X54_Y51_N16
\SPI_MASTER|tx_reg~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|tx_reg~9_combout\ = (\KEY0~input_o\ & (((\SPI_MASTER|tx_reg\(1))))) # (!\KEY0~input_o\ & ((\SPI_MASTER|busy~q\ & ((\SPI_MASTER|tx_reg\(1)))) # (!\SPI_MASTER|busy~q\ & (\SW[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SW[2]~input_o\,
	datab => \KEY0~input_o\,
	datac => \SPI_MASTER|busy~q\,
	datad => \SPI_MASTER|tx_reg\(1),
	combout => \SPI_MASTER|tx_reg~9_combout\);

-- Location: FF_X54_Y51_N17
\SPI_MASTER|tx_reg[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|tx_reg~9_combout\,
	ena => \SPI_MASTER|tx_reg[7]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|tx_reg\(2));

-- Location: LCCOMB_X54_Y51_N26
\SPI_MASTER|tx_reg~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|tx_reg~8_combout\ = (\KEY0~input_o\ & (((\SPI_MASTER|tx_reg\(2))))) # (!\KEY0~input_o\ & ((\SPI_MASTER|busy~q\ & ((\SPI_MASTER|tx_reg\(2)))) # (!\SPI_MASTER|busy~q\ & (\SW[3]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SW[3]~input_o\,
	datab => \KEY0~input_o\,
	datac => \SPI_MASTER|busy~q\,
	datad => \SPI_MASTER|tx_reg\(2),
	combout => \SPI_MASTER|tx_reg~8_combout\);

-- Location: FF_X54_Y51_N27
\SPI_MASTER|tx_reg[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|tx_reg~8_combout\,
	ena => \SPI_MASTER|tx_reg[7]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|tx_reg\(3));

-- Location: IOIBUF_X54_Y54_N22
\SW[4]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(4),
	o => \SW[4]~input_o\);

-- Location: LCCOMB_X54_Y51_N28
\SPI_MASTER|tx_reg~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|tx_reg~7_combout\ = (\KEY0~input_o\ & (\SPI_MASTER|tx_reg\(3))) # (!\KEY0~input_o\ & ((\SPI_MASTER|busy~q\ & (\SPI_MASTER|tx_reg\(3))) # (!\SPI_MASTER|busy~q\ & ((\SW[4]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|tx_reg\(3),
	datab => \KEY0~input_o\,
	datac => \SPI_MASTER|busy~q\,
	datad => \SW[4]~input_o\,
	combout => \SPI_MASTER|tx_reg~7_combout\);

-- Location: FF_X54_Y51_N29
\SPI_MASTER|tx_reg[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|tx_reg~7_combout\,
	ena => \SPI_MASTER|tx_reg[7]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|tx_reg\(4));

-- Location: LCCOMB_X54_Y51_N10
\SPI_MASTER|tx_reg~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|tx_reg~6_combout\ = (\KEY0~input_o\ & (((\SPI_MASTER|tx_reg\(4))))) # (!\KEY0~input_o\ & ((\SPI_MASTER|busy~q\ & ((\SPI_MASTER|tx_reg\(4)))) # (!\SPI_MASTER|busy~q\ & (\SW[5]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SW[5]~input_o\,
	datab => \KEY0~input_o\,
	datac => \SPI_MASTER|busy~q\,
	datad => \SPI_MASTER|tx_reg\(4),
	combout => \SPI_MASTER|tx_reg~6_combout\);

-- Location: FF_X54_Y51_N11
\SPI_MASTER|tx_reg[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|tx_reg~6_combout\,
	ena => \SPI_MASTER|tx_reg[7]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|tx_reg\(5));

-- Location: IOIBUF_X54_Y54_N15
\SW[6]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(6),
	o => \SW[6]~input_o\);

-- Location: LCCOMB_X54_Y51_N22
\SPI_MASTER|tx_reg~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|tx_reg~5_combout\ = (\KEY0~input_o\ & (\SPI_MASTER|tx_reg\(5))) # (!\KEY0~input_o\ & ((\SPI_MASTER|busy~q\ & (\SPI_MASTER|tx_reg\(5))) # (!\SPI_MASTER|busy~q\ & ((\SW[6]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|tx_reg\(5),
	datab => \KEY0~input_o\,
	datac => \SPI_MASTER|busy~q\,
	datad => \SW[6]~input_o\,
	combout => \SPI_MASTER|tx_reg~5_combout\);

-- Location: FF_X54_Y51_N23
\SPI_MASTER|tx_reg[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|tx_reg~5_combout\,
	ena => \SPI_MASTER|tx_reg[7]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|tx_reg\(6));

-- Location: IOIBUF_X58_Y54_N29
\SW[7]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_SW(7),
	o => \SW[7]~input_o\);

-- Location: LCCOMB_X54_Y51_N14
\SPI_MASTER|tx_reg~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|tx_reg~0_combout\ = (\KEY0~input_o\ & (\SPI_MASTER|tx_reg\(6))) # (!\KEY0~input_o\ & ((\SPI_MASTER|busy~q\ & (\SPI_MASTER|tx_reg\(6))) # (!\SPI_MASTER|busy~q\ & ((\SW[7]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|tx_reg\(6),
	datab => \KEY0~input_o\,
	datac => \SPI_MASTER|busy~q\,
	datad => \SW[7]~input_o\,
	combout => \SPI_MASTER|tx_reg~0_combout\);

-- Location: FF_X54_Y51_N15
\SPI_MASTER|tx_reg[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|tx_reg~0_combout\,
	ena => \SPI_MASTER|tx_reg[7]~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|tx_reg\(7));

-- Location: LCCOMB_X56_Y51_N14
\SPI_MASTER|Decoder0~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|Decoder0~4_combout\ = (\SPI_MASTER|busy~q\ & (\SPI_MASTER|clk_count\(4) & (!\SPI_MASTER|spi_clk~q\ & \SPI_MASTER|Equal0~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|busy~q\,
	datab => \SPI_MASTER|clk_count\(4),
	datac => \SPI_MASTER|spi_clk~q\,
	datad => \SPI_MASTER|Equal0~0_combout\,
	combout => \SPI_MASTER|Decoder0~4_combout\);

-- Location: LCCOMB_X56_Y51_N0
\SPI_MASTER|Decoder0~12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|Decoder0~12_combout\ = (\SPI_MASTER|bit_count\(2) & (\SPI_MASTER|bit_count\(0) & (\SPI_MASTER|Decoder0~4_combout\ & \SPI_MASTER|bit_count\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|bit_count\(2),
	datab => \SPI_MASTER|bit_count\(0),
	datac => \SPI_MASTER|Decoder0~4_combout\,
	datad => \SPI_MASTER|bit_count\(1),
	combout => \SPI_MASTER|Decoder0~12_combout\);

-- Location: LCCOMB_X56_Y51_N8
\SPI_MASTER|rx_reg~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|rx_reg~0_combout\ = (\SPI_MASTER|process_0~0_combout\ & ((\SPI_MASTER|Decoder0~12_combout\ & (\SPI_MASTER|tx_reg\(7))) # (!\SPI_MASTER|Decoder0~12_combout\ & ((\SPI_MASTER|rx_reg\(0))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|process_0~0_combout\,
	datab => \SPI_MASTER|tx_reg\(7),
	datac => \SPI_MASTER|rx_reg\(0),
	datad => \SPI_MASTER|Decoder0~12_combout\,
	combout => \SPI_MASTER|rx_reg~0_combout\);

-- Location: FF_X56_Y51_N9
\SPI_MASTER|rx_reg[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|rx_reg~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|rx_reg\(0));

-- Location: LCCOMB_X56_Y51_N4
\SPI_MASTER|Decoder0~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|Decoder0~6_combout\ = (\SPI_MASTER|bit_count\(2) & (!\SPI_MASTER|bit_count\(0) & (\SPI_MASTER|Decoder0~4_combout\ & \SPI_MASTER|bit_count\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|bit_count\(2),
	datab => \SPI_MASTER|bit_count\(0),
	datac => \SPI_MASTER|Decoder0~4_combout\,
	datad => \SPI_MASTER|bit_count\(1),
	combout => \SPI_MASTER|Decoder0~6_combout\);

-- Location: LCCOMB_X56_Y51_N6
\SPI_MASTER|rx_reg~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|rx_reg~1_combout\ = (\SPI_MASTER|process_0~0_combout\ & ((\SPI_MASTER|Decoder0~6_combout\ & (\SPI_MASTER|tx_reg\(7))) # (!\SPI_MASTER|Decoder0~6_combout\ & ((\SPI_MASTER|rx_reg\(1))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|process_0~0_combout\,
	datab => \SPI_MASTER|tx_reg\(7),
	datac => \SPI_MASTER|rx_reg\(1),
	datad => \SPI_MASTER|Decoder0~6_combout\,
	combout => \SPI_MASTER|rx_reg~1_combout\);

-- Location: FF_X56_Y51_N7
\SPI_MASTER|rx_reg[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|rx_reg~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|rx_reg\(1));

-- Location: LCCOMB_X57_Y51_N28
\SPI_MASTER|Decoder0~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|Decoder0~7_combout\ = (\SPI_MASTER|bit_count\(0) & (\SPI_MASTER|bit_count\(2) & (!\SPI_MASTER|bit_count\(1) & \SPI_MASTER|Decoder0~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|bit_count\(0),
	datab => \SPI_MASTER|bit_count\(2),
	datac => \SPI_MASTER|bit_count\(1),
	datad => \SPI_MASTER|Decoder0~4_combout\,
	combout => \SPI_MASTER|Decoder0~7_combout\);

-- Location: LCCOMB_X57_Y51_N24
\SPI_MASTER|rx_reg~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|rx_reg~2_combout\ = (\SPI_MASTER|process_0~0_combout\ & ((\SPI_MASTER|Decoder0~7_combout\ & (\SPI_MASTER|tx_reg\(7))) # (!\SPI_MASTER|Decoder0~7_combout\ & ((\SPI_MASTER|rx_reg\(2))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|process_0~0_combout\,
	datab => \SPI_MASTER|tx_reg\(7),
	datac => \SPI_MASTER|rx_reg\(2),
	datad => \SPI_MASTER|Decoder0~7_combout\,
	combout => \SPI_MASTER|rx_reg~2_combout\);

-- Location: FF_X57_Y51_N25
\SPI_MASTER|rx_reg[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|rx_reg~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|rx_reg\(2));

-- Location: LCCOMB_X55_Y51_N18
\SPI_MASTER|Decoder0~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|Decoder0~8_combout\ = (!\SPI_MASTER|bit_count\(1) & (!\SPI_MASTER|bit_count\(0) & (\SPI_MASTER|Decoder0~4_combout\ & \SPI_MASTER|bit_count\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|bit_count\(1),
	datab => \SPI_MASTER|bit_count\(0),
	datac => \SPI_MASTER|Decoder0~4_combout\,
	datad => \SPI_MASTER|bit_count\(2),
	combout => \SPI_MASTER|Decoder0~8_combout\);

-- Location: LCCOMB_X55_Y51_N16
\SPI_MASTER|rx_reg~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|rx_reg~3_combout\ = (\SPI_MASTER|process_0~0_combout\ & ((\SPI_MASTER|Decoder0~8_combout\ & (\SPI_MASTER|tx_reg\(7))) # (!\SPI_MASTER|Decoder0~8_combout\ & ((\SPI_MASTER|rx_reg\(3))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|tx_reg\(7),
	datab => \SPI_MASTER|process_0~0_combout\,
	datac => \SPI_MASTER|rx_reg\(3),
	datad => \SPI_MASTER|Decoder0~8_combout\,
	combout => \SPI_MASTER|rx_reg~3_combout\);

-- Location: FF_X55_Y51_N17
\SPI_MASTER|rx_reg[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|rx_reg~3_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|rx_reg\(3));

-- Location: LCCOMB_X54_Y51_N12
\SPI_MASTER|Decoder0~13\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|Decoder0~13_combout\ = (\SPI_MASTER|bit_count\(1) & (\SPI_MASTER|bit_count\(0) & (!\SPI_MASTER|bit_count\(2) & \SPI_MASTER|Decoder0~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|bit_count\(1),
	datab => \SPI_MASTER|bit_count\(0),
	datac => \SPI_MASTER|bit_count\(2),
	datad => \SPI_MASTER|Decoder0~4_combout\,
	combout => \SPI_MASTER|Decoder0~13_combout\);

-- Location: LCCOMB_X54_Y51_N4
\SPI_MASTER|rx_reg~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|rx_reg~4_combout\ = (\SPI_MASTER|process_0~0_combout\ & ((\SPI_MASTER|Decoder0~13_combout\ & (\SPI_MASTER|tx_reg\(7))) # (!\SPI_MASTER|Decoder0~13_combout\ & ((\SPI_MASTER|rx_reg\(4))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|process_0~0_combout\,
	datab => \SPI_MASTER|tx_reg\(7),
	datac => \SPI_MASTER|rx_reg\(4),
	datad => \SPI_MASTER|Decoder0~13_combout\,
	combout => \SPI_MASTER|rx_reg~4_combout\);

-- Location: FF_X54_Y51_N5
\SPI_MASTER|rx_reg[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|rx_reg~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|rx_reg\(4));

-- Location: LCCOMB_X57_Y51_N18
\SPI_MASTER|Decoder0~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|Decoder0~9_combout\ = (!\SPI_MASTER|bit_count\(0) & (!\SPI_MASTER|bit_count\(2) & (\SPI_MASTER|bit_count\(1) & \SPI_MASTER|Decoder0~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|bit_count\(0),
	datab => \SPI_MASTER|bit_count\(2),
	datac => \SPI_MASTER|bit_count\(1),
	datad => \SPI_MASTER|Decoder0~4_combout\,
	combout => \SPI_MASTER|Decoder0~9_combout\);

-- Location: LCCOMB_X57_Y51_N10
\SPI_MASTER|rx_reg~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|rx_reg~5_combout\ = (\SPI_MASTER|process_0~0_combout\ & ((\SPI_MASTER|Decoder0~9_combout\ & (\SPI_MASTER|tx_reg\(7))) # (!\SPI_MASTER|Decoder0~9_combout\ & ((\SPI_MASTER|rx_reg\(5))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|process_0~0_combout\,
	datab => \SPI_MASTER|tx_reg\(7),
	datac => \SPI_MASTER|rx_reg\(5),
	datad => \SPI_MASTER|Decoder0~9_combout\,
	combout => \SPI_MASTER|rx_reg~5_combout\);

-- Location: FF_X57_Y51_N11
\SPI_MASTER|rx_reg[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|rx_reg~5_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|rx_reg\(5));

-- Location: LCCOMB_X56_Y51_N2
\SPI_MASTER|Decoder0~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|Decoder0~10_combout\ = (!\SPI_MASTER|bit_count\(2) & (\SPI_MASTER|bit_count\(0) & (\SPI_MASTER|Decoder0~4_combout\ & !\SPI_MASTER|bit_count\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|bit_count\(2),
	datab => \SPI_MASTER|bit_count\(0),
	datac => \SPI_MASTER|Decoder0~4_combout\,
	datad => \SPI_MASTER|bit_count\(1),
	combout => \SPI_MASTER|Decoder0~10_combout\);

-- Location: LCCOMB_X56_Y51_N28
\SPI_MASTER|rx_reg~6\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|rx_reg~6_combout\ = (\SPI_MASTER|process_0~0_combout\ & ((\SPI_MASTER|Decoder0~10_combout\ & (\SPI_MASTER|tx_reg\(7))) # (!\SPI_MASTER|Decoder0~10_combout\ & ((\SPI_MASTER|rx_reg\(6))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|process_0~0_combout\,
	datab => \SPI_MASTER|tx_reg\(7),
	datac => \SPI_MASTER|rx_reg\(6),
	datad => \SPI_MASTER|Decoder0~10_combout\,
	combout => \SPI_MASTER|rx_reg~6_combout\);

-- Location: FF_X56_Y51_N29
\SPI_MASTER|rx_reg[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|rx_reg~6_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|rx_reg\(6));

-- Location: LCCOMB_X56_Y51_N12
\SPI_MASTER|Decoder0~11\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|Decoder0~11_combout\ = (!\SPI_MASTER|bit_count\(2) & (!\SPI_MASTER|bit_count\(0) & (\SPI_MASTER|Decoder0~4_combout\ & !\SPI_MASTER|bit_count\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|bit_count\(2),
	datab => \SPI_MASTER|bit_count\(0),
	datac => \SPI_MASTER|Decoder0~4_combout\,
	datad => \SPI_MASTER|bit_count\(1),
	combout => \SPI_MASTER|Decoder0~11_combout\);

-- Location: LCCOMB_X56_Y51_N10
\SPI_MASTER|rx_reg~7\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \SPI_MASTER|rx_reg~7_combout\ = (\SPI_MASTER|process_0~0_combout\ & ((\SPI_MASTER|Decoder0~11_combout\ & (\SPI_MASTER|tx_reg\(7))) # (!\SPI_MASTER|Decoder0~11_combout\ & ((\SPI_MASTER|rx_reg\(7))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \SPI_MASTER|process_0~0_combout\,
	datab => \SPI_MASTER|tx_reg\(7),
	datac => \SPI_MASTER|rx_reg\(7),
	datad => \SPI_MASTER|Decoder0~11_combout\,
	combout => \SPI_MASTER|rx_reg~7_combout\);

-- Location: FF_X56_Y51_N11
\SPI_MASTER|rx_reg[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \CLOCK_50~inputclkctrl_outclk\,
	d => \SPI_MASTER|rx_reg~7_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \SPI_MASTER|rx_reg\(7));

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

ww_LEDR(0) <= \LEDR[0]~output_o\;

ww_LEDR(1) <= \LEDR[1]~output_o\;

ww_LEDR(2) <= \LEDR[2]~output_o\;

ww_LEDR(3) <= \LEDR[3]~output_o\;

ww_LEDR(4) <= \LEDR[4]~output_o\;

ww_LEDR(5) <= \LEDR[5]~output_o\;

ww_LEDR(6) <= \LEDR[6]~output_o\;

ww_LEDR(7) <= \LEDR[7]~output_o\;
END structure;


