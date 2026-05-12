################################################################################
# Task 2 - Flat logic synthesis
################################################################################

proc format_period_label {clock_period_ns} {
    if {$clock_period_ns < 1.0} {
        return "[format "%.0f" [expr {$clock_period_ns * 1000.0}]]ps"
    }
    if {$clock_period_ns == int($clock_period_ns)} {
        return "[format "%.0f" $clock_period_ns]ns"
    }
    return "[string map {. _} [format "%.2f" $clock_period_ns]]ns"
}

set setup_candidates [list ../syn/synopsys_dc.setup ../../synopsys_dc.setup syn/synopsys_dc.setup]
set setup_loaded 0
foreach candidate $setup_candidates {
    if {[file exists $candidate]} {
        source $candidate
        set setup_loaded 1
        break
    }
}
if {!$setup_loaded} {
    puts "Error: Cannot find synopsys_dc.setup"
    exit 1
}

set TOP_NAME drra_wrapper
set SOURCE_DIR ../rtl
set SYN_DIR ../syn
set REPORT_ROOT ../syn/rpt
set OUT_ROOT ../syn/db

if {[info exists ::env(CLOCK_PERIOD)]} {
    set CLOCK_PERIOD_NS [expr {double($::env(CLOCK_PERIOD))}]
} else {
    set CLOCK_PERIOD_NS 20.0
}
set CLOCK_PERIOD_PS [expr {$CLOCK_PERIOD_NS * 1000.0}]
set PERIOD_LABEL [format_period_label $CLOCK_PERIOD_NS]
set REPORT_DIR "${REPORT_ROOT}/task2_${PERIOD_LABEL}"
set OUT_DIR "${OUT_ROOT}/task2_${PERIOD_LABEL}"
file mkdir $REPORT_DIR
file mkdir $OUT_DIR

set hierarchy_file "${SOURCE_DIR}/${TOP_NAME}_hierarchy.txt"
set hierarchy_files [split [read [open $hierarchy_file r]] "\n"]

foreach filename [lrange ${hierarchy_files} 0 end-1] {
    set trimmed_filename [string trim $filename]
    if {$trimmed_filename ne ""} {
        puts "Analyzing ${trimmed_filename}"
        analyze -format VHDL -lib WORK "${SOURCE_DIR}/${trimmed_filename}"
    }
}

elaborate ${TOP_NAME}
link
current_design ${TOP_NAME}
uniquify

set_wire_load_mode segmented
set_wire_load_model -name TSMC8K_Lowk_Aggresive
set_operating_condition NCCOM

source ${SYN_DIR}/constraints.sdc

set clk_ports [get_ports -quiet clk]
if {[sizeof_collection $clk_ports] > 0} {
    set existing_clk [get_clocks -quiet clk]
    if {[sizeof_collection $existing_clk] > 0} {
        remove_clock $existing_clk
    }
    create_clock -name clk -period $CLOCK_PERIOD_PS -waveform [list 0 [expr {$CLOCK_PERIOD_PS / 2.0}]] $clk_ports
    set_clock_uncertainty 0.2 [get_clocks clk]
    set_clock_uncertainty -setup 0.65 [get_clocks clk]
    set_clock_uncertainty -hold 0.45 [get_clocks clk]
}

if {[llength [all_outputs]] > 0} {
    set_load 0.13 [all_outputs]
}
set_min_capacitance 0.0 [get_nets *]

compile -map_effort medium

if {[llength [all_outputs]] > 0} {
    set_load 0.13 [all_outputs]
}
set_min_capacitance 0.0 [get_nets *]

report_constraints > ${REPORT_DIR}/${TOP_NAME}_constraints.rpt
report_area > ${REPORT_DIR}/${TOP_NAME}_area.rpt
report_cell > ${REPORT_DIR}/${TOP_NAME}_cells.rpt
report_timing -max_paths 20 > ${REPORT_DIR}/${TOP_NAME}_timing.rpt
report_power > ${REPORT_DIR}/${TOP_NAME}_power.rpt
report_qor > ${REPORT_DIR}/${TOP_NAME}_qor.rpt

write -hierarchy -format ddc -output ${OUT_DIR}/${TOP_NAME}.ddc
write -hierarchy -format verilog -output ${OUT_DIR}/${TOP_NAME}.v
write_sdc ${OUT_DIR}/${TOP_NAME}.sdc

puts "\n=========================================="
puts "Task 2 flat synthesis complete"
puts "Clock period: ${CLOCK_PERIOD_NS} ns"
puts "Reports: ${REPORT_DIR}"
puts "Outputs: ${OUT_DIR}"
puts "=========================================="
