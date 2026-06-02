# Replace this path with your local Nangate 45nm liberty file.
read_liberty /path/to/NangateOpenCellLibrary_typical.lib
read_verilog AES10v2_H23_XORS82_mapped.v
link_design AES10v2_H23_XORS82

create_clock -name clk -period 10.0

set_input_delay 0 -clock clk [all_inputs]
set_output_delay 0 -clock clk [all_outputs]
set_input_transition 0.05 [all_inputs]
set_load 0.005 [all_outputs]

report_checks -path_delay max -digits 4
exit
