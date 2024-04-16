vsim -gui work.integration
# vsim -gui work.integration 
# Start time: 00:44:40 on Apr 16,2024
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
# Loading work.myregister(struct_myregister)
# Loading work.decode(decode_arch)
# Loading work.controller(controller_arch)
# Loading work.registerfile(struct_registerfile)
# Loading work.mux8(struct_mux8)
# Loading work.mux4(struct_mux4)
# Loading work.mux2(struct_mux2)
# Loading work.sign_extend(behavioral)
# Loading work.execution(execution_arch)
# Loading work.flagregister(flagregister_arch)
# Loading work.alu(alu_arch)
# Loading work.memory(memory_arch)
# Loading work.data_memory(data_memory_design)
# Loading work.writeback(writeback_atch)
# vsim -gui work.integration 
# Start time: 00:26:51 on Apr 16,2024
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
# Loading work.myregister(struct_myregister)
# Loading work.decode(decode_arch)
# Loading work.controller(controller_arch)
# Loading work.registerfile(struct_registerfile)
# Loading work.mux8(struct_mux8)
# Loading work.mux4(struct_mux4)
# Loading work.mux2(struct_mux2)
# Loading work.sign_extend(behavioral)
# Loading work.execution(execution_arch)
# Loading work.flagregister(flagregister_arch)
# Loading work.alu(alu_arch)
# Loading work.memory(memory_arch)
# Loading work.data_memory(data_memory_design)
# Loading work.writeback(writeback_atch)
# vsim -gui work.integration 
# Start time: 00:16:33 on Apr 16,2024
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
# Loading work.myregister(struct_myregister)
# Loading work.decode(decode_arch)
# Loading work.controller(controller_arch)
# Loading work.registerfile(struct_registerfile)
# Loading work.mux8(struct_mux8)
# Loading work.mux4(struct_mux4)
# Loading work.mux2(struct_mux2)
# Loading work.sign_extend(behavioral)
# Loading work.execution(execution_arch)
# Loading work.flagregister(flagregister_arch)
# Loading work.alu(alu_arch)
# Loading work.memory(memory_arch)
# Loading work.data_memory(data_memory_design)
# Loading work.writeback(writeback_atch)
# vsim -gui work.integration 
# Start time: 23:50:26 on Apr 15,2024
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
# Loading work.myregister(struct_myregister)
# Loading work.decode(decode_arch)
# Loading work.controller(controller_arch)
# Loading work.registerfile(struct_registerfile)
# Loading work.mux8(struct_mux8)
# Loading work.mux4(struct_mux4)
# Loading work.mux2(struct_mux2)
# Loading work.sign_extend(behavioral)
# Loading work.execution(execution_arch)
# Loading work.flagregister(flagregister_arch)
# Loading work.alu(alu_arch)
# Loading work.memory(memory_arch)
# Loading work.data_memory(data_memory_design)
# Loading work.writeback(writeback_atch)
add wave -position end  sim:/integration/clk
add wave -position end  sim:/integration/rst
add wave -position end  sim:/integration/int
add wave -position end  sim:/integration/Fetch_PC
add wave -position end  sim:/integration/Decode1/RegisterFile1/Register1/q
add wave -position end  sim:/integration/Decode1/RegisterFile1/Register2/q
add wave -position end  sim:/integration/Decode1/RegisterFile1/Register3/q
add wave -position end  sim:/integration/Decode1/RegisterFile1/Register4/q
add wave -position end  sim:/integration/Decode1/RegisterFile1/Register5/q
add wave -position end  sim:/integration/Decode1/RegisterFile1/Register6/q
add wave -position end  sim:/integration/Decode1/RegisterFile1/Register7/q
add wave -position end  sim:/integration/Decode1/RegisterFile1/Register8/q
add wave -position 3  sim:/integration/Input_Port
add wave -position 4  sim:/integration/Output_Port
add wave -position end  sim:/integration/Memory1/Memory1/data_out
add wave -position end  sim:/integration/Execution1/FlagRegister_1/flag_out
add wave -position end  sim:/integration/FETCH_DECODE/q
add wave -position end  sim:/integration/FETCH_DECODE/d(15)
add wave -position 17  sim:/integration/Fetch_Instruction
add wave -position end  sim:/integration/Decode1/RegisterFile1/en_write1
add wave -position end  sim:/integration/Decode1/RegisterFile1/addr_write1
add wave -position end  sim:/integration/Decode1/RegisterFile1/addr_write2
add wave -position end  sim:/integration/Decode1/RegisterFile1/data_write1
add wave -position end  sim:/integration/Decode1/RegisterFile1/data_write2
add wave -position end  sim:/integration/WriteBack1/RegData1
mem load -i {C:/Users/islam/OneDrive/Desktop/Spring 24/CMPN301 - Computer Architecture/Project/5StageHarvardProcessor/testCasesPhase1/TestCase1.mem} /integration/Fetch1/InstructionCache1/inst
force -freeze sim:/integration/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/integration/rst 1 0
force -freeze sim:/integration/int 0 0

