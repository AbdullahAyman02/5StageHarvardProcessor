vsim -gui work.alu 
# vsim -gui work.alu 
# Start time: 18:19:07 on Apr 13,2024
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.alu(alu_arch)
# Loading work.nbitfulladder(struct_nbitfulladder)
# Loading work.singlebitadder(struct_singlebitadder)
# Start time: 17:29:10 on Apr 13,2024
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.alu(alu_arch)
# Loading work.nbitfulladder(struct_nbitfulladder)
# Loading work.singlebitadder(struct_singlebitadder)
add wave -position end  sim:/alu/A
add wave -position end  sim:/alu/B
add wave -position end  sim:/alu/opcode
add wave -position end  sim:/alu/func
add wave -position end  sim:/alu/flags_in
add wave -position end  sim:/alu/alu_operation
add wave -position end  sim:/alu/result
add wave -position end  sim:/alu/flags_out
add wave -position end  sim:/alu/B_bar
add wave -position end  sim:/alu/first_input
add wave -position end  sim:/alu/second_input
add wave -position end  sim:/alu/alu_result
add wave -position end  sim:/alu/Cin_input
add wave -position end  sim:/alu/Cout
add wave -position end  sim:/alu/alu_and
add wave -position end  sim:/alu/alu_or
add wave -position end  sim:/alu/alu_xor
add wave -position end  sim:/alu/alu_not
force -freeze sim:/alu/A 'h73f57a2a 0
force -freeze sim:/alu/B 'h4ab637e2 0
force -freeze sim:/alu/opcode 001 0
force -freeze sim:/alu/func 111 0
force -freeze sim:/alu/flags_in 0000 0
force -freeze sim:/alu/alu_operation 1 0
run
force -freeze sim:/alu/func 110 0
run
force -freeze sim:/alu/func 000 0
run
force -freeze sim:/alu/func 001 0
run
force -freeze sim:/alu/func 011 0
run
force -freeze sim:/alu/func 100 0
run
force -freeze sim:/alu/func 101 0
run
force -freeze sim:/alu/func 010 0
run
force -freeze sim:/alu/func 000 0
run
force -freeze sim:/alu/func 111 0
run
force -freeze sim:/alu/opcode 010 0
force -freeze sim:/alu/func 011 0
run
force -freeze sim:/alu/func 010 0
run
force -freeze sim:/alu/func 000 0
run
force -freeze sim:/alu/func 001 0
run
