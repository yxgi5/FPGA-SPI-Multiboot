set outputDir ./nonprj
set bitdir ./output
file mkdir $outputDir
file mkdir $bitdir

#read_vhdl ./hdl/xxx.vhd
#read_vhdl  [ glob ./hdl/*.vhd ]
#read_verilog  [ glob ./hdl/*.v ]
#read_ip ./hdl/clk_wiz_0.xcix
read_xdc ./xdc/system.xdc
set_param general.MaxThreads 8
##The Non-Project flow does not support IP Caching
#config_ip_cache -use_cache_location ./ip_cache
#generate_target {instantiation_template synthesis} [get_ips]
#synth_ip [get_ips]
#synth_design -top Golden -part xc7k325tffg676-2
set_part xc7k325tffg676-2
set_property target_language Verilog [current_project]
set_property default_lib work [current_project]

#Create block design using a tcl script
source ./bd/system.tcl
read_bd ./.srcs/sources_1/bd/system/system.bd
open_bd_design ./.srcs/sources_1/bd/system/system.bd
#Alternatively, you can read an existing block design
#read_bd ./bd/system.bd
#open_bd_design ./bd/system.bd


#If the block design is the top-level hierarchy, then create and add wrapper file
#make_wrapper -files [get_files ./bd/system.bd] -top
#read_vhdl ./bd/hdl/system_wrapper.vhd
#update_compile_order -fileset sources_1
#Alternatively, you can read a top level RTL file
read_verilog ./hdl/system_wrapper.v
#read_verilog ./bd/hdl/system_wrapper.v

#Read constraints
read_xdc ./xdc/system.xdc

#If the block design does not have the output products generated, generate
#the output products needed for synthesis and implementation runs
#set_property synth_checkpoint_mode None [get_files ./bd/system.bd]
#generate_target all [get_files ./bd/system.bd]
set_property synth_checkpoint_mode None [get_files ./.srcs/sources_1/bd/system/system.bd]
generate_target all [get_files ./.srcs/sources_1/bd/system/system.bd]


#Run synthesis and implementation
synth_design -top system_wrapper
write_checkpoint -force $outputDir/post_synth.dcp
report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
report_power -file $outputDir/post_synth_power.rpt
report_utilization -file $outputDir/post_synth_util.rpt
opt_design
place_design
report_clock_utilization -file $outputDir/clock_util.rpt
#place_opt_design
phys_opt_design
write_checkpoint -force $outputDir/post_place.dcp
report_utilization -file $outputDir/post_place_util.rpt
report_timing_summary -file $outputDir/post_place_timing_summary.rpt

route_design
write_checkpoint -force $outputDir/post_route.dcp
report_route_status -file $outputDir/post_route_status.rpt
report_clock_utilization -file $outputDir/clock_util.rpt
report_utilization -file $outputDir/post_route_util.rpt
report_timing_summary -file $outputDir/post_route_timing_summary.rpt
report_timing -sort_by group -max_paths 100 -path_type summary -file $outputDir/post_route_timing.rpt
report_power -file $outputDir/post_route_power.rpt
report_drc -file $outputDir/post_imp_drc.rpt

#write_bitstream -bin_file -force $bitdir/Golden.bit
#write_bitstream -force $bitdir/Golden.bit
#write_debug_probes -force $bitdir/Golden.ltx;

write_bitstream -force $bitdir/system_wrapper.bit
#write_sysdef -hwdef .srcs/sources_1/bd/system/synth/system.hwdef -bitfile ./output/system_wrapper.bit  -file system_wrapper.sysdef
#write_hwdef -force ./system_wrapper.hwdef
#write_sysdef -hwdef ./system_wrapper.hwdef -bitfile ./output/system_wrapper.bit  -file system_wrapper.sysdef
write_hw_platform -fixed -force -file ./system_wrapper.xsa
#Export the implemented hardware system to the Vitis environment
#write_hw_platform -fixed -force -file ../vitis/xsa/system_wrapper.xsa
#######
#exit
#######

