vsim -gui work.execution
# vsim -gui work.execution 
# Start time: 18:23:40 on Apr 14,2024
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.execution(execution_arch)
# Loading work.mux8(struct_mux8)
# Loading work.mux4(struct_mux4)
# Loading work.mux2(struct_mux2)
# Loading work.flagregister(flagregister_arch)
# Loading work.alu(alu_arch)
# Loading work.my_nadder(a_my_adder)
# Loading work.my_adder(a_my_adder)
# vsim -gui work.execution 
# Start time: 18:17:14 on Apr 14,2024
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.execution(execution_arch)
# Loading work.mux8(struct_mux8)
# Loading work.mux4(struct_mux4)
# Loading work.mux2(struct_mux2)
# Loading work.flagregister(flagregister_arch)
# Loading work.alu(alu_arch)
# Loading work.my_nadder(a_my_adder)
# Loading work.my_adder(a_my_adder)
# vsim -gui work.execution 
# Start time: 18:15:21 on Apr 14,2024
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.execution(execution_arch)
# Loading work.mux8(struct_mux8)
# Loading work.mux4(struct_mux4)
# Loading work.mux2(struct_mux2)
# Loading work.flagregister(flagregister_arch)
# Loading work.alu(alu_arch)
# Loading work.my_nadder(a_my_adder)
# Loading work.my_adder(a_my_adder)
# vsim -gui work.execution 
# Start time: 18:08:48 on Apr 14,2024
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.execution(execution_arch)
# Loading work.mux8(struct_mux8)
# Loading work.mux4(struct_mux4)
# Loading work.mux2(struct_mux2)
# Loading work.flagregister(flagregister_arch)
# Loading work.alu(alu_arch)
# Loading work.my_nadder(a_my_adder)
# Loading work.my_adder(a_my_adder)
# vsim -gui work.execution 
# Start time: 16:23:01 on Apr 14,2024
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.execution(execution_arch)
# Loading work.mux8(struct_mux8)
# Loading work.mux4(struct_mux4)
# Loading work.mux2(struct_mux2)
# Loading work.flagregister(flagregister_arch)
# Loading work.alu(alu_arch)
# Loading work.my_nadder(a_my_adder)
# Loading work.my_adder(a_my_adder)
# vsim -gui work.execution 
# Start time: 06:09:57 on Apr 14,2024
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading work.execution(execution_arch)
# Loading work.mux8(mux8_arch)
# Loading work.mux2(mux2_arch)
# Loading work.flagregister(flagregister_arch)
# Loading work.alu(alu_arch)
# Loading work.nbitfulladder(struct_nbitfulladder)
# Loading work.singlebitadder(struct_singlebitadder)
add wave -position end  sim:/execution/RS1_data
add wave -position end  sim:/execution/RS2_data
add wave -position end  sim:/execution/Immediate_value
add wave -position end  sim:/execution/Opcode
add wave -position end  sim:/execution/Controls
add wave -position end  sim:/execution/Input_port
add wave -position end  sim:/execution/Clock
add wave -position end  sim:/execution/Reset
add wave -position end  sim:/execution/Imm
add wave -position end  sim:/execution/RS2_data_out
add wave -position end  sim:/execution/ALU_result
add wave -position end  sim:/execution/Flags
add wave -position end  sim:/execution/Output_port
force -freeze sim:/execution/RS1_data 'h000000a8 0
force -freeze sim:/execution/RS2_data 'h0000004e 0
force -freeze sim:/execution/Immediate_value 'h000000c3 0
force -freeze sim:/execution/Clock 0 0, 1 {50 ps} -r 100
force -freeze sim:/execution/Reset 1 0
force -freeze sim:/execution/Imm 0 0
force -freeze sim:/execution/Controls 100 0
force -freeze sim:/execution/Opcode 001111 0
run
force -freeze sim:/execution/Reset 0 0
run
force -freeze sim:/execution/Opcode 001110 0
run
force -freeze sim:/execution/Opcode 001000 0
run
force -freeze sim:/execution/Opcode 001001 0
run
force -freeze sim:/execution/Opcode 001011 0
run
force -freeze sim:/execution/Opcode 001100 0
run
force -freeze sim:/execution/Opcode 001101 0
run
force -freeze sim:/execution/Opcode 001010 0
run
force -freeze sim:/execution/Imm 1 0
force -freeze sim:/execution/Opcode 001000 0
run
force -freeze sim:/execution/Opcode 001001 0
run
force -freeze sim:/execution/Opcode 001111 0
run
force -freeze sim:/execution/Opcode 010011 0
run
force -freeze sim:/execution/Opcode 010010 0
run
force -freeze sim:/execution/Imm 0 0
run
force -freeze sim:/execution/Opcode 010000 0
run
force -freeze sim:/execution/Imm 1 0
run
force -freeze sim:/execution/Opcode 010001 0
run
force -freeze sim:/execution/Imm 0 0
run
force -freeze sim:/execution/Opcode 100010 0
force -freeze sim:/execution/Controls 000 0
force -freeze sim:/execution/Imm 1 0
run
force -freeze sim:/execution/Opcode 100000 0
run
force -freeze sim:/execution/Opcode 101000 0
run
force -freeze sim:/execution/Opcode 101001 0
run
force -freeze sim:/execution/Controls 010 0
force -freeze sim:/execution/Input_port 'h00000032 0
run
force -freeze sim:/execution/Controls 001 0
force -freeze sim:/execution/Imm 0 0
run
force -freeze sim:/execution/Opcode 101000 0
run
run
force -freeze sim:/execution/Controls 010 0
run
