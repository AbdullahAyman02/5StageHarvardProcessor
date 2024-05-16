vsim -gui work.integration
add wave -position end  sim:/integration/clk
add wave -position end  sim:/integration/rst
add wave -position end  sim:/integration/int
add wave -position end  sim:/integration/Fetch_PC
add wave -position end  sim:/integration/RetRtiCounter1/ret_rti
add wave -position end  sim:/integration/RetRtiCounter1/enable
add wave -position end  sim:/integration/RetRtiCounter1/stall
add wave -position end  sim:/integration/RetRtiCounter1/temp
add wave -position end  sim:/integration/Memory1/Memory1/data_in
add wave -position end  sim:/integration/FETCH_DECODE/q
add wave -position end  sim:/integration/DECODE_EXECUTE/q
add wave -position end  sim:/integration/EXECUTE_MEMORY/q
add wave -position 12  sim:/integration/Memory1/PC
add wave -position 13  sim:/integration/Memory1/mux4_selector
add wave -position end  sim:/integration/Memory1/Memory1/memory
add wave -position 13  sim:/integration/Memory1/Mux4_1/output
add wave -position 13  sim:/integration/Memory1/Mux4_1/input1
add wave -position 14  sim:/integration/Memory1/Mux4_1/input2
add wave -position 15  sim:/integration/Memory1/Mux4_1/input3
add wave -position 16  sim:/integration/Memory1/Mux4_1/input4
add wave -position 4  sim:/integration/Decode1/RegisterFile1/output1
add wave -position 5  sim:/integration/Decode1/RegisterFile1/output2
add wave -position 6  sim:/integration/Decode1/RegisterFile1/output3
add wave -position 7  sim:/integration/Decode1/RegisterFile1/output4
add wave -position 8  sim:/integration/Decode1/RegisterFile1/output5
add wave -position 9  sim:/integration/Decode1/RegisterFile1/output6
add wave -position 10  sim:/integration/Decode1/RegisterFile1/output7
add wave -position 11  sim:/integration/Decode1/RegisterFile1/output8
add wave -position 12  sim:/integration/BranchingController1/a_branch_instruction_is_in_decode
add wave -position 13  sim:/integration/BranchingController1/two_bit_PC_selector
add wave -position 14  sim:/integration/BranchingController1/will_branch_in_decode
add wave -position 15  sim:/integration/BranchingController1/branch_out
add wave -position 13  sim:/integration/BranchingController1/decode_branch_unconditional
add wave -position 14  sim:/integration/BranchingController1/can_branch
add wave -position 12  sim:/integration/Fetch1/WhichPCToStore/selectors
add wave -position 13  sim:/integration/Fetch1/WhichPCToStore/input1
add wave -position 14  sim:/integration/Fetch1/WhichPCToStore/input2
add wave -position 15  sim:/integration/Fetch1/WhichPCToStore/input3
add wave -position 16  sim:/integration/Fetch1/WhichPCToStore/input4
add wave -position 17  sim:/integration/Fetch1/WhichPCToStore/output
add wave -position 12  sim:/integration/Interrupt1/int
add wave -position 13  sim:/integration/Interrupt1/retRtiCounter
add wave -position 14  sim:/integration/Interrupt1/branch
add wave -position 15  sim:/integration/Interrupt1/decodeConditionalBranch
add wave -position 16  sim:/integration/Interrupt1/intFSM
add wave -position 17  sim:/integration/Interrupt1/immediate
add wave -position 18  sim:/integration/Interrupt1/latchedInterrupt
add wave -position 19  sim:/integration/Interrupt1/enable
add wave -position 20  sim:/integration/Interrupt1/previousLatchedInterrupt
mem load -i {C:/Users/islam/OneDrive/Desktop/Spring 24/CMPN301 - Computer Architecture/Project/5StageHarvardProcessor/Assembler/memfile.mem} /integration/Fetch1/InstructionCache1/inst
force -freeze sim:/integration/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/integration/rst 1 0
force -freeze sim:/integration/int 0 0
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