vsim -gui work.integration
mem load -i {C:/Users/islam/OneDrive/Desktop/Spring 24/CMPN301 - Computer Architecture/Project/5StageHarvardProcessor/Assembler/memfile.mem} /integration/Fetch1/InstructionCache1/inst
add wave -position end  sim:/integration/clk
add wave -position end  sim:/integration/rst
add wave -position end  sim:/integration/int
add wave -position end  sim:/integration/Fetch_PC
add wave -position end  sim:/integration/Decode1/RegisterFile1/output1
add wave -position end  sim:/integration/Decode1/RegisterFile1/output2
add wave -position end  sim:/integration/Decode1/RegisterFile1/output3
add wave -position end  sim:/integration/Decode1/RegisterFile1/output4
add wave -position end  sim:/integration/Decode1/RegisterFile1/output5
add wave -position end  sim:/integration/Decode1/RegisterFile1/output6
add wave -position end  sim:/integration/Decode1/RegisterFile1/output7
add wave -position end  sim:/integration/Decode1/RegisterFile1/output8
add wave -position end  sim:/integration/Fetch1/PC1/inst_address
add wave -position end  sim:/integration/Fetch1/PC1/update
add wave -position end  sim:/integration/Fetch1/PC1/curr_address
add wave -position end  sim:/integration/RetRtiCounter1/ret_rti
add wave -position end  sim:/integration/RetRtiCounter1/enable
add wave -position end  sim:/integration/RetRtiCounter1/stall
add wave -position end  sim:/integration/RetRtiCounter1/temp
add wave -position end  sim:/integration/Memory1/Memory1/data_in
add wave -position end  sim:/integration/InterruptFSM1/stall
add wave -position end  sim:/integration/InterruptFSM1/flagsOrPC
add wave -position end  sim:/integration/Memory1/Memory1/memory
add wave -position 19  sim:/integration/Memory1/Mux4_1/input1
add wave -position 20  sim:/integration/Memory1/Mux4_1/input2
add wave -position 21  sim:/integration/Memory1/Mux4_1/input3
add wave -position 22  sim:/integration/Memory1/Mux4_1/input4
add wave -position 23  sim:/integration/Memory1/Mux4_1/selectors
add wave -position 24  sim:/integration/Execution1/FlagRegister_1/flag_out
add wave -position 25  sim:/integration/Execution1/ALU_1/flags_out
add wave -position 4  sim:/integration/Execution1/ALU_1/opcode
add wave -position 5  sim:/integration/Execution1/ALU_1/func
add wave -position 7  sim:/integration/Execution1/FlagRegister_1/rti
add wave -position 8  sim:/integration/Execution1/FlagRegister_1/alu_flag_in
add wave -position 9  sim:/integration/Execution1/FlagRegister_1/rti_flag_in
add wave -position 4  sim:/integration/Fetch1/PC1/ret_rti
add wave -position 36  sim:/integration/StackPointerCircuit/func
add wave -position 37  sim:/integration/StackPointerCircuit/int
add wave -position 38  sim:/integration/StackPointerCircuit/stackPointer
add wave -position 39  sim:/integration/StackPointerCircuit/push_address
add wave -position 40  sim:/integration/StackPointerCircuit/pop_address
add wave -position 4  sim:/integration/Fetch1/InstructionCache1/instruction
add wave -position 5  sim:/integration/Decode1/Controller1/OPCODE
add wave -position 6  sim:/integration/Decode1/Controller1/FUNCTION_BITS
add wave -position 7  sim:/integration/Decode1/Controller1/CONTROL_SIGNALS
force -freeze sim:/integration/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/integration/rst 1 0
run
force -freeze sim:/integration/rst 0 0
run
run
run
run
run
run
run
run
run
run
run
force -freeze sim:/integration/int 1 0
run
force -freeze sim:/integration/int 0 0
run
run
run
run
run
run
run