vsim -gui work.registerfile
add wave -position end  sim:/registerfile/clk
add wave -position end  sim:/registerfile/rst
add wave -position end  sim:/registerfile/addr_read1
add wave -position end  sim:/registerfile/addr_read2
add wave -position end  sim:/registerfile/data_read1
add wave -position end  sim:/registerfile/data_read2
add wave -position end  sim:/registerfile/en_write1
add wave -position end  sim:/registerfile/en_write2
add wave -position end  sim:/registerfile/addr_write1
add wave -position end  sim:/registerfile/addr_write2
add wave -position end  sim:/registerfile/data_write1
add wave -position end  sim:/registerfile/data_write2
add wave -position end  sim:/registerfile/en_write
add wave -position end  sim:/registerfile/input1
add wave -position end  sim:/registerfile/input2
add wave -position end  sim:/registerfile/input3
add wave -position end  sim:/registerfile/input4
add wave -position end  sim:/registerfile/input5
add wave -position end  sim:/registerfile/input6
add wave -position end  sim:/registerfile/input7
add wave -position end  sim:/registerfile/input8
add wave -position end  sim:/registerfile/output1
add wave -position end  sim:/registerfile/output2
add wave -position end  sim:/registerfile/output3
add wave -position end  sim:/registerfile/output4
add wave -position end  sim:/registerfile/output5
add wave -position end  sim:/registerfile/output6
add wave -position end  sim:/registerfile/output7
add wave -position end  sim:/registerfile/output8
force -freeze sim:/registerfile/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/registerfile/rst 1 0
force -freeze sim:/registerfile/addr_read1 000 0
force -freeze sim:/registerfile/addr_read2 111 0
force -freeze sim:/registerfile/addr_write1 000 0
force -freeze sim:/registerfile/addr_write2 111 0
force -freeze sim:/registerfile/en_write1 0 0
force -freeze sim:/registerfile/en_write2 0 0
run
force -freeze sim:/registerfile/rst 0 0
force -freeze sim:/registerfile/data_write1 'haaaaaaaa 0
force -freeze sim:/registerfile/data_write2 'h55555555 0
run
run
run
force -freeze sim:/registerfile/en_write1 1 0
run
run
run
run
force -freeze sim:/registerfile/en_write2 1 0
run
run
run