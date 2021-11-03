#
# Vitis v2020.1 (64-bit)
#
# create_SW_proj.tcl: Tcl script for re-creating project
#

#set tclPath [pwd]
#cd $tclPath
#cd ..
#set projpath [pwd]
#puts "Current workspace is $projpath"

#Create the BSP
#set arch 64-bit
#set processor_name psu_cortexa53_0
set processor_name microblaze_0
#set build_type system
set build_type app
set src_link hard
#set src_link soft
set os_name standalone
set project_path ./sdk_workspace
set hardware_path ./xsa
set project_name0 golden
set project_name1 multiboot
set bootloader_name fsbl
set domain_name ${os_name}_domain
set platform_name system_wrapper
#set xsa_name system_wrapper.xsa
#set xsa_name top
#set hardware_name ${hardware_path}/${xsa_name}.xsa
set hardware_name ${hardware_path}/${platform_name}.xsa

# Set SDK Workspace
setws -switch ${project_path}
getws

# Create the HW platform only fo old sdk
#sdk createhw -name hw_0 -hwspec ./hdf/system_wrapper.hdf

# Create the HW platform only
puts "platform create -name ${platform_name} -hw ${hardware_name}"
platform create -name ${platform_name} -hw ${hardware_name}
#importprojects ${project_path}/${platform_name}
# Set active platform
#platform active ${platform_name}
# Get active platform name
#platform active
# Add the specified directory to the platform repository
#repo -add-platforms ${project_path}/${platform_name}

# Create the BSP in old sdk
#sdk createbsp -name ${project_name}_bsp -hwproject hw_0 -proc ps7_cortexa9_0 -os standalone
#sdk createbsp -name ${project_name}_bsp -hwproject hw_0 -proc psu_cortexa53_0 -os standalone
#sdk projects -build -type bsp -name ${project_name}_bsp

# Create the domain, like old sdk's BSP
#domain create -name ${domain_name} -os ${os_name} -proc ${processor_name} -arch ${arch}
puts "domain create -name ${domain_name} -os ${os_name} -proc ${processor_name}"
domain create -name ${domain_name} -os ${os_name} -proc ${processor_name}

# Create the HW platform and default domain
#platform create -name ${platform_name} -hw ${hardware_name} -proc ${processor_name} -os ${os_name} -arch ${arch} -out ${project_path}
# Set active platform
#platform active ${platform_name}
# Get active platform name
#platform active
# Add the specified directory to the platform repository
repo -add-platforms ${project_path}/${platform_name}
# Set active domain
#domain active ${domain_name}
# Get active domain name
#domain active

# Set active domain
#domain active ${domain_name}
# Get active domain name
#domain active

#domain list
#bsp -help
#bsp config -append extra_compiler_flags "-O0"
#bsp setlib -name xilisf
#bsp config serial_flash_family 5
#bsp regenerate

#bsp config stdin psu_uart_1
#bsp config stdout psu_uart_1
#domain active {zynqmp_fsbl}
#bsp config stdin psu_uart_1
#bsp config stdout psu_uart_1
#domain active {zynqmp_pmufw}
#bsp config stdin psu_uart_1
#bsp config stdout psu_uart_1
#domain active ${domain_name}

bsp listparams -os
bsp listparams -proc
#bsp listparams -lib xilisf


#importprojects ${project_path}/${platform_name}

# add/mod sources to platform and domain
#importsources -name ${project_path}/${platform_name}/zynqmp_fsbl -path $fsbl_src/src/fsbl -target-path ./
#importsources -name ${project_path}/${platform_name}/zynqmp_fsbl -path $fsbl_src/src/fsbl -soft-link -target-path ./


# bsp settings
#bsp setdriver -ip psu_dp -driver dppsu -ver 1.2
#bsp regenerate


#creating empty application
#sdk createapp -name ${project_name}_app -hwproject hw_0 -proc ps7_cortexa9_0 -os standalone -lang C -app {Empty Application} -bsp ${project_name}_bsp
#sdk createapp -name ${project_name}_app -hwproject hw_0 -proc psu_cortexa53_0 -os standalone -lang C -app {Empty Application} -bsp ${project_name}_bsp



#repo -set ./elf-bootloader-master
#puts "app create -name ${bootloader_name} -platform ${platform_name} -domain ${domain_name} -template {SPI ELF Bootloader}"
#app create -name ${bootloader_name} -platform ${platform_name} -domain ${domain_name} -template {SPI ELF Bootloader}


#puts "importe the bootloader src files"
#if {($src_link == "soft")} {
#    # When using the -soft-link option you CANNOT use relative paths
#    importsources -name ${bootloader_name} -path [pwd]/src/${bootloader_name}/src -soft-link
#    importsources -name ${bootloader_name} -path [pwd]/src/${bootloader_name}/src/lscript.ld -linker-script 
#} else {
#    #importsources -name ${bootloader_name} -path ./src -linker-script
#    importsources -name ${projectbootloader_name_name} -path [pwd]/src/${bootloader_name}/src -linker-script 
#}



#creating empty application
#sdk createapp -name ${project_name}_app -hwproject hw_0 -proc ps7_cortexa9_0 -os standalone -lang C -app {Empty Application} -bsp ${project_name}_bsp
#sdk createapp -name ${project_name}_app -hwproject hw_0 -proc psu_cortexa53_0 -os standalone -lang C -app {Empty Application} -bsp ${project_name}_bsp
puts "app create -name ${project_name0} -platform ${platform_name} -domain ${domain_name} -template {Empty Application}"
app create -name ${project_name0} -platform ${platform_name} -domain ${domain_name} -template {Empty Application}
puts "app create -name ${project_name1} -platform ${platform_name} -domain ${domain_name} -template {Empty Application}"
app create -name ${project_name1} -platform ${platform_name} -domain ${domain_name} -template {Empty Application}

#importe the app src files for old SDK
#sdk importsources -name ${project_name}_app -path ./src -linker-script

#importe the app src files
puts "importe the app src files"
if {($src_link == "soft")} {
    # When using the -soft-link option you CANNOT use relative paths
    importsources -name ${project_name0} -path [pwd]/src/${project_name0}/src -soft-link
    importsources -name ${project_name0} -path [pwd]/src/${project_name0}/src/lscript.ld -linker-script 
    importsources -name ${project_name1} -path [pwd]/src/${project_name1}/src -soft-link
    importsources -name ${project_name1} -path [pwd]/src/${project_name1}/src/lscript.ld -linker-script 
    #importsources -name ${project_name0} -path [pwd]/src -soft-link
    #importsources -name ${project_name0} -path [pwd]/src/lscript.ld -linker-script 
} else {
    #importsources -name ${project_name0} -path ./src -linker-script
    importsources -name ${project_name0} -path [pwd]/src/${project_name0}/src -linker-script
    #importsources -name ${project_name0} -path [pwd]/src -linker-script 
    importsources -name ${project_name1} -path [pwd]/src/${project_name1}/src -linker-script
}

######
#exit
######
