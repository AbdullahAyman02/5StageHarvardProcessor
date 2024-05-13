vsim -gui work.integration
mem load -i {C:/Users/islam/OneDrive/Desktop/Spring 24/CMPN301 - Computer Architecture/Project/5StageHarvardProcessor/Assembler/memfile.mem} /integration/Fetch1/InstructionCache1/inst
add wave -position end  sim:/integration/clk
add wave -position end  sim:/integration/rst
add wave -position end  sim:/integration/int
add wave -position end  sim:/integration/Input_Port
add wave -position end  sim:/integration/Output_Port
add wave -position end  sim:/integration/Decode1/RegisterFile1/output1
add wave -position end  sim:/integration/Decode1/RegisterFile1/output2
add wave -position end  sim:/integration/Decode1/RegisterFile1/output3
add wave -position end  sim:/integration/Decode1/RegisterFile1/output4
add wave -position end  sim:/integration/Decode1/RegisterFile1/output5
add wave -position end  sim:/integration/Decode1/RegisterFile1/output6
add wave -position end  sim:/integration/Decode1/RegisterFile1/output7
add wave -position end  sim:/integration/Decode1/RegisterFile1/output8
add wave -position 5  sim:/integration/Fetch_PC
add wave -position end  sim:/integration/BranchingController1/a_branch_instruction_is_in_decode
add wave -position end  sim:/integration/BranchingController1/a_branch_instruction_is_in_execute
add wave -position end  sim:/integration/BranchingController1/decode_branch_unconditional
add wave -position end  sim:/integration/BranchingController1/execute_branch_unconditional
add wave -position end  sim:/integration/BranchingController1/branched_in_decode
add wave -position end  sim:/integration/BranchingController1/can_branch
add wave -position end  sim:/integration/BranchingController1/zero_flag
add wave -position end  sim:/integration/BranchingController1/any_stall
add wave -position end  sim:/integration/BranchingController1/prediction_out
add wave -position end  sim:/integration/BranchingController1/two_bit_PC_selector
add wave -position end  sim:/integration/BranchingController1/will_branch_in_decode
add wave -position end  sim:/integration/BranchingController1/branch_out
add wave -position end  sim:/integration/BranchingController1/prediction_bit
add wave -position end  sim:/integration/BranchingController1/two_bit_PC_selector_signal
add wave -position end  sim:/integration/BranchingController1/was_there_a_data_hazard_in_decode
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