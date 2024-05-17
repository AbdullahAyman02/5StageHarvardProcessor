vsim -gui work.integration
add wave -position end  sim:/integration/clk
add wave -position end  sim:/integration/rst
add wave -position end  sim:/integration/int
add wave -position end  sim:/integration/Input_Port
add wave -position end  sim:/integration/Output_Port
add wave -position end  sim:/integration/Fetch_PC
add wave -position end  sim:/integration/Fetch_Instruction
add wave -position end  sim:/integration/Decode1/RegisterFile1/output1
add wave -position end  sim:/integration/Decode1/RegisterFile1/output2
add wave -position end  sim:/integration/Decode1/RegisterFile1/output3
add wave -position end  sim:/integration/Decode1/RegisterFile1/output4
add wave -position end  sim:/integration/Decode1/RegisterFile1/output5
add wave -position end  sim:/integration/Decode1/RegisterFile1/output6
add wave -position end  sim:/integration/Decode1/RegisterFile1/output7
add wave -position end  sim:/integration/Decode1/RegisterFile1/output8
add wave -position end  sim:/integration/Execution1/alu_flags
add wave -position end  sim:/integration/Decode1/Controller1/ValidRS1
add wave -position end  sim:/integration/Decode1/Controller1/ValidRS2
add wave -position end  sim:/integration/Forwarding_Unit/CURR_ALU_SRC_1
add wave -position end  sim:/integration/Forwarding_Unit/CURR_ALU_SRC_2
add wave -position end  sim:/integration/Forwarding_Unit/CURR_DEST
add wave -position end  sim:/integration/Forwarding_Unit/CURR_ALU_USES_DEST
add wave -position end  sim:/integration/Forwarding_Unit/CURR_ALU_IS_SWAP
add wave -position end  sim:/integration/Forwarding_Unit/PREV_ALU_DEST
add wave -position end  sim:/integration/Forwarding_Unit/PREV_MEM_DEST
add wave -position end  sim:/integration/Forwarding_Unit/PREV_ALU_SRC_2
add wave -position end  sim:/integration/Forwarding_Unit/PREV_MEM_SRC_2
add wave -position end  sim:/integration/Forwarding_Unit/CURR_ALU_NEEDS_SRC_1
add wave -position end  sim:/integration/Forwarding_Unit/CURR_ALU_NEEDS_SRC_2
add wave -position end  sim:/integration/Forwarding_Unit/PREV_ALU_USES_DEST
add wave -position end  sim:/integration/Forwarding_Unit/PREV_MEM_USES_DEST
add wave -position end  sim:/integration/Forwarding_Unit/PREV_ALU_IS_SWAP
add wave -position end  sim:/integration/Forwarding_Unit/PREV_MEM_IS_SWAP
add wave -position end  sim:/integration/Forwarding_Unit/IMMEDIATE_VALUE_NOT_INSTRUCTION
add wave -position end  sim:/integration/Forwarding_Unit/ADDRESS_TO_BRANCH_TO
add wave -position end  sim:/integration/Forwarding_Unit/MUX_1_SELECTOR
add wave -position end  sim:/integration/Forwarding_Unit/MUX_2_SELECTOR
add wave -position end  sim:/integration/Forwarding_Unit/MUX_3_SELECTOR
add wave -position end  sim:/integration/Forwarding_Unit/CAN_BRANCH
mem load -i {C:/Users/islam/OneDrive/Desktop/Spring 24/CMPN301 - Computer Architecture/Project/5StageHarvardProcessor/Assembler/memfile.mem} /integration/Fetch1/InstructionCache1/inst
force -freeze sim:/integration/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/integration/rst 1 0
force -freeze sim:/integration/int 0 0
run
force -freeze sim:/integration/rst 0 0
force -freeze sim:/integration/Input_Port 'h5 0
run
run
run
run
force -freeze sim:/integration/Input_Port 'h19 0
run
force -freeze sim:/integration/Input_Port 'hffffffff 0
run
force -freeze sim:/integration/Input_Port 'hfffff320 0
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