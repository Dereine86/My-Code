transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vcom -93 -work work {ABS_6_1200mv_85c_slow.vho}

vcom -93 -work work {C:/Users/Johannes/Documents/Uni/Bachelorarbeit/FPGA-Projektordner/ABS/simulation/modelsim/absMain.vht}

vsim -t 1ps +transport_int_delays +transport_path_delays -sdftyp /absMain_vhd_tst=ABS_6_1200mv_85c_vhd_slow.sdo -L altera -L cycloneive -L gate_work -L work -voptargs="+acc"  absMain_vhd_tst

add wave *
view structure
view signals
run -all
