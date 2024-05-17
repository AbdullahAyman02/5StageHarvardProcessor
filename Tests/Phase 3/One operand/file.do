vsim -gui work.integration
mem load -i {C:\Users\Fatema Kotb\Documents\CUFE 25\Year 03\Spring\01 CMPN301 - Architecture\Project\5StageHarvardProcessor\Tests\Phase 3\One operand\memfile.mem} /integration/Fetch1/InstructionCache1/inst
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
add wave -position 3  sim:/integration/Fetch_PC
add wave -position 4  sim:/integration/Fetch_Instruction
add wave -position end  sim:/integration/Execution1/Flags
force -freeze sim:/integration/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/integration/rst 1 0
force -freeze sim:/integration/int 0 0
run
force -freeze sim:/integration/rst 0 0
run
run
run
force -freeze sim:/integration/Input_Port 'h5 0
run
run
run
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


