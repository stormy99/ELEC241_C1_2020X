transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/Tom/Desktop/Coursework/ELEC241/C1/ELEC241_C1_2020X/A_SevenSeg/binary_counter.vhd}
vcom -93 -work work {C:/Users/Tom/Desktop/Coursework/ELEC241/C1/ELEC241_C1_2020X/A_SevenSeg/seven_seg_decode.vhd}

vcom -93 -work work {C:/Users/Tom/Desktop/Coursework/ELEC241/C1/ELEC241_C1_2020X/A_SevenSeg/simulation/modelsim/seven_seg_decode.vht}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive -L rtl_work -L work -voptargs="+acc"  seven_seg_decode

add wave *
view structure
view signals
run -all
