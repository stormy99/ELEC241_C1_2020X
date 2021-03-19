transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/Tom/Desktop/Coursework/ELEC241/C1/ELEC241_C1_2020X/C_ControllerDatapath/big_mux_4.vhd}
vcom -93 -work work {C:/Users/Tom/Desktop/Coursework/ELEC241/C1/ELEC241_C1_2020X/C_ControllerDatapath/simplereg.vhd}
vcom -93 -work work {C:/Users/Tom/Desktop/Coursework/ELEC241/C1/ELEC241_C1_2020X/C_ControllerDatapath/unsigned_adder_b.vhd}
vcom -93 -work work {C:/Users/Tom/Desktop/Coursework/ELEC241/C1/ELEC241_C1_2020X/C_ControllerDatapath/constant_literal.vhd}

do "C:/Users/Tom/Desktop/Coursework/ELEC241/C1/ELEC241_C1_2020X/C_ControllerDatapath/simulation/modelsim/build.do"
