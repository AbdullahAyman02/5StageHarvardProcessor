vsim -gui work.integration
mem load -i {C:/Users/islam/OneDrive/Desktop/Spring 24/CMPN301 - Computer Architecture/Project/5StageHarvardProcessor/Assembler/memfile.mem} /integration/Fetch1/InstructionCache1/inst
add wave -position end  sim:/integration/clk
add wave -position end  sim:/integration/rst
add wave -position end  sim:/integration/int
add wave -position end  sim:/integration/Fetch_PC
add wave -position end  sim:/integration/Fetch_Instruction
add wave -position end  sim:/integration/Fetch_Int
add wave -position end  sim:/integration/PC_To_Store
add wave -position end  sim:/integration/Decode1/RegisterFile1/output1
add wave -position end  sim:/integration/Decode1/RegisterFile1/output2
add wave -position end  sim:/integration/Decode1/RegisterFile1/output3
add wave -position end  sim:/integration/Decode1/RegisterFile1/output4
add wave -position end  sim:/integration/Decode1/RegisterFile1/output5
add wave -position end  sim:/integration/Decode1/RegisterFile1/output6
add wave -position end  sim:/integration/Decode1/RegisterFile1/output7
add wave -position end  sim:/integration/Decode1/RegisterFile1/output8
add wave -position end  sim:/integration/Memory1/Memory1/memory
add wave -position 15  sim:/integration/StackPointerCircuit/stackPointer
add wave -position 16  sim:/integration/StackPointerCircuit/push_address
add wave -position 17  sim:/integration/StackPointerCircuit/pop_address
add wave -position 7  sim:/integration/Interrupt1/int
add wave -position 8  sim:/integration/Interrupt1/retRtiCounter
add wave -position 9  sim:/integration/Interrupt1/branch
add wave -position 10  sim:/integration/Interrupt1/decodeConditionalBranch
add wave -position 11  sim:/integration/Interrupt1/intFSM
add wave -position 12  sim:/integration/Interrupt1/latchedInterrupt
add wave -position 13  sim:/integration/BranchingController1/two_bit_PC_selector
add wave -position 14  sim:/integration/BranchingController1/branch_out
add wave -position 3  sim:/integration/Output_Port
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
run
run
run
run
run
run
run
run
run