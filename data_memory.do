vsim -gui work.data_memory
# vsim -gui work.data_memory 
# Start time: 18:23:03 on Apr 14,2024
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.data_memory(data_memory_design)
mem load -i {C:/Users/Malek Elsaka/Desktop/5StagesHarvard/data_memory.mem} /data_memory/memory
add wave -position end  sim:/data_memory/write_enable
add wave -position end  sim:/data_memory/read_enable
add wave -position end  sim:/data_memory/rst
add wave -position end  sim:/data_memory/address
add wave -position end  sim:/data_memory/data_in
add wave -position end  sim:/data_memory/data_out
add wave -position end  sim:/data_memory/memory
force -freeze sim:/data_memory/address x\"0002\" 0
force -freeze sim:/data_memory/rst 0 0
force -freeze sim:/data_memory/write_enable 1 0
force -freeze sim:/data_memory/read_enable 0 0
run
force -freeze sim:/data_memory/read_enable 1 0
force -freeze sim:/data_memory/write_enable 0 0
force -freeze sim:/data_memory/address x\"000\" 0
run
force -freeze sim:/data_memory/address x\"004\" 0
run
force -freeze sim:/data_memory/write_enable 1 0
force -freeze sim:/data_memory/read_enable 0 0
force -freeze sim:/data_memory/data_in x\"0000EEEE\" 0
run
force -freeze sim:/data_memory/read_enable 1 0
force -freeze sim:/data_memory/write_enable 0 0
run
