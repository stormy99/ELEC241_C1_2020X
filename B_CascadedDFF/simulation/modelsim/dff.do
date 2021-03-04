run -all

add wave -position insertpoint  \
sim:/elec241_shift_register/NUM_STAGES \
sim:/elec241_shift_register/clk \
sim:/elec241_shift_register/enable \
sim:/elec241_shift_register/data_in \
sim:/elec241_shift_register/data_out

force enable 0
force clk 0
force data_in 0
run 100ps

force enable 0
force clk 0
force data_in 1
run 100ps

force enable 0
force clk 1
force data_in 0
run 100ps

force enable 0
force clk 1
force data_in 1
run 100ps

force enable 1
force clk 0
force data_in 0
run 100ps

force enable 1
force clk 0
force data_in 1
run 100ps

force enable 1
force clk 1
force data_in 0
run 100ps

force enable 1
force clk 1
force data_in 1
run 100ps