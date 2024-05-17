vsim -gui work.integration
add wave -position end  sim:/integration/clk
add wave -position end  sim:/integration/rst
add wave -position end  sim:/integration/int
add wave -position end  sim:/integration/Input_Port
add wave -position end  sim:/integration/Exception_Out
add wave -position end  sim:/integration/Output_Port
mem load -i {C:/Users/islam/OneDrive/Desktop/Spring 24/CMPN301 - Computer Architecture/Project/5StageHarvardProcessor/Assembler/memfile.mem} /integration/Fetch1/InstructionCache1/inst
add wave -position end  sim:/integration/Decode1/RegisterFile1/output1
add wave -position end  sim:/integration/Decode1/RegisterFile1/output2
add wave -position end  sim:/integration/Decode1/RegisterFile1/output3
add wave -position end  sim:/integration/Decode1/RegisterFile1/output4
add wave -position end  sim:/integration/Decode1/RegisterFile1/output5
add wave -position end  sim:/integration/Decode1/RegisterFile1/output6
add wave -position end  sim:/integration/Decode1/RegisterFile1/output7
add wave -position end  sim:/integration/Decode1/RegisterFile1/output8
add wave -position end  sim:/integration/StackPointerCircuit/stackPointer
add wave -position end  sim:/integration/StackPointerCircuit/push_address
add wave -position end  sim:/integration/StackPointerCircuit/pop_address
add wave -position end  sim:/integration/Memory1/Memory1/memory
add wave -position 16  sim:/integration/Forwarding_Unit/MEMORY_READ
add wave -position 17  sim:/integration/Forwarding_Unit/REG_WRITE1
add wave -position 18  sim:/integration/Forwarding_Unit/ADDRESS_SELECTOR
add wave -position 19  sim:/integration/Forwarding_Unit/CURR_ALU_SRC_1
add wave -position 20  sim:/integration/Forwarding_Unit/CURR_ALU_SRC_2
add wave -position 21  sim:/integration/Forwarding_Unit/CURR_DEST
add wave -position 22  sim:/integration/Forwarding_Unit/CURR_ALU_USES_DEST
add wave -position 23  sim:/integration/Forwarding_Unit/CURR_ALU_IS_SWAP
add wave -position 24  sim:/integration/Forwarding_Unit/PREV_ALU_DEST
add wave -position 25  sim:/integration/Forwarding_Unit/PREV_MEM_DEST
add wave -position 26  sim:/integration/Forwarding_Unit/PREV_ALU_SRC_2
add wave -position 27  sim:/integration/Forwarding_Unit/PREV_MEM_SRC_2
add wave -position 28  sim:/integration/Forwarding_Unit/CURR_ALU_NEEDS_SRC_1
add wave -position 29  sim:/integration/Forwarding_Unit/CURR_ALU_NEEDS_SRC_2
add wave -position 30  sim:/integration/Forwarding_Unit/PREV_ALU_USES_DEST
add wave -position 31  sim:/integration/Forwarding_Unit/PREV_MEM_USES_DEST
add wave -position 32  sim:/integration/Forwarding_Unit/PREV_ALU_IS_SWAP
add wave -position 33  sim:/integration/Forwarding_Unit/PREV_MEM_IS_SWAP
add wave -position 34  sim:/integration/Forwarding_Unit/IMMEDIATE_VALUE_NOT_INSTRUCTION
add wave -position 35  sim:/integration/Forwarding_Unit/ADDRESS_TO_BRANCH_TO
add wave -position 36  sim:/integration/Forwarding_Unit/MUX_1_SELECTOR
add wave -position 37  sim:/integration/Forwarding_Unit/MUX_2_SELECTOR
add wave -position 38  sim:/integration/Forwarding_Unit/MUX_3_SELECTOR
add wave -position 39  sim:/integration/Forwarding_Unit/CAN_BRANCH
add wave -position 40  sim:/integration/Forwarding_Unit/LOAD_USE
add wave -position 16  sim:/integration/Execution1/Mux8_1/output
add wave -position 17  sim:/integration/Execution1/Mux8_2/output
add wave -position 18  sim:/integration/Execution1/Mux8_3/output
add wave -position 46  sim:/integration/Memory1/ProtectionUnit1/memory
force -freeze sim:/integration/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/integration/rst 1 0
force -freeze sim:/integration/int 0 0
run
force -freeze sim:/integration/rst 0 0
add wave -position 6  sim:/integration/Fetch_PC
force -freeze sim:/integration/Input_Port 'h19 0
run
run
run
run
force -freeze sim:/integration/Input_Port 'hffffffff 0
run
force -freeze sim:/integration/Input_Port 'hfffff320 0
run
force -freeze sim:/integration/Input_Port 'h10 0
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
force -freeze sim:/integration/Input_Port 'h19 0
run
force -freeze sim:/integration/Input_Port 'h211 0
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
force -freeze sim:/integration/Input_Port 'h100 0
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