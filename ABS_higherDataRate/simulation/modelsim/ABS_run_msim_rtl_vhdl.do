transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/controlBlock.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/absControlVR.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/absControlVL.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/absControlHR.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/absControlHL.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/absMain.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/LUT.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/fixed_point_lib/fixed_float_types_c.vhdl}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/lutmultiplexer.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/gSensorReader.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/dataToSerial.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/clockdivider100k.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/clockdivider.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/breakControlRight.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/breakControlLeft.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/rpmMeasure.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/busmultiplexer.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/fixed_point_lib/fixed_pkg_c.vhdl}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/blockComparatorVR.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/blockComparatorVL.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/blockComparatorHR.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/blockComparatorHL.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/dutycyclenormalizationHR.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/dutycyclenormalizationHL.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/dutycyclenormalizationVL.vhd}
vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/dutyCycleNormalizationVR.vhd}

vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/simulation/modelsim/absMain.vht}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive -L rtl_work -L work -voptargs="+acc"  absMain_vhd_tst

add wave *
view structure
view signals
run -all
