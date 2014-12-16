/*
 Copyright (C) 1991-2012 Altera Corporation
 Your use of Altera Corporation's design tools, logic functions 
 and other software and tools, and its AMPP partner logic 
 functions, and any output files from any of the foregoing 
 (including device programming or simulation files), and any 
 associated documentation or information are expressly subject 
 to the terms and conditions of the Altera Program License 
 Subscription Agreement, Altera MegaCore Function License 
 Agreement, or other applicable license agreement, including, 
 without limitation, that your use is for the sole purpose of 
 programming logic devices manufactured by Altera and sold by 
 Altera or its authorized distributors.  Please refer to the 
 applicable agreement for further details.
*/
MODEL
/*MODEL HEADER*/
/*
 This file contains Fast Corner delays for the design using part EP4CE22F17C6
 with speed grade M, core voltage 1.2V, and temperature 0 Celsius

*/
MODEL_VERSION "1.0";
DESIGN "ABS";
DATE "02/07/2014 14:07:28";
PROGRAM "Quartus II 64-Bit";



INPUT clk_board;
INPUT PWM_IN_R;
INPUT PWM_IN_L;
INPUT SENSE_HR;
INPUT SENSE_VR;
INPUT SENSE_VL;
INPUT SENSE_HL;
INPUT gSensorReset;
INOUT SDIO;
INPUT ABS_EN_GLOBAL;
OUTPUT TX;
OUTPUT CS_N;
OUTPUT SCLK;
OUTPUT PWM_OUT_VR;
OUTPUT PWM_OUT_HR;
OUTPUT PWM_OUT_VL;
OUTPUT PWM_OUT_HL;
OUTPUT DEBUG_CLOCK1M;
OUTPUT DEBUG_CLOCK100K;
OUTPUT xAxis[7];
OUTPUT xAxis[6];
OUTPUT xAxis[5];
OUTPUT xAxis[4];
OUTPUT xAxis[3];
OUTPUT xAxis[2];
OUTPUT xAxis[1];
OUTPUT xAxis[0];

