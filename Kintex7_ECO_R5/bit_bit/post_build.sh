#!/bin/bash
source /opt/Xilinx/Vivado/2020.1/settings64.sh
cp ./Golden/vivado/vivado_proj/vivado_proj.runs/impl_1/Golden.bit ./Golden.bit
cp ./Update/vivado/vivado_proj/vivado_proj.runs/impl_1/Update.bit ./Update.bit
echo 'write_cfgmem  -format mcs -size 32 -interface SPIx4 -loadbit {up 0x00000000 "./Golden.bit" up 0x01000000 "./Update.bit" } -file "./multiboot_0x00800000_x4.mcs" -force' | vivado -mode tcl
