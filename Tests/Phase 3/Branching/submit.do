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

add wave -position insertpoint  \
sim:/integration/Memory1/Memory1/memory

add wave -position 6  sim:/integration/BranchingController1/prediction_out

mem load -i {C:\Codes\Arch\5StageHarvardProcessor\Tests\Phase 3\Branching\memfile.mem} /integration/Fetch1/InstructionCache1/inst

force -freeze sim:/integration/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/integration/rst 1 0
force -freeze sim:/integration/int 0 0
run
force -freeze sim:/integration/rst 0 0

run
run
run
force -freeze sim:/integration/Input_Port 'h30 0
run
force -freeze sim:/integration/Input_Port 'h50 0
run
force -freeze sim:/integration/Input_Port 'h100 0
run
force -freeze sim:/integration/Input_Port 'h300 0
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
force -freeze sim:/integration/Input_Port 'h60 0
run
run
run
run
force -freeze sim:/integration/Input_Port 'h70 0
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
force -freeze sim:/integration/Input_Port 'h700 0
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