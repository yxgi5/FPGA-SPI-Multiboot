
#create_clock -period 5.000 [get_ports clk_in1_p]
##create_clock -period 5.000 -name sys_clk_pin [get_ports clk_in1_p]
#set_property PACKAGE_PIN AD11 [get_ports clk_in1_n]
#set_property PACKAGE_PIN AD12 [get_ports clk_in1_p]
#set_property IOSTANDARD LVDS [get_ports clk_in1_n]
#set_property IOSTANDARD LVDS [get_ports clk_in1_p]

create_clock -period 20.000 [get_ports clk_in1]
set_property PACKAGE_PIN G22 [get_ports clk_in1]
set_property IOSTANDARD LVCMOS33 [get_ports clk_in1]

set_property PACKAGE_PIN D26 [get_ports reset_n]
set_property IOSTANDARD LVCMOS33 [get_ports reset_n]

set_property PACKAGE_PIN A23 [get_ports {led[0]}]
set_property PACKAGE_PIN A24 [get_ports {led[1]}]
set_property PACKAGE_PIN D23 [get_ports {led[2]}]
set_property PACKAGE_PIN C24 [get_ports {led[3]}]
set_property PACKAGE_PIN C26 [get_ports {led[4]}]
set_property PACKAGE_PIN D24 [get_ports {led[5]}]
set_property PACKAGE_PIN D25 [get_ports {led[6]}]
set_property PACKAGE_PIN E25 [get_ports {led[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]

set_property PACKAGE_PIN G25 [get_ports {SW11[0]}]
set_property PACKAGE_PIN E26 [get_ports {SW11[1]}]
set_property PACKAGE_PIN G26 [get_ports {SW11[2]}]
set_property PACKAGE_PIN H26 [get_ports {SW11[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {SW11[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW11[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW11[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SW11[3]}]

set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGFALLBACK ENABLE [current_design]

#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_instance/inst/clk_in1_clk_wiz_0]
