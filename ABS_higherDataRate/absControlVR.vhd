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
-- CREATED		"Sun Aug 18 13:32:53 2013"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY absControlVR IS 
	PORT
	(
		CLK_IN :  IN  STD_LOGIC;
		SENSE_IN_VR :  IN  STD_LOGIC;
		PWM_IN_RIGHT :  IN  STD_LOGIC;
		ABS_EN_GLOBAL :  IN  STD_LOGIC;
		COMPARATOR_SELECT_PORT_IN_VR :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		LUT_IN_VR :  IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		PWM_OUT_VR :  OUT  STD_LOGIC;
		OVERFLOW_LOW_OUT_VR :  OUT  STD_LOGIC;
		OVERFLOW_HIGH_OUT_VR :  OUT  STD_LOGIC;
		ABS_ENABLE_OUT_VR :  OUT  STD_LOGIC;
		BLOCK_DETECT_OUT_VR :  OUT  STD_LOGIC;
		HIGH_LOW_MUX_OUT_VR :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		OUT_HIGH_VR :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0);
		OUT_LOW_VR :  OUT  STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END absControlVR;

ARCHITECTURE bdf_type OF absControlVR IS 

COMPONENT blockcomparatorvr
	PORT(clk : IN STD_LOGIC;
		 oneorzero : IN STD_LOGIC;
		 inlive : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 inlut : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		 selectportin : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 blockDetect : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT breakcontrolright
	PORT(blockin : IN STD_LOGIC;
		 clk : IN STD_LOGIC;
		 absen : IN STD_LOGIC;
		 absenglobal : IN STD_LOGIC;
		 pwmin : IN STD_LOGIC;
		 pwmout : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT dutycyclenormalizationvr
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

SIGNAL	abs_enable_VR :  STD_LOGIC;
SIGNAL	block_detect_VR :  STD_LOGIC;
SIGNAL	HIGH_LOW_MUX_OUT_VR_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	out_high_VR_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	out_low_VR_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(15 DOWNTO 0);


BEGIN 



b2v_blockComparatorVR_instance : blockcomparatorvr
PORT MAP(clk => CLK_IN,
		 oneorzero => SYNTHESIZED_WIRE_5,
		 inlive => SYNTHESIZED_WIRE_1,
		 inlut => LUT_IN_VR,
		 selectportin => COMPARATOR_SELECT_PORT_IN_VR,
		 blockDetect => block_detect_VR);


b2v_breakControlVR_instance : breakcontrolright
PORT MAP(blockin => block_detect_VR,
		 clk => CLK_IN,
		 absen => abs_enable_VR,
		 absenglobal => ABS_EN_GLOBAL,
		 pwmin => PWM_IN_RIGHT,
		 pwmout => PWM_OUT_VR);


b2v_dutyCycleNormalizationVR_instance : dutycyclenormalizationvr
PORT MAP(selectportin => SYNTHESIZED_WIRE_2,
		 clk => CLK_IN,
		 inport => SYNTHESIZED_WIRE_3,
		 outport => HIGH_LOW_MUX_OUT_VR_ALTERA_SYNTHESIZED);


b2v_highLowMultiplexerVR_instance : busmultiplexer
PORT MAP(selectportin => SYNTHESIZED_WIRE_5,
		 inport0 => out_high_VR_ALTERA_SYNTHESIZED,
		 inport1 => out_low_VR_ALTERA_SYNTHESIZED,
		 selectportout => SYNTHESIZED_WIRE_2,
		 outport => SYNTHESIZED_WIRE_3);


b2v_rpmMeasureVR_instance : rpmmeasure
PORT MAP(clk => CLK_IN,
		 sense => SENSE_IN_VR,
		 absenable => abs_enable_VR,
		 overflowlowout => OVERFLOW_LOW_OUT_VR,
		 overflowhighout => OVERFLOW_HIGH_OUT_VR,
		 oneorzero => SYNTHESIZED_WIRE_5,
		 outhigh => out_high_VR_ALTERA_SYNTHESIZED,
		 outlive => SYNTHESIZED_WIRE_1,
		 outlow => out_low_VR_ALTERA_SYNTHESIZED);

ABS_ENABLE_OUT_VR <= abs_enable_VR;
BLOCK_DETECT_OUT_VR <= block_detect_VR;
HIGH_LOW_MUX_OUT_VR(15 DOWNTO 0) <= HIGH_LOW_MUX_OUT_VR_ALTERA_SYNTHESIZED(15 DOWNTO 0);
OUT_HIGH_VR <= out_high_VR_ALTERA_SYNTHESIZED;
OUT_LOW_VR <= out_low_VR_ALTERA_SYNTHESIZED;

END bdf_type;