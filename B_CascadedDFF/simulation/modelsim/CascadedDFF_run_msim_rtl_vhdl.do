transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/Tom/Desktop/Coursework/ELEC241/C1/ELEC241_C1_2020X/B_CascadedDFF/elec241_shift_register.vhd}

do "C:/Users/Tom/Desktop/Coursework/ELEC241/C1/ELEC241_C1_2020X/B_CascadedDFF/simulation/modelsim/setup.do"