/*Arc definitions start here*/
pos_gSensorReset__clk_board__setup:		SETUP (POSEDGE) gSensorReset clk_board ;
pos_ABS_EN_GLOBAL__clockdivider:inst1|clockout__setup:		SETUP (POSEDGE) ABS_EN_GLOBAL clockdivider:inst1|clockout ;
pos_PWM_IN_L__clockdivider:inst1|clockout__setup:		SETUP (POSEDGE) PWM_IN_L clockdivider:inst1|clockout ;
pos_PWM_IN_R__clockdivider:inst1|clockout__setup:		SETUP (POSEDGE) PWM_IN_R clockdivider:inst1|clockout ;
pos_SENSE_HL__clockdivider:inst1|clockout__setup:		SETUP (POSEDGE) SENSE_HL clockdivider:inst1|clockout ;
pos_SENSE_HR__clockdivider:inst1|clockout__setup:		SETUP (POSEDGE) SENSE_HR clockdivider:inst1|clockout ;
pos_SENSE_VL__clockdivider:inst1|clockout__setup:		SETUP (POSEDGE) SENSE_VL clockdivider:inst1|clockout ;
pos_SENSE_VR__clockdivider:inst1|clockout__setup:		SETUP (POSEDGE) SENSE_VR clockdivider:inst1|clockout ;
pos_SDIO__gSensorReader:gSensorReader_instance|SCLKinternal__setup:		SETUP (POSEDGE) SDIO gSensorReader:gSensorReader_instance|SCLKinternal ;
pos_gSensorReset__gSensorReader:gSensorReader_instance|SCLKinternal__setup:		SETUP (POSEDGE) gSensorReset gSensorReader:gSensorReader_instance|SCLKinternal ;
pos_gSensorReset__clk_board__hold:		HOLD (POSEDGE) gSensorReset clk_board ;
pos_ABS_EN_GLOBAL__clockdivider:inst1|clockout__hold:		HOLD (POSEDGE) ABS_EN_GLOBAL clockdivider:inst1|clockout ;
pos_PWM_IN_L__clockdivider:inst1|clockout__hold:		HOLD (POSEDGE) PWM_IN_L clockdivider:inst1|clockout ;
pos_PWM_IN_R__clockdivider:inst1|clockout__hold:		HOLD (POSEDGE) PWM_IN_R clockdivider:inst1|clockout ;
pos_SENSE_HL__clockdivider:inst1|clockout__hold:		HOLD (POSEDGE) SENSE_HL clockdivider:inst1|clockout ;
pos_SENSE_HR__clockdivider:inst1|clockout__hold:		HOLD (POSEDGE) SENSE_HR clockdivider:inst1|clockout ;
pos_SENSE_VL__clockdivider:inst1|clockout__hold:		HOLD (POSEDGE) SENSE_VL clockdivider:inst1|clockout ;
pos_SENSE_VR__clockdivider:inst1|clockout__hold:		HOLD (POSEDGE) SENSE_VR clockdivider:inst1|clockout ;
pos_SDIO__gSensorReader:gSensorReader_instance|SCLKinternal__hold:		HOLD (POSEDGE) SDIO gSensorReader:gSensorReader_instance|SCLKinternal ;
pos_gSensorReset__gSensorReader:gSensorReader_instance|SCLKinternal__hold:		HOLD (POSEDGE) gSensorReset gSensorReader:gSensorReader_instance|SCLKinternal ;
pos_clockdivider:inst1|clockout__DEBUG_CLOCK1M__delay:		DELAY (POSEDGE) clockdivider:inst1|clockout DEBUG_CLOCK1M ;
pos_clockdivider:inst1|clockout__DEBUG_CLOCK1M__delay:		DELAY (POSEDGE) clockdivider:inst1|clockout DEBUG_CLOCK1M ;
pos_clockdivider:inst1|clockout__DEBUG_CLOCK100K__delay:		DELAY (POSEDGE) clockdivider:inst1|clockout DEBUG_CLOCK100K ;
pos_clockdivider:inst1|clockout__PWM_OUT_HL__delay:		DELAY (POSEDGE) clockdivider:inst1|clockout PWM_OUT_HL ;
pos_clockdivider:inst1|clockout__PWM_OUT_HR__delay:		DELAY (POSEDGE) clockdivider:inst1|clockout PWM_OUT_HR ;
pos_clockdivider:inst1|clockout__PWM_OUT_VL__delay:		DELAY (POSEDGE) clockdivider:inst1|clockout PWM_OUT_VL ;
pos_clockdivider:inst1|clockout__PWM_OUT_VR__delay:		DELAY (POSEDGE) clockdivider:inst1|clockout PWM_OUT_VR ;
pos_clockdivider:inst1|clockout__xAxis[0]__delay:		DELAY (POSEDGE) clockdivider:inst1|clockout xAxis[0] ;
pos_clockdivider:inst1|clockout__xAxis[1]__delay:		DELAY (POSEDGE) clockdivider:inst1|clockout xAxis[1] ;
pos_clockdivider:inst1|clockout__xAxis[2]__delay:		DELAY (POSEDGE) clockdivider:inst1|clockout xAxis[2] ;
pos_clockdivider:inst1|clockout__xAxis[3]__delay:		DELAY (POSEDGE) clockdivider:inst1|clockout xAxis[3] ;
pos_clockdivider:inst1|clockout__xAxis[4]__delay:		DELAY (POSEDGE) clockdivider:inst1|clockout xAxis[4] ;
pos_clockdivider:inst1|clockout__xAxis[5]__delay:		DELAY (POSEDGE) clockdivider:inst1|clockout xAxis[5] ;
pos_clockdivider:inst1|clockout__xAxis[6]__delay:		DELAY (POSEDGE) clockdivider:inst1|clockout xAxis[6] ;
pos_clockdivider:inst1|clockout__xAxis[7]__delay:		DELAY (POSEDGE) clockdivider:inst1|clockout xAxis[7] ;
pos_dataToSerial:dataToSerial_instance|serialClk__TX__delay:		DELAY (POSEDGE) dataToSerial:dataToSerial_instance|serialClk TX ;
pos_gSensorReader:gSensorReader_instance|SCLKinternal__CS_N__delay:		DELAY (POSEDGE) gSensorReader:gSensorReader_instance|SCLKinternal CS_N ;
pos_gSensorReader:gSensorReader_instance|SCLKinternal__SCLK__delay:		DELAY (POSEDGE) gSensorReader:gSensorReader_instance|SCLKinternal SCLK ;
pos_gSensorReader:gSensorReader_instance|SCLKinternal__SCLK__delay:		DELAY (POSEDGE) gSensorReader:gSensorReader_instance|SCLKinternal SCLK ;
pos_gSensorReader:gSensorReader_instance|SCLKinternal__SDIO__delay:		DELAY (POSEDGE) gSensorReader:gSensorReader_instance|SCLKinternal SDIO ;

ENDMODEL
