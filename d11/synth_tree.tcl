if { $::argc > 0 } {
    set TOP_IDX [lindex $argv 0]
} else {
    set TOP_IDX "0000"
}

set TOP "tree_bdt0_t${TOP_IDX}"
puts "### Top Level : $TOP"
add_files vhdl/Constants.vhd
add_files vhdl/Types.vhd
add_files vhdl/Tree.vhd
add_files vhdl/tree_bdt0_t${TOP_IDX}.vhd
add_files vhdl/Arrays0_${TOP_IDX}.vhd

set_property file_type {VHDL 2008} [get_files]
synth_design -top $TOP -part xcu50-fsvh2104-2-e -mode out_of_context  -directive runtimeoptimized
report_utilization -file  rpt/${TOP}_util.rpt
write_edif -force -file edf/$TOP
write_verilog -mode synth_stub stub/${TOP}_stub.v
exit