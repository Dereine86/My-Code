###############################################################################
# Copyright (C) 1991-2009 Altera Corporation
# Any  megafunction  design,  and related netlist (encrypted  or  decrypted),
# support information,  device programming or simulation file,  and any other
# associated  documentation or information  provided by  Altera  or a partner
# under  Altera's   Megafunction   Partnership   Program  may  be  used  only
# to program  PLD  devices (but not masked  PLD  devices) from  Altera.   Any
# other  use  of such  megafunction  design,  netlist,  support  information,
# device programming or simulation file,  or any other  related documentation
# or information  is prohibited  for  any  other purpose,  including, but not
# limited to  modification,  reverse engineering,  de-compiling, or use  with
# any other  silicon devices,  unless such use is  explicitly  licensed under
# a separate agreement with  Altera  or a megafunction partner.  Title to the
# intellectual property,  including patents,  copyrights,  trademarks,  trade
# secrets,  or maskworks,  embodied in any such megafunction design, netlist,
# support  information,  device programming or simulation file,  or any other
# related documentation or information provided by  Altera  or a megafunction
# partner, remains with Altera, the megafunction partner, or their respective
# licensors. No other licenses, including any licenses needed under any third
# party's intellectual property, are provided herein.
#
###############################################################################


# FPGA Xchange file generated using Quartus II Version 12.1 Build 243 01/31/2013 Service Pack 1 SJ Full Version

# DESIGN=ABS
# REVISION=ABS
# DEVICE=EP4CE22
# PACKAGE=FBGA
# SPEEDGRADE=6

Signal Name,Pin Number,Direction,IO Standard,Drive (mA),Termination,Slew Rate,Swap Group,Diff Type

TX,T14,output,3.3-V LVCMOS,2,Off,FAST,swap_0,--
CS_N,G5,output,2.5 V,Default,Series 50 Ohm without Calibration,FAST,swap_1,--
SCLK,F2,output,2.5 V,Default,Series 50 Ohm without Calibration,FAST,swap_1,--
PWM_OUT_VR,N14,output,3.3-V LVCMOS,2,Off,FAST,swap_0,--
PWM_OUT_HR,L13,output,3.3-V LVCMOS,2,Off,FAST,swap_0,--
PWM_OUT_VL,K16,output,3.3-V LVCMOS,2,Off,FAST,swap_0,--
PWM_OUT_HL,J14,output,3.3-V LVCMOS,2,Off,FAST,swap_0,--
DEBUG_CLOCK1M,D8,output,2.5 V,Default,Series 50 Ohm without Calibration,FAST,swap_1,--
DEBUG_CLOCK100K,A4,output,2.5 V,Default,Series 50 Ohm without Calibration,FAST,swap_1,--
xAxis[7],A15,output,3.3-V LVCMOS,2,Off,FAST,swap_0,--
xAxis[6],A13,output,3.3-V LVCMOS,2,Off,FAST,swap_0,--
xAxis[5],B13,output,3.3-V LVCMOS,2,Off,FAST,swap_0,--
xAxis[4],A11,output,3.3-V LVCMOS,2,Off,FAST,swap_0,--
xAxis[3],D1,output,2.5 V,Default,Series 50 Ohm without Calibration,FAST,swap_1,--
xAxis[2],F3,output,2.5 V,Default,Series 50 Ohm without Calibration,FAST,swap_1,--
xAxis[1],B1,output,2.5 V,Default,Series 50 Ohm without Calibration,FAST,swap_1,--
xAxis[0],L3,output,2.5 V,Default,Series 50 Ohm without Calibration,FAST,swap_1,--
SDIO,F1,bidir,2.5 V,,Off,--,swap_2,--
gSensorReset,E16,input,2.5 V,,Off,--,swap_3,--
clk_board,R8,input,3.3-V LVCMOS,,Off,--,swap_4,--
PWM_IN_R,L14,input,3.3-V LVCMOS,,Off,--,swap_4,--
ABS_EN_GLOBAL,M15,input,3.3-V LVTTL,,Off,--,swap_5,--
PWM_IN_L,J16,input,3.3-V LVCMOS,,Off,--,swap_4,--
SENSE_HR,T13,input,3.3-V LVCMOS,,Off,--,swap_4,--
SENSE_VR,T12,input,3.3-V LVCMOS,,Off,--,swap_4,--
SENSE_VL,T15,input,3.3-V LVCMOS,,Off,--,swap_4,--
SENSE_HL,F13,input,3.3-V LVCMOS,,Off,--,swap_4,--
~ALTERA_ASDO_DATA1~,C1,input,2.5 V,,Off,--,NOSWAP,--
~ALTERA_FLASH_nCE_nCSO~,D2,input,2.5 V,,Off,--,NOSWAP,--
~ALTERA_DCLK~,H1,output,2.5 V,Default,Off,FAST,NOSWAP,--
~ALTERA_DATA0~,H2,input,2.5 V,,Off,--,NOSWAP,--
~ALTERA_nCEO~,F16,output,2.5 V,8,Off,FAST,NOSWAP,--
