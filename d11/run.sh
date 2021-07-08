#TOP="BDT_splitted"
#TOP="BDT"
TOP_IDX="0000"
TOP="tree_bdt0_t${TOP_IDX}"
vivado -mode batch \
       -nojournal \
       -log "vivado_${TOP}.log" \
       -source synth_tree.tcl  \
       -tclargs "$TOP_IDX"
grep "CLB LUTs\*" -B 4 -A 12 ${TOP}_util.rpt