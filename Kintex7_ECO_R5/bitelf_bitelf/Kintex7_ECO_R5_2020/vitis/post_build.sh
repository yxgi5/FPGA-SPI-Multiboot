#!/bin/bash


source /opt/Xilinx/Vitis/2020.1/settings64.sh

cd ./sdk_workspace/golden/_ide/bitstream/
updatemem -meminfo system_wrapper.mmi -data ../../Debug/golden.elf -proc system_i/microblaze_0 -bit system_wrapper.bit -out download.bit -force
#mkdir -p ../flash
#echo -e "the_ROM_image:\n{\n$PWD/download.bit\n}\n" > ../flash/bootimage.bif
#echo "bootgen -arch fpga -image ../flash/bootimage.bif -w -o ../flash/BOOT.bin -interface spi"
#bootgen -arch fpga -image ../flash/bootimage.bif -w -o ../flash/BOOT.bin -interface spi

cd -
mkdir -p output
rm -rf output/*
#cp ./sdk_workspace/golden/_ide/flash/BOOT.bin ./output/golden.bin
cp ./sdk_workspace/golden/_ide/bitstream/download.bit ./output/golden.bit

cd ./sdk_workspace/multiboot/_ide/bitstream/
updatemem -meminfo system_wrapper.mmi -data ../../Debug/multiboot.elf -proc system_i/microblaze_0 -bit system_wrapper.bit -out download.bit -force
#mkdir -p ../flash
#echo -e "the_ROM_image:\n{\n$PWD/download.bit\n}\n" > ../flash/bootimage.bif
#echo "bootgen -arch fpga -image ../flash/bootimage.bif -w -o ../flash/BOOT.bin -interface spi"
#bootgen -arch fpga -image ../flash/bootimage.bif -w -o ../flash/BOOT.bin -interface spi

cd -
#cp ./sdk_workspace/multiboot/_ide/flash/BOOT.bin ./output/multiboot.bin
cp ./sdk_workspace/multiboot/_ide/bitstream/download.bit ./output/multiboot.bit

#updatemem -force -meminfo \
#./Kintex7_ECO_R5.sdk/multiboot_USp_wrapper_hw_platform_0/multiboot_USp_wrapper.mmi \
#-bit \
#./Kintex7_ECO_R5.sdk/multiboot_USp_wrapper_hw_platform_0/multiboot_USp_wrapper.bit \
#-data \
#./Kintex7_ECO_R5.sdk/golden/Debug/golden.elf \
#-proc multiboot_USp_i/microblaze_0 -out \
#./golden.bit -force

#updatemem -force -meminfo \
#./Kintex7_ECO_R5.sdk/multiboot_USp_wrapper_hw_platform_0/multiboot_USp_wrapper.mmi \
#-bit \
#./Kintex7_ECO_R5.sdk/multiboot_USp_wrapper_hw_platform_0/multiboot_USp_wrapper.bit \
#-data \
#./Kintex7_ECO_R5.sdk/multiboot/Debug/multiboot.elf \
#-proc multiboot_USp_i/microblaze_0 -out \
#./multiboot.bit -force

source /opt/Xilinx/Vivado/2020.1/settings64.sh
echo 'write_cfgmem  -format mcs -size 32 -interface SPIx4 -loadbit {up 0x00000000 "./output/golden.bit" up 0x00800000 "./output/multiboot.bit" } -file "./output/golden_n_multiboot.mcs" -force' | vivado -mode tcl
