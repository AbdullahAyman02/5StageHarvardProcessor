vsim -gui work.integration

add wave -position insertpoint  \
sim:/integration/clk

add wave -position insertpoint  \
sim:/integration/rst

add wave -position insertpoint  \
sim:/integration/Input_Port

add wave -position insertpoint  \
sim:/integration/Output_Port

add wave -position insertpoint  \
sim:/integration/int

add wave -position insertpoint  \
sim:/integration/Exception_Out

add wave -position insertpoint  \
sim:/integration/Fetch_PC

add wave -position insertpoint  \
sim:/integration/StackPointerCircuit/stackPointer

add wave -position insertpoint  \
sim:/integration/Execution1/Flags

add wave -position insertpoint  \
sim:/integration/Decode1/RegisterFile1/output1 \
sim:/integration/Decode1/RegisterFile1/output2 \
sim:/integration/Decode1/RegisterFile1/output3 \
sim:/integration/Decode1/RegisterFile1/output4 \
sim:/integration/Decode1/RegisterFile1/output5 \
sim:/integration/Decode1/RegisterFile1/output6 \
sim:/integration/Decode1/RegisterFile1/output7 \
sim:/integration/Decode1/RegisterFile1/output8

mem load -i {C:/Users/Fatema Kotb/Documents/CUFE 25/Year 03/Spring/01 CMPN301 - Architecture/Project/5StageHarvardProcessor/Tests/Phase 3/Two operands/memfile.mem} /integration/Fetch1/InstructionCache1/inst

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
force -freeze sim:/integration/Input_Port 'h19 0
run
force -freeze sim:/integration/Input_Port 'hFFFFFFFF 0
run
force -freeze sim:/integration/Input_Port 'hFFFFF320 0
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