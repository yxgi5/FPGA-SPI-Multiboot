## CONFIG Constraints
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGFALLBACK Enable [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design ]
#set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.TIMER_CFG 0x01FFFFFF [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN Pulldown [current_design]
##set_property CFGBVS GND [current_design]
#set_property CONFIG_VOLTAGE 1.8 [current_design]

## LED Constraints
set_property IOSTANDARD LVCMOS33 [ get_ports GPIO_LED0]
set_property IOSTANDARD LVCMOS33 [ get_ports GPIO_LED1]
set_property IOSTANDARD LVCMOS33 [ get_ports GPIO_LED2]
set_property IOSTANDARD LVCMOS33 [ get_ports GPIO_LED3]
set_property IOSTANDARD LVCMOS33 [ get_ports GPIO_LED4]
set_property IOSTANDARD LVCMOS33 [ get_ports GPIO_LED5]
set_property IOSTANDARD LVCMOS33 [ get_ports GPIO_LED6]
set_property IOSTANDARD LVCMOS33 [ get_ports GPIO_LED7]

set_property PACKAGE_PIN A23 [ get_ports GPIO_LED0]
set_property PACKAGE_PIN A24 [ get_ports GPIO_LED1]
set_property PACKAGE_PIN D23 [ get_ports GPIO_LED2]
set_property PACKAGE_PIN C24 [ get_ports GPIO_LED3]
set_property PACKAGE_PIN C26 [ get_ports GPIO_LED4]
set_property PACKAGE_PIN D24 [ get_ports GPIO_LED5]
set_property PACKAGE_PIN D25 [ get_ports GPIO_LED6]
set_property PACKAGE_PIN E25 [ get_ports GPIO_LED7]

## DIPSW Constraints
set_property IOSTANDARD LVCMOS33 [ get_ports GPIO_DIPSW0]
set_property IOSTANDARD LVCMOS33 [ get_ports GPIO_DIPSW1]
set_property IOSTANDARD LVCMOS33 [ get_ports GPIO_DIPSW2]
set_property IOSTANDARD LVCMOS33 [ get_ports GPIO_DIPSW3]

set_property PACKAGE_PIN G25 [ get_ports GPIO_DIPSW0]
set_property PACKAGE_PIN E26 [ get_ports GPIO_DIPSW1]
set_property PACKAGE_PIN G26 [ get_ports GPIO_DIPSW2]
set_property PACKAGE_PIN H26 [ get_ports GPIO_DIPSW3]

##Reset Constraints
set_property PACKAGE_PIN D26 [get_ports reset_n]
set_property IOSTANDARD LVCMOS33 [get_ports reset_n]

##UART Constarints
set_property IOSTANDARD LVCMOS33 [ get_ports RX]
set_property PACKAGE_PIN B17 [ get_ports RX]

set_property IOSTANDARD LVCMOS33 [ get_ports TX]
set_property PACKAGE_PIN A17 [ get_ports TX]

## CLock Constraint
create_clock -period 20.000 [get_ports sys_clk]
set_property PACKAGE_PIN G22 [get_ports sys_clk]
set_property IOSTANDARD LVCMOS33 [get_ports sys_clk]