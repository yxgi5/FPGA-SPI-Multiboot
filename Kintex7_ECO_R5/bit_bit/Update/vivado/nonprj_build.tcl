set outputDir ./nonprj
set bitdir ./output
file mkdir $outputDir
file mkdir $bitdir

#read_vhdl ./hdl/xxx.vhd
read_vhdl  [ glob ./hdl/*.vhd ]
#read_verilog  [ glob ./hdl/*.v ]
read_ip ./hdl/clk_wiz_0.xcix
read_xdc ./xdc/Update_multi.xdc
set_param general.MaxThreads 8
##The Non-Project flow does not support IP Caching
#config_ip_cache -use_cache_location ./ip_cache
#generate_target {instantiation_template synthesis} [get_ips]
#synth_ip [get_ips]
#synth_design -top Update -part xc7k325tffg676-2
set_part xc7k325tffg676-2
synth_design -top Update
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

write_bitstream -bin_file -force $bitdir/Update.bit
#write_bitstream -force $bitdir/Update.bit
#write_debug_probes -force $bitdir/Update.ltx;
