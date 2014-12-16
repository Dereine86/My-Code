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
-- CREATED		"Sun Aug 18 12:53:33 2013"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY absMain IS 
	PORT
	(
		clk_board :  IN  STD_LOGIC;
		gSensorReset :  IN  STD_LOGIC;
		SENSE_HR :  IN  STD_LOGIC;
		SENSE_VR :  IN  STD_LOGIC;
		PWM_IN_R :  IN  STD_LOGIC;
		PWM_IN_L :  IN  STD_LOGIC;
		SENSE_HL :  IN  STD_LOGIC;
		SENSE_VL :  IN  STD_LOGIC;
		ABS_EN_GLOBAL :  IN  STD_LOGIC;
		SDIO :  INOUT  STD_LOGIC;
		TX :  OUT  STD_LOGIC;
		CS_N :  OUT  STD_LOGIC;
		SCLK :  OUT  STD_LOGIC;
		PWM_OUT_VR :  OUT  STD_LOGIC;
		PWM_OUT_HR :  OUT  STD_LOGIC;
		PWM_OUT_VL :  OUT  STD_LOGIC;
		PWM_OUT_HL :  OUT  STD_LOGIC;
		DEBUG_CLOCK1M :  OUT  STD_LOGIC;
		DEBUG_CLOCK100K :  OUT  STD_LOGIC;
		xAxis :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END absMain;

ARCHITECTURE bdf_type OF absMain IS 

COMPONENT controlblock
	PORT(SENSE_IN_HR : IN STD_LOGIC;
		 PWM_IN_RIGHT : IN STD_LOGIC;
		 PWM_IN_LEFT : IN STD_LOGIC;
		 CLK_IN : IN STD_LOGIC;
		 ABS_EN_GLOBAL : IN STD_LOGIC;
		 SENSE_IN_VR : IN STD_LOGIC;
		 SENSE_IN_HL : IN STD_LOGIC;
		 SENSE_IN_VL : IN STD_LOGIC;
		 PWM_OUT_HR : OUT STD_LOGIC;
		 OVERFLOW_LOW_OUT_HR : OUT STD_LOGIC;
		 OVERFLOW_HIGH_OUT_HR : OUT STD_LOGIC;
		 ABS_ENABLE_HR : OUT STD_LOGIC;
		 BLOCK_DETECT_OUT_HR : OUT STD_LOGIC;
		 PWM_OUT_VR : OUT STD_LOGIC;
		 OVERFLOW_LOW_OUT_VR : OUT STD_LOGIC;
		 OVERFLOW_HIGH_OUT_VR : OUT STD_LOGIC;
		 ABS_ENABLE_VR : OUT STD_LOGIC;
		 BLOCK_DETECT_OUT_VR : OUT STD_LOGIC;
		 PWM_OUT_HL : OUT STD_LOGIC;
		 OVERFLOW_LOW_OUT_HL : OUT STD_LOGIC;
		 OVERFLOW_HIGH_OUT_HL : OUT STD_LOGIC;
		 ABS_ENABLE_HL : OUT STD_LOGIC;
		 BLOCK_DETECT_OUT_HL : OUT STD_LOGIC;
		 PWM_OUT_VL : OUT STD_LOGIC;
		 OVERFLOW_LOW_OUT_VL : OUT STD_LOGIC;
		 OVERFLOW_HIGH_OUT_VL : OUT STD_LOGIC;
		 ABS_ENABLE_VL : OUT STD_LOGIC;
		 BLOCK_DETECT_OUT_VL : OUT STD_LOGIC;
		 LUT_INPUT_OUT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 LUT_OUT : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 OUT_HIGH_HL : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 OUT_HIGH_HR : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 OUT_HIGH_VL : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 OUT_HIGH_VR : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 OUT_LOW_HL : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 OUT_LOW_HR : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 OUT_LOW_VL : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 OUT_LOW_VR : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT datatoserial
	PORT(clk_50 : IN STD_LOGIC;
		 data1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_1_0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_1_1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_1_2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_1_3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_1_4 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_1_5 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_1_6 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_1_7 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_1_8 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_1_9 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_2_0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_2_1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_2_2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_2_3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_2_4 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_3 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_4 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_5 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_6 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_7 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_8 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_9 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 serial : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT gsensorreader
	PORT(clk_50 : IN STD_LOGIC;
		 reset_n : IN STD_LOGIC;
		 SDIO : INOUT STD_LOGIC;
		 CS_N : OUT STD_LOGIC;
		 SCLK : OUT STD_LOGIC;
		 dataX : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 dataY : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		 dataZ : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;

COMPONENT clockdivider
	PORT(clockin : IN STD_LOGIC;
		 clockout : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT clockdividerdebug
	PORT(clockin : IN STD_LOGIC;
		 clockout : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	abs_Enable_HL :  STD_LOGIC;
SIGNAL	abs_Enable_HR :  STD_LOGIC;
SIGNAL	abs_Enable_VL :  STD_LOGIC;
SIGNAL	abs_Enable_VR :  STD_LOGIC;
SIGNAL	block_Detect_HL :  STD_LOGIC;
SIGNAL	block_Detect_HR :  STD_LOGIC;
SIGNAL	block_Detect_VL :  STD_LOGIC;
SIGNAL	block_Detect_VR :  STD_LOGIC;
SIGNAL	dataX :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	LUT_INPUT_OUT :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	LUT_OUT :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	out_High_HL :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	out_High_HR :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	out_High_VL :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	out_High_VR :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	out_Low_HL :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	out_Low_HR :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	out_Low_VL :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	out_Low_VR :  STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL	overflow_High_HL :  STD_LOGIC;
SIGNAL	overflow_High_HR :  STD_LOGIC;
SIGNAL	overflow_High_VL :  STD_LOGIC;
SIGNAL	overflow_High_VR :  STD_LOGIC;
SIGNAL	overflow_Low_HL :  STD_LOGIC;
SIGNAL	overflow_Low_HR :  STD_LOGIC;
SIGNAL	overflow_Low_VL :  STD_LOGIC;
SIGNAL	overflow_Low_VR :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;

SIGNAL	GDFX_TEMP_SIGNAL_1 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	GDFX_TEMP_SIGNAL_0 :  STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN 
DEBUG_CLOCK1M <= SYNTHESIZED_WIRE_2;

GDFX_TEMP_SIGNAL_1 <= (overflow_High_HL & overflow_Low_HL & abs_Enable_HL & block_Detect_HL & overflow_High_VL & overflow_Low_VL & abs_Enable_VL & block_Detect_VL);
GDFX_TEMP_SIGNAL_0 <= (overflow_High_HR & overflow_Low_HR & abs_Enable_HR & block_Detect_HR & overflow_High_VR & overflow_Low_VR & abs_Enable_VR & block_Detect_VR);


b2v_controlBlock_instance : controlblock
PORT MAP(SENSE_IN_HR => SENSE_HR,
		 PWM_IN_RIGHT => PWM_IN_R,
		 PWM_IN_LEFT => PWM_IN_L,
		 CLK_IN => SYNTHESIZED_WIRE_2,
		 ABS_EN_GLOBAL => ABS_EN_GLOBAL,
		 SENSE_IN_VR => SENSE_VR,
		 SENSE_IN_HL => SENSE_HL,
		 SENSE_IN_VL => SENSE_VL,
		 PWM_OUT_HR => PWM_OUT_HR,
		 OVERFLOW_LOW_OUT_HR => overflow_Low_HR,
		 OVERFLOW_HIGH_OUT_HR => overflow_High_HR,
		 ABS_ENABLE_HR => abs_Enable_HR,
		 BLOCK_DETECT_OUT_HR => block_Detect_HR,
		 PWM_OUT_VR => PWM_OUT_VR,
		 OVERFLOW_LOW_OUT_VR => overflow_Low_VR,
		 OVERFLOW_HIGH_OUT_VR => overflow_High_VR,
		 ABS_ENABLE_VR => abs_Enable_VR,
		 BLOCK_DETECT_OUT_VR => block_Detect_VR,
		 PWM_OUT_HL => PWM_OUT_HL,
		 OVERFLOW_LOW_OUT_HL => overflow_Low_HL,
		 OVERFLOW_HIGH_OUT_HL => overflow_High_HL,
		 ABS_ENABLE_HL => abs_Enable_HL,
		 BLOCK_DETECT_OUT_HL => block_Detect_HL,
		 PWM_OUT_VL => PWM_OUT_VL,
		 OVERFLOW_LOW_OUT_VL => overflow_Low_VL,
		 OVERFLOW_HIGH_OUT_VL => overflow_High_VL,
		 ABS_ENABLE_VL => abs_Enable_VL,
		 BLOCK_DETECT_OUT_VL => block_Detect_VL,
		 LUT_INPUT_OUT => LUT_INPUT_OUT,
		 LUT_OUT => LUT_OUT,
		 OUT_HIGH_HL => out_High_HL,
		 OUT_HIGH_HR => out_High_HR,
		 OUT_HIGH_VL => out_High_VL,
		 OUT_HIGH_VR => out_High_VR,
		 OUT_LOW_HL => out_Low_HL,
		 OUT_LOW_HR => out_Low_HR,
		 OUT_LOW_VL => out_Low_VL,
		 OUT_LOW_VR => out_Low_VR);


b2v_dataToSerial_instance : datatoserial
PORT MAP(clk_50 => clk_board,
		 data1 => out_Low_HR(7 DOWNTO 0),
		 data2 => out_Low_HR(15 DOWNTO 8),
		 data_1_0 => out_Low_HL(15 DOWNTO 8),
		 data_1_1 => out_High_HL(7 DOWNTO 0),
		 data_1_2 => out_High_HL(15 DOWNTO 8),
		 data_1_3 => out_Low_VL(7 DOWNTO 0),
		 data_1_4 => out_Low_VL(15 DOWNTO 8),
		 data_1_5 => out_High_VL(7 DOWNTO 0),
		 data_1_6 => out_High_VL(15 DOWNTO 8),
		 data_1_7 => GDFX_TEMP_SIGNAL_0,
		 data_1_8 => GDFX_TEMP_SIGNAL_1,
		 data_1_9 => dataX(7 DOWNTO 0),
		 data_2_0 => dataX(15 DOWNTO 8),
		 data_2_1 => LUT_INPUT_OUT(7 DOWNTO 0),
		 data_2_2 => LUT_INPUT_OUT(15 DOWNTO 8),
		 data_2_3 => LUT_OUT(7 DOWNTO 0),
		 data_2_4 => LUT_OUT(15 DOWNTO 8),
		 data_3 => out_High_HR(7 DOWNTO 0),
		 data_4 => out_High_HR(15 DOWNTO 8),
		 data_5 => out_Low_VR(7 DOWNTO 0),
		 data_6 => out_Low_VR(15 DOWNTO 8),
		 data_7 => out_High_VR(7 DOWNTO 0),
		 data_8 => out_High_VR(15 DOWNTO 8),
		 data_9 => out_Low_HL(7 DOWNTO 0),
		 serial => TX);


b2v_gSensorReader_instance : gsensorreader
PORT MAP(clk_50 => clk_board,
		 reset_n => gSensorReset,
		 SDIO => SDIO,
		 CS_N => CS_N,
		 SCLK => SCLK,
		 dataX => dataX);


b2v_inst1 : clockdivider
PORT MAP(clockin => clk_board,
		 clockout => SYNTHESIZED_WIRE_2);


b2v_inst2 : clockdividerdebug
PORT MAP(clockin => SYNTHESIZED_WIRE_2,
		 clockout => DEBUG_CLOCK100K);

xAxis(7 DOWNTO 0) <= out_Low_HR(7 DOWNTO 0);

END bdf_type;