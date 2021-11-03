#!/bin/bash
#cd output
source /opt/Xilinx/Vitis/2020.1/settings64.sh
echo "program_flash -f multiboot_0x00800000_x4.mcs -offset 0 -flash_type mt25ql256-spi-x1_x2_x4 -verify -cable type xilinx_tcf url TCP:127.0.0.1:3121"
program_flash -f multiboot_0x00800000_x4.mcs -offset 0 -flash_type mt25ql256-spi-x1_x2_x4 -verify -cable type xilinx_tcf url TCP:127.0.0.1:3121
