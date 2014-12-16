-- Copyright (C) 1991-2012 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 12.1 Build 243 01/31/2013 Service Pack 1 SJ Full Version"
-- CREATED		"Sun Aug 18 15:02:53 2013"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY absControlHL IS 
	PORT
	(
		CLK_IN :  IN  STD_LOGIC;
		SENSE_IN_HL :  IN  STD_LOGIC;
		ABS_EN_GLOBAL :  IN  STD_LOGIC;
		PWM_IN_LEFT :  IN  STD_LOGIC;
		COMPARATOR_SELECT_PORT_IN_HL :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		LUT_IN_HL :  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		PWM_OUT_HL :  OUT  STD_LOGIC;
		OVERFLOW_LOW_OUT_HL :  OUT  STD_LOGIC;
		OVERFLOW_HIGH_OUT_HL :  OUT  STD_LOGIC;
		ABS_ENABLE_OUT_HL :  OUT  STD_LOGIC;
		BLOCK_DETECT_OUT_HL :  OUT  STD_LOGIC;
		HIGH_LOW_MUX_OUT_HL :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		OUT_HIGH_HL :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		OUT_LOW_HL :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END absControlHL;

ARCHITECTURE bdf_type OF absControlHL IS 

COMPONENT blockcomparatorhl
	PORT(clk : IN STD_LOGIC;
		 oneorzero : IN STD_LOGIC;
		 inlive : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 inlut : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 selectportin : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 blockDetect : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT breakcontrolleft
	PORT(blockin : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 absen : IN STD_LOGIC;
		 absenglobal : IN STD_LOGIC;
		 pwmin : IN STD_LOGIC;
		 pwmout : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT dutycyclenormalizationhl
	PORT(selectportin : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 inport : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 selectportout : OUT STD_LOGIC;
		 outport : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT busmultiplexer
	PORT(selectportin : IN STD_LOGIC;
		 inport0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 inport1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 selectportout : OUT STD_LOGIC;
		 outport : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT rpmmeasure
	PORT(clk : IN STD_LOGIC;
		 sense : IN STD_LOGIC;
		 absenable : OUT STD_LOGIC;
		 overflowlowout : OUT STD_LOGIC;
		 overflowhighout : OUT STD_LOGIC;
		 oneorzero : OUT STD_LOGIC;
		 outhigh : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 outlive : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 outlow : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	abs_enable_HL :  STD_LOGIC;
SIGNAL	block_detect_HL :  STD_LOGIC;
SIGNAL	HIGH_LOW_MUX_OUT_HL_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	out_high_HL_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	out_low_HL_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;


BEGIN 



b2v_blockComparatorHL_instance : blockcomparatorhl
PORT MAP(clk => CLK_IN,
		 oneorzero => SENSE_IN_HL,
		 inlive => SYNTHESIZED_WIRE_0,
		 inlut => LUT_IN_HL,
		 selectportin => COMPARATOR_SELECT_PORT_IN_HL,
		 blockDetect => block_detect_HL);


b2v_breakControlHL_instance : breakcontrolleft
PORT MAP(blockin => block_detect_HL,
		 clk => CLK_IN,
		 absen => abs_enable_HL,
		 absenglobal => ABS_EN_GLOBAL,
		 pwmin => PWM_IN_LEFT,
		 pwmout => PWM_OUT_HL);


b2v_dutyCycleNormalizationHL_instance : dutycyclenormalizationhl
PORT MAP(selectportin => SYNTHESIZED_WIRE_1,
		 clk => CLK_IN,
		 inport => SYNTHESIZED_WIRE_2,
		 outport => HIGH_LOW_MUX_OUT_HL_ALTERA_SYNTHESIZED);


b2v_highLowMultiplexerHL_instance : busmultiplexer
PORT MAP(selectportin => SYNTHESIZED_WIRE_3,
		 inport0 => out_high_HL_ALTERA_SYNTHESIZED,
		 inport1 => out_low_HL_ALTERA_SYNTHESIZED,
		 selectportout => SYNTHESIZED_WIRE_1,
		 outport => SYNTHESIZED_WIRE_2);


b2v_rpmMeasureHL_instance : rpmmeasure
PORT MAP(clk => CLK_IN,
		 sense => SENSE_IN_HL,
		 absenable => abs_enable_HL,
		 overflowlowout => OVERFLOW_LOW_OUT_HL,
		 overflowhighout => OVERFLOW_HIGH_OUT_HL,
		 oneorzero => SYNTHESIZED_WIRE_3,
		 outhigh => out_high_HL_ALTERA_SYNTHESIZED,
		 outlive => SYNTHESIZED_WIRE_0,
		 outlow => out_low_HL_ALTERA_SYNTHESIZED);

ABS_ENABLE_OUT_HL <= abs_enable_HL;
BLOCK_DETECT_OUT_HL <= block_detect_HL;
HIGH_LOW_MUX_OUT_HL(15 DOWNTO 0) <= HIGH_LOW_MUX_OUT_HL_ALTERA_SYNTHESIZED(15 DOWNTO 0);
OUT_HIGH_HL <= out_high_HL_ALTERA_SYNTHESIZED;
OUT_LOW_HL <= out_low_HL_ALTERA_SYNTHESIZED;

END bdf_type;