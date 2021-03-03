add wave -position insertpoint  \
sim:/seven_seg_decode/input \
sim:/seven_seg_decode/reset \
sim:/seven_seg_decode/en \
sim:/seven_seg_decode/output

force input 0000
run 100ps

force input 0001
run 100ps

force input 0010
run 100ps

force input 0011
run 100ps

force input 0100
run 100ps

force input 0101
run 100ps

force input 0110
run 100ps

force input 0111
run 100ps

force input 1000
run 100ps

force input 1001
run 100ps

force input 1010
run 100ps

force input 1011
run 100ps

force input 1100
run 100ps

force input 1101
run 100ps

force input 1110
run 100ps

force input 1111
run 100ps