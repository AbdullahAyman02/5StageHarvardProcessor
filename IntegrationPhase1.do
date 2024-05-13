vsim -gui work.integration
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
add wave -position end  sim:/integration/Memory1/MemWriteEn
add wave -position end  sim:/integration/Memory1/Exception
add wave -position end  sim:/integration/Memory1/Memory1/memory
add wave -position end  sim:/integration/Memory1/ProtectionUnit1/memory
add wave -position 16  sim:/integration/Memory1/Controls
add wave -position 16  sim:/integration/Decode1/Controls
add wave -position 17  sim:/integration/Fetch_Decode_Reset
add wave -position 18  sim:/integration/Fetch_Decode_Out
mem load -i {C:/Codes/Arch/5StageHarvardProcessor/Assembler/memfile.mem} /integration/Fetch1/InstructionCache1/inst
force -freeze sim:/integration/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/integration/int 0 0
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
