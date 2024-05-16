vsim -gui work.integration
# vsim -gui work.integration 
# Start time: 19:32:19 on May 13,2024
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
# ** Warning: (vsim-3473) Component instance "InterruptLatch1 : InterruptLatch" is not bound.
#    Time: 0 ps  Iteration: 0  Instance: /integration File: C:/Users/islam/OneDrive/Desktop/Spring 24/CMPN301 - Computer Architecture/Project/5StageHarvardProcessor/Integration.vhd
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
add wave -position end  sim:/integration/StackPointerCircuit/stackPointer
add wave -position end  sim:/integration/StackPointerCircuit/push_address
add wave -position end  sim:/integration/StackPointerCircuit/pop_address
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