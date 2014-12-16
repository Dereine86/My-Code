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

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "08/18/2013 12:56:56"
                                                            
-- Vhdl Test Bench template for design  :  absMain
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY absMain_vhd_tst IS
END absMain_vhd_tst;
ARCHITECTURE absMain_arch OF absMain_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL ABS_EN_GLOBAL : STD_LOGIC := '1';
SIGNAL clk_board : STD_LOGIC;
SIGNAL CS_N : STD_LOGIC;
SIGNAL DEBUG_CLOCK1M : STD_LOGIC;
SIGNAL DEBUG_CLOCK100K : STD_LOGIC;
SIGNAL gSensorReset : STD_LOGIC;
SIGNAL PWM_IN_L : STD_LOGIC;
SIGNAL PWM_IN_R : STD_LOGIC;
SIGNAL PWM_OUT_HL : STD_LOGIC;
SIGNAL PWM_OUT_HR : STD_LOGIC;
SIGNAL PWM_OUT_VL : STD_LOGIC;
SIGNAL PWM_OUT_VR : STD_LOGIC;
SIGNAL SCLK : STD_LOGIC;
SIGNAL SDIO : STD_LOGIC;
SIGNAL SENSE_HL : STD_LOGIC;
SIGNAL SENSE_HR : STD_LOGIC;
SIGNAL SENSE_VL : STD_LOGIC;
SIGNAL SENSE_VR : STD_LOGIC;
SIGNAL TX : STD_LOGIC;
SIGNAL xAxis : STD_LOGIC_VECTOR(7 DOWNTO 0);
COMPONENT absMain
	PORT (
	ABS_EN_GLOBAL : IN STD_LOGIC;
	clk_board : IN STD_LOGIC;
	CS_N : OUT STD_LOGIC;
	DEBUG_CLOCK1M : OUT STD_LOGIC;
	DEBUG_CLOCK100K : OUT STD_LOGIC;
	gSensorReset : IN STD_LOGIC;
	PWM_IN_L : IN STD_LOGIC;
	PWM_IN_R : IN STD_LOGIC;
	PWM_OUT_HL : OUT STD_LOGIC;
	PWM_OUT_HR : OUT STD_LOGIC;
	PWM_OUT_VL : OUT STD_LOGIC;
	PWM_OUT_VR : OUT STD_LOGIC;
	SCLK : OUT STD_LOGIC;
	SDIO : INOUT STD_LOGIC;
	SENSE_HL : IN STD_LOGIC;
	SENSE_HR : IN STD_LOGIC;
	SENSE_VL : IN STD_LOGIC;
	SENSE_VR : IN STD_LOGIC;
	TX : OUT STD_LOGIC;
	xAxis : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : absMain
	PORT MAP (
-- list connections between master ports and signals
	ABS_EN_GLOBAL => ABS_EN_GLOBAL,
	clk_board => clk_board,
	CS_N => CS_N,
	DEBUG_CLOCK1M => DEBUG_CLOCK1M,
	DEBUG_CLOCK100K => DEBUG_CLOCK100K,
	gSensorReset => gSensorReset,
	PWM_IN_L => PWM_IN_L,
	PWM_IN_R => PWM_IN_R,
	PWM_OUT_HL => PWM_OUT_HL,
	PWM_OUT_HR => PWM_OUT_HR,
	PWM_OUT_VL => PWM_OUT_VL,
	PWM_OUT_VR => PWM_OUT_VR,
	SCLK => SCLK,
	SDIO => SDIO,
	SENSE_HL => SENSE_HL,
	SENSE_HR => SENSE_HR,
	SENSE_VL => SENSE_VL,
	SENSE_VR => SENSE_VR,
	TX => TX,
	xAxis => xAxis
	);
clock : PROCESS
BEGIN
  wait for 10 ns;
  clk_board <= '0';
  wait for 10 ns;
  clk_board <= '1';
END PROCESS clock;


--sensor1 : PROCESS                
--BEGIN                                                    
--	 wait for 10 ms;
--	 SENSE_HR <= '0';
--	 wait for 10 ms;
--	 SENSE_HR <= '1';
--	 wait for 10 ms;
--	 SENSE_HR <= '0';
--	 wait for 10 ms;
--	 SENSE_HR <= '1';
--	 wait for 10 ms;
--	 SENSE_HR <= '0';
--	 wait for 10 ms;
--	 SENSE_HR <= '1';	 	 
--	 wait for 11 ms;
--	 SENSE_HR <= '0';
--	 wait for 12 ms;
--	 SENSE_HR <= '1';
--	 wait for 17 ms;
--	 SENSE_HR <= '0';
--	 wait for 12 ms;
--	 SENSE_HR <= '1';
--	 wait for 12 ms;
--	 SENSE_HR <= '0';
--	 wait for 13 ms;
--	 SENSE_HR <= '1';
--	 wait for 13 ms;
--	 SENSE_HR <= '0';
--	 wait for 13 ms;
--	 SENSE_HR <= '1';
--END PROCESS sensor1;

sensor2 : PROCESS                
BEGIN                                                    
    SENSE_HL <= '0';
	 wait for 1600 us;
	 SENSE_HL <= '1';
	 wait for 2410 us;
	 SENSE_HL <= '0';
	 wait for 1600 us;
	 SENSE_HL <= '1';
	 wait for 2410 us;
	 SENSE_HL <= '0';	 
	 wait for 1600 us;
	 SENSE_HL <= '1';
	 wait for 2410 us;
	 SENSE_HL <= '0';	 
    wait for 5000 us;
    SENSE_HL <= '1';
	 wait for 2500 us;
END PROCESS sensor2;

pwminputright : PROCESS                                               
-- variable declarations                                     
BEGIN  
  PWM_IN_R <= '1';
  wait for 1940 us;
  PWM_IN_R <= '0';
  wait for 18060 us;
  
END PROCESS pwminputright;                                          

pwminputleft : PROCESS                                               
-- variable declarations                                     
BEGIN  
  PWM_IN_L <= '1';
  wait for 1060 us;
  PWM_IN_L <= '0';
  wait for 18940 us;
  
END PROCESS pwminputleft;
END absMain_arch;
