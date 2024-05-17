vsim -gui work.integration
# vsim -gui work.integration 
# Start time: 16:41:58 on May 11,2024
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.integration(integration_arch)
# Loading work.fetch(fetch_arch)
# Loading work.pc(programcounter)
# Loading work.instructioncache(struct_instruction_cache)
# Loading work.my_nadder(a_my_adder)
# Loading work.my_adder(a_my_adder)
# Loading work.mux4(struct_mux4)
# Loading work.mux2(struct_mux2)
# Loading work.retrticounter(retrticounter_arch)
# Loading work.myregister(struct_myregister)
# Loading work.decode(decode_arch)
# Loading work.controller(controller_arch)
# Loading work.registerfile(struct_registerfile)
# Loading work.mux8(struct_mux8)
# Loading work.sign_extend(behavioral)
# Loading work.mybranchingcontroller(branching_controller_arch)
# Loading work.execution(execution_arch)
# Loading work.flagregister(flagregister_arch)
# Loading work.alu(alu_arch)
# Loading work.sp(sp_arch)
# Loading work.interruptfsm(interruptfsm_arch)
# Loading work.memory(memory_arch)
# Loading work.data_memory(data_memory_design)
# Loading work.protectionunit(struct_protectionunit)
# Loading work.writeback(writeback_atch)
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
mem load -i {C:/Users/islam/OneDrive/Desktop/Spring 24/CMPN301 - Computer Architecture/Project/5StageHarvardProcessor/Assembler/memfile.mem} /integration/Fetch1/InstructionCache1/inst
force -freeze sim:/integration/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/integration/rst 1 0
force -freeze sim:/integration/int 0 0
run
force -freeze sim:/integration/rst 0 0
run

