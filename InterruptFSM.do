vsim -gui work.interruptfsm
# vsim -gui work.interruptfsm 
# Start time: 03:32:26 on Apr 27,2024
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.interruptfsm(interruptfsm_arch)
# vsim -gui work.interruptfsm 
# Start time: 03:31:45 on Apr 27,2024
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.interruptfsm(interruptfsm_arch)
# vsim -gui work.interruptfsm 
# Start time: 03:29:27 on Apr 27,2024
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.interruptfsm(interruptfsm_arch)
add wave -position end  sim:/interruptfsm/clk
add wave -position end  sim:/interruptfsm/int
add wave -position end  sim:/interruptfsm/rti
add wave -position end  sim:/interruptfsm/stall
add wave -position end  sim:/interruptfsm/flagsOrPC
add wave -position end  sim:/interruptfsm/prevStall
add wave -position end  sim:/interruptfsm/tempFlagsOrPC
force -freeze sim:/interruptfsm/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/interruptfsm/int 0 0
force -freeze sim:/interruptfsm/rti 0 0
run
run
force -freeze sim:/interruptfsm/int 1 0
run
run
run
run
force -freeze sim:/interruptfsm/int 0 0
run
run
run
run
run
run
force -freeze sim:/interruptfsm/rti 1 0
run
run
run
run
force -freeze sim:/interruptfsm/rti 0 0
run
run
run
run
run