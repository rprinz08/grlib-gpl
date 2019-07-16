
################################################################
# This is a generated script based on design: leon3_zybo_z7_stub
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2017.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
	puts ""
	puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

	return 1
}



################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:

# source leon3_zybo_z7_stub_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:

# create_project project_1 /tmp/myproj -part xc7z020clg400-1
# set_property BOARD_PART digilentinc.com:zybo-z7-20:part0:1.0 [current_project]

# CHANGE DESIGN NAME HERE
set design_name leon3_zybo_z7_stub

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:

# create_bd_design $design_name

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
	puts "ERROR: Please open or create a project!"
	return 1
}

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
if { ${design_name} ne "" && ${cur_design} eq ${design_name} } {
	# Checks if design is empty or not
	set list_cells [get_bd_cells -quiet]

	if { $list_cells ne "" } {
		set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
		set nRet 1
	} else {
		puts "INFO: Constructing design in IPI design <$design_name>..."
	}
} else {
	if { [get_files -quiet ${design_name}.bd] eq "" } {
		puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

		create_bd_design $design_name

		puts "INFO: Making design <$design_name> as current_bd_design."
		current_bd_design $design_name
	} else {
		set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
		set nRet 3
	}
}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
	puts $errMsg
	return $nRet
}



##################################################################
# DESIGN PROCs
##################################################################

# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

	if { $parentCell eq "" } {
		set parentCell [get_bd_cells /]
	}

	# Get object for parentCell
	set parentObj [get_bd_cells $parentCell]
	if { $parentObj == "" } {
		puts "ERROR: Unable to find parent cell <$parentCell>!"
		return
	}

	# Make sure parentObj is hier blk
	set parentType [get_property TYPE $parentObj]
	if { $parentType ne "hier" } {
		puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
		return
	}

	# Save current instance; Restore later
	set oldCurInst [current_bd_instance .]

	# Set parent object as current
	current_bd_instance $parentObj

	# Create interface ports
	set DDR [ \
		create_bd_intf_port -mode Master -vlnv \
			xilinx.com:interface:ddrx_rtl:1.0 DDR ]

	set FIXED_IO [ \
		create_bd_intf_port -mode Master -vlnv \
			xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]

	set S_AXI_GP0 [ \
		create_bd_intf_port -mode Slave -vlnv \
			xilinx.com:interface:aximm_rtl:1.0 S_AXI_GP0 ]

	# 83333336 - 2018.1
	# 82352943 - 2013.4
	# FREQ_HZ does not match between /processing_system7_0/S_AXI_GP0(83333336) and /S_AXI_GP0(82352943)
	set_property -dict [ \
		list CONFIG.ADDR_WIDTH {32} \
		CONFIG.ARUSER_WIDTH {0} \
		CONFIG.AWUSER_WIDTH {0} \
		CONFIG.BUSER_WIDTH {0} \
		CONFIG.CLK_DOMAIN {} \
		CONFIG.DATA_WIDTH {32} \
		CONFIG.FREQ_HZ {83333336} \
		CONFIG.ID_WIDTH {6} \
		CONFIG.MAX_BURST_LENGTH {16} \
		CONFIG.NUM_READ_OUTSTANDING {1} \
		CONFIG.NUM_WRITE_OUTSTANDING {1} \
		CONFIG.PHASE {0.000} \
		CONFIG.PROTOCOL {AXI3} \
		CONFIG.READ_WRITE_MODE {READ_WRITE} \
		CONFIG.RUSER_WIDTH {0} \
		CONFIG.SUPPORTS_NARROW_BURST {1} \
		CONFIG.WUSER_WIDTH {0} ] \
		$S_AXI_GP0

	# Create ports
	set FCLK_CLK0		[ create_bd_port -dir O -type clk FCLK_CLK0 ]
	set FCLK_CLK1		[ create_bd_port -dir O -type clk FCLK_CLK1 ]
	set FCLK_RESET0_N	[ create_bd_port -dir O -type rst FCLK_RESET0_N ]

	# Create instance: processing_system7_0, and set properties
	set processing_system7_0 [ \
		 create_bd_cell -type ip -vlnv \
			xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]


	# @@@ preset
	set_property -dict [ \
		list \
			CONFIG.PCW_APU_CLK_RATIO_ENABLE {6:2:1} \
			CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {667} \
			CONFIG.PCW_ARMPLL_CTRL_FBDIV {40} \
			CONFIG.PCW_CPU_CPU_PLL_FREQMHZ {1333.333} \
			CONFIG.PCW_CPU_PERIPHERAL_CLKSRC {ARM PLL} \
			CONFIG.PCW_CPU_PERIPHERAL_DIVISOR0 {2} \
			CONFIG.PCW_CRYSTAL_PERIPHERAL_FREQMHZ {33.333333} \
			CONFIG.PCW_DCI_PERIPHERAL_CLKSRC {DDR PLL} \
			CONFIG.PCW_DCI_PERIPHERAL_DIVISOR0 {15} \
			CONFIG.PCW_DCI_PERIPHERAL_DIVISOR1 {7} \
			CONFIG.PCW_DCI_PERIPHERAL_FREQMHZ {10.159} \
			CONFIG.PCW_DDRPLL_CTRL_FBDIV {32} \
			CONFIG.PCW_DDR_DDR_PLL_FREQMHZ {1066.667} \
			CONFIG.PCW_DDR_HPRLPR_QUEUE_PARTITION {HPR(0)/LPR(32)} \
			CONFIG.PCW_DDR_HPR_TO_CRITICAL_PRIORITY_LEVEL {15} \
			CONFIG.PCW_DDR_LPR_TO_CRITICAL_PRIORITY_LEVEL {2} \
			CONFIG.PCW_DDR_PERIPHERAL_CLKSRC {DDR PLL} \
			CONFIG.PCW_DDR_PERIPHERAL_DIVISOR0 {2} \
			CONFIG.PCW_DDR_RAM_HIGHADDR {0x3FFFFFFF} \
			CONFIG.PCW_DDR_WRITE_TO_CRITICAL_PRIORITY_LEVEL {2} \
			CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
			CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
			CONFIG.PCW_ENET0_GRP_MDIO_IO {MIO 52 .. 53} \
			CONFIG.PCW_ENET0_PERIPHERAL_CLKSRC {IO PLL} \
			CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR0 {8} \
			CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR1 {1} \
			CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
			CONFIG.PCW_ENET0_PERIPHERAL_FREQMHZ {1000 Mbps} \
			CONFIG.PCW_ENET1_PERIPHERAL_CLKSRC {IO PLL} \
			CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR0 {1} \
			CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR1 {1} \
			CONFIG.PCW_ENET1_PERIPHERAL_ENABLE {0} \
			CONFIG.PCW_ENET1_PERIPHERAL_FREQMHZ {1000 Mbps} \
			CONFIG.PCW_ENET_RESET_ENABLE {1} \
			CONFIG.PCW_ENET_RESET_POLARITY {Active Low} \
			CONFIG.PCW_ENET_RESET_SELECT {Share reset pin} \
			CONFIG.PCW_EN_4K_TIMER {0} \
			CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
			CONFIG.PCW_GPIO_MIO_GPIO_IO {MIO} \
			CONFIG.PCW_GPIO_PERIPHERAL_ENABLE {0} \
			CONFIG.PCW_IOPLL_CTRL_FBDIV {30} \
			CONFIG.PCW_IO_IO_PLL_FREQMHZ {1000.000} \
			CONFIG.PCW_IRQ_F2P_MODE {DIRECT} \
			CONFIG.PCW_MIO_0_DIRECTION {inout} \
			CONFIG.PCW_MIO_0_IOTYPE {LVCMOS 3.3V} \
			CONFIG.PCW_MIO_0_PULLUP {enabled} \
			CONFIG.PCW_MIO_0_SLEW {slow} \
			CONFIG.PCW_MIO_10_DIRECTION {inout} \
			CONFIG.PCW_MIO_10_IOTYPE {LVCMOS 3.3V} \
			CONFIG.PCW_MIO_10_PULLUP {enabled} \
			CONFIG.PCW_MIO_10_SLEW {slow} \
			CONFIG.PCW_MIO_11_DIRECTION {inout} \
			CONFIG.PCW_MIO_11_IOTYPE {LVCMOS 3.3V} \
			CONFIG.PCW_MIO_11_PULLUP {enabled} \
			CONFIG.PCW_MIO_11_SLEW {slow} \
			CONFIG.PCW_MIO_12_DIRECTION {inout} \
			CONFIG.PCW_MIO_12_IOTYPE {LVCMOS 3.3V} \
			CONFIG.PCW_MIO_12_PULLUP {enabled} \
			CONFIG.PCW_MIO_12_SLEW {slow} \
			CONFIG.PCW_MIO_13_DIRECTION {inout} \
			CONFIG.PCW_MIO_13_IOTYPE {LVCMOS 3.3V} \
			CONFIG.PCW_MIO_13_PULLUP {enabled} \
			CONFIG.PCW_MIO_13_SLEW {slow} \
			CONFIG.PCW_MIO_14_DIRECTION {inout} \
			CONFIG.PCW_MIO_14_IOTYPE {LVCMOS 3.3V} \
			CONFIG.PCW_MIO_14_PULLUP {enabled} \
			CONFIG.PCW_MIO_14_SLEW {slow} \
			CONFIG.PCW_MIO_15_DIRECTION {inout} \
			CONFIG.PCW_MIO_15_IOTYPE {LVCMOS 3.3V} \
			CONFIG.PCW_MIO_15_PULLUP {enabled} \
			CONFIG.PCW_MIO_15_SLEW {slow} \
			CONFIG.PCW_MIO_16_DIRECTION {out} \
			CONFIG.PCW_MIO_16_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_16_PULLUP {enabled} \
			CONFIG.PCW_MIO_16_SLEW {fast} \
			CONFIG.PCW_MIO_17_DIRECTION {out} \
			CONFIG.PCW_MIO_17_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_17_PULLUP {enabled} \
			CONFIG.PCW_MIO_17_SLEW {fast} \
			CONFIG.PCW_MIO_18_DIRECTION {out} \
			CONFIG.PCW_MIO_18_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_18_PULLUP {enabled} \
			CONFIG.PCW_MIO_18_SLEW {fast} \
			CONFIG.PCW_MIO_19_DIRECTION {out} \
			CONFIG.PCW_MIO_19_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_19_PULLUP {enabled} \
			CONFIG.PCW_MIO_19_SLEW {fast} \
			CONFIG.PCW_MIO_1_DIRECTION {out} \
			CONFIG.PCW_MIO_1_IOTYPE {LVCMOS 3.3V} \
			CONFIG.PCW_MIO_1_PULLUP {enabled} \
			CONFIG.PCW_MIO_1_SLEW {slow} \
			CONFIG.PCW_MIO_20_DIRECTION {out} \
			CONFIG.PCW_MIO_20_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_20_PULLUP {enabled} \
			CONFIG.PCW_MIO_20_SLEW {fast} \
			CONFIG.PCW_MIO_21_DIRECTION {out} \
			CONFIG.PCW_MIO_21_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_21_PULLUP {enabled} \
			CONFIG.PCW_MIO_21_SLEW {fast} \
			CONFIG.PCW_MIO_22_DIRECTION {in} \
			CONFIG.PCW_MIO_22_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_22_PULLUP {enabled} \
			CONFIG.PCW_MIO_22_SLEW {fast} \
			CONFIG.PCW_MIO_23_DIRECTION {in} \
			CONFIG.PCW_MIO_23_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_23_PULLUP {enabled} \
			CONFIG.PCW_MIO_23_SLEW {fast} \
			CONFIG.PCW_MIO_24_DIRECTION {in} \
			CONFIG.PCW_MIO_24_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_24_PULLUP {enabled} \
			CONFIG.PCW_MIO_24_SLEW {fast} \
			CONFIG.PCW_MIO_25_DIRECTION {in} \
			CONFIG.PCW_MIO_25_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_25_PULLUP {enabled} \
			CONFIG.PCW_MIO_25_SLEW {fast} \
			CONFIG.PCW_MIO_26_DIRECTION {in} \
			CONFIG.PCW_MIO_26_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_26_PULLUP {enabled} \
			CONFIG.PCW_MIO_26_SLEW {fast} \
			CONFIG.PCW_MIO_27_DIRECTION {in} \
			CONFIG.PCW_MIO_27_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_27_PULLUP {enabled} \
			CONFIG.PCW_MIO_27_SLEW {fast} \
			CONFIG.PCW_MIO_28_DIRECTION {inout} \
			CONFIG.PCW_MIO_28_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_28_PULLUP {enabled} \
			CONFIG.PCW_MIO_28_SLEW {fast} \
			CONFIG.PCW_MIO_29_DIRECTION {in} \
			CONFIG.PCW_MIO_29_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_29_PULLUP {enabled} \
			CONFIG.PCW_MIO_29_SLEW {fast} \
			CONFIG.PCW_MIO_2_DIRECTION {inout} \
			CONFIG.PCW_MIO_2_IOTYPE {LVCMOS 3.3V} \
			CONFIG.PCW_MIO_2_PULLUP {disabled} \
			CONFIG.PCW_MIO_2_SLEW {slow} \
			CONFIG.PCW_MIO_30_DIRECTION {out} \
			CONFIG.PCW_MIO_30_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_30_PULLUP {enabled} \
			CONFIG.PCW_MIO_30_SLEW {fast} \
			CONFIG.PCW_MIO_31_DIRECTION {in} \
			CONFIG.PCW_MIO_31_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_31_PULLUP {enabled} \
			CONFIG.PCW_MIO_31_SLEW {fast} \
			CONFIG.PCW_MIO_32_DIRECTION {inout} \
			CONFIG.PCW_MIO_32_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_32_PULLUP {enabled} \
			CONFIG.PCW_MIO_32_SLEW {fast} \
			CONFIG.PCW_MIO_33_DIRECTION {inout} \
			CONFIG.PCW_MIO_33_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_33_PULLUP {enabled} \
			CONFIG.PCW_MIO_33_SLEW {fast} \
			CONFIG.PCW_MIO_34_DIRECTION {inout} \
			CONFIG.PCW_MIO_34_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_34_PULLUP {enabled} \
			CONFIG.PCW_MIO_34_SLEW {fast} \
			CONFIG.PCW_MIO_35_DIRECTION {inout} \
			CONFIG.PCW_MIO_35_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_35_PULLUP {enabled} \
			CONFIG.PCW_MIO_35_SLEW {fast} \
			CONFIG.PCW_MIO_36_DIRECTION {in} \
			CONFIG.PCW_MIO_36_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_36_PULLUP {enabled} \
			CONFIG.PCW_MIO_36_SLEW {fast} \
			CONFIG.PCW_MIO_37_DIRECTION {inout} \
			CONFIG.PCW_MIO_37_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_37_PULLUP {enabled} \
			CONFIG.PCW_MIO_37_SLEW {fast} \
			CONFIG.PCW_MIO_38_DIRECTION {inout} \
			CONFIG.PCW_MIO_38_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_38_PULLUP {enabled} \
			CONFIG.PCW_MIO_38_SLEW {fast} \
			CONFIG.PCW_MIO_39_DIRECTION {inout} \
			CONFIG.PCW_MIO_39_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_39_PULLUP {enabled} \
			CONFIG.PCW_MIO_39_SLEW {fast} \
			CONFIG.PCW_MIO_3_DIRECTION {inout} \
			CONFIG.PCW_MIO_3_IOTYPE {LVCMOS 3.3V} \
			CONFIG.PCW_MIO_3_PULLUP {disabled} \
			CONFIG.PCW_MIO_3_SLEW {slow} \
			CONFIG.PCW_MIO_40_DIRECTION {inout} \
			CONFIG.PCW_MIO_40_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_40_PULLUP {enabled} \
			CONFIG.PCW_MIO_40_SLEW {slow} \
			CONFIG.PCW_MIO_41_DIRECTION {inout} \
			CONFIG.PCW_MIO_41_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_41_PULLUP {enabled} \
			CONFIG.PCW_MIO_41_SLEW {slow} \
			CONFIG.PCW_MIO_42_DIRECTION {inout} \
			CONFIG.PCW_MIO_42_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_42_PULLUP {enabled} \
			CONFIG.PCW_MIO_42_SLEW {slow} \
			CONFIG.PCW_MIO_43_DIRECTION {inout} \
			CONFIG.PCW_MIO_43_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_43_PULLUP {enabled} \
			CONFIG.PCW_MIO_43_SLEW {slow} \
			CONFIG.PCW_MIO_44_DIRECTION {inout} \
			CONFIG.PCW_MIO_44_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_44_PULLUP {enabled} \
			CONFIG.PCW_MIO_44_SLEW {slow} \
			CONFIG.PCW_MIO_45_DIRECTION {inout} \
			CONFIG.PCW_MIO_45_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_45_PULLUP {enabled} \
			CONFIG.PCW_MIO_45_SLEW {slow} \
			CONFIG.PCW_MIO_46_DIRECTION {out} \
			CONFIG.PCW_MIO_46_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_46_PULLUP {enabled} \
			CONFIG.PCW_MIO_46_SLEW {slow} \
			CONFIG.PCW_MIO_47_DIRECTION {in} \
			CONFIG.PCW_MIO_47_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_47_PULLUP {enabled} \
			CONFIG.PCW_MIO_47_SLEW {slow} \
			CONFIG.PCW_MIO_48_DIRECTION {out} \
			CONFIG.PCW_MIO_48_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_48_PULLUP {enabled} \
			CONFIG.PCW_MIO_48_SLEW {slow} \
			CONFIG.PCW_MIO_49_DIRECTION {in} \
			CONFIG.PCW_MIO_49_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_49_PULLUP {enabled} \
			CONFIG.PCW_MIO_49_SLEW {slow} \
			CONFIG.PCW_MIO_4_DIRECTION {inout} \
			CONFIG.PCW_MIO_4_IOTYPE {LVCMOS 3.3V} \
			CONFIG.PCW_MIO_4_PULLUP {disabled} \
			CONFIG.PCW_MIO_4_SLEW {slow} \
			CONFIG.PCW_MIO_50_DIRECTION {inout} \
			CONFIG.PCW_MIO_50_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_50_PULLUP {enabled} \
			CONFIG.PCW_MIO_50_SLEW {slow} \
			CONFIG.PCW_MIO_51_DIRECTION {inout} \
			CONFIG.PCW_MIO_51_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_51_PULLUP {enabled} \
			CONFIG.PCW_MIO_51_SLEW {slow} \
			CONFIG.PCW_MIO_52_DIRECTION {out} \
			CONFIG.PCW_MIO_52_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_52_PULLUP {enabled} \
			CONFIG.PCW_MIO_52_SLEW {slow} \
			CONFIG.PCW_MIO_53_DIRECTION {inout} \
			CONFIG.PCW_MIO_53_IOTYPE {LVCMOS 1.8V} \
			CONFIG.PCW_MIO_53_PULLUP {enabled} \
			CONFIG.PCW_MIO_53_SLEW {slow} \
			CONFIG.PCW_MIO_5_DIRECTION {inout} \
			CONFIG.PCW_MIO_5_IOTYPE {LVCMOS 3.3V} \
			CONFIG.PCW_MIO_5_PULLUP {disabled} \
			CONFIG.PCW_MIO_5_SLEW {slow} \
			CONFIG.PCW_MIO_6_DIRECTION {out} \
			CONFIG.PCW_MIO_6_IOTYPE {LVCMOS 3.3V} \
			CONFIG.PCW_MIO_6_PULLUP {disabled} \
			CONFIG.PCW_MIO_6_SLEW {slow} \
			CONFIG.PCW_MIO_7_DIRECTION {out} \
			CONFIG.PCW_MIO_7_IOTYPE {LVCMOS 3.3V} \
			CONFIG.PCW_MIO_7_PULLUP {disabled} \
			CONFIG.PCW_MIO_7_SLEW {slow} \
			CONFIG.PCW_MIO_8_DIRECTION {out} \
			CONFIG.PCW_MIO_8_IOTYPE {LVCMOS 3.3V} \
			CONFIG.PCW_MIO_8_PULLUP {disabled} \
			CONFIG.PCW_MIO_8_SLEW {slow} \
			CONFIG.PCW_MIO_9_DIRECTION {inout} \
			CONFIG.PCW_MIO_9_IOTYPE {LVCMOS 3.3V} \
			CONFIG.PCW_MIO_9_PULLUP {enabled} \
			CONFIG.PCW_MIO_9_SLEW {slow} \
			CONFIG.PCW_OVERRIDE_BASIC_CLOCK {0} \
			CONFIG.PCW_PCAP_PERIPHERAL_CLKSRC {IO PLL} \
			CONFIG.PCW_PCAP_PERIPHERAL_DIVISOR0 {5} \
			CONFIG.PCW_PCAP_PERIPHERAL_FREQMHZ {200} \
			CONFIG.PCW_PJTAG_PERIPHERAL_ENABLE {0} \
			CONFIG.PCW_PLL_BYPASSMODE_ENABLE {0} \
			CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 3.3V} \
			CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
			CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {1} \
			CONFIG.PCW_QSPI_GRP_FBCLK_IO {MIO 8} \
			CONFIG.PCW_QSPI_GRP_IO1_ENABLE {0} \
			CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
			CONFIG.PCW_QSPI_GRP_SINGLE_SS_IO {MIO 1 .. 6} \
			CONFIG.PCW_QSPI_GRP_SS1_ENABLE {0} \
			CONFIG.PCW_QSPI_INTERNAL_HIGHADDRESS {0xFCFFFFFF} \
			CONFIG.PCW_QSPI_PERIPHERAL_CLKSRC {IO PLL} \
			CONFIG.PCW_QSPI_PERIPHERAL_DIVISOR0 {5} \
			CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
			CONFIG.PCW_QSPI_PERIPHERAL_FREQMHZ {200} \
			CONFIG.PCW_QSPI_QSPI_IO {MIO 1 .. 6} \
			CONFIG.PCW_SD0_GRP_CD_ENABLE {1} \
			CONFIG.PCW_SD0_GRP_CD_IO {MIO 47} \
			CONFIG.PCW_SD0_GRP_POW_ENABLE {0} \
			CONFIG.PCW_SD0_GRP_WP_ENABLE {0} \
			CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
			CONFIG.PCW_SD0_SD0_IO {MIO 40 .. 45} \
			CONFIG.PCW_SDIO_PERIPHERAL_CLKSRC {IO PLL} \
			CONFIG.PCW_SDIO_PERIPHERAL_DIVISOR0 {20} \
			CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {50} \
			CONFIG.PCW_SMC_PERIPHERAL_CLKSRC {IO PLL} \
			CONFIG.PCW_SMC_PERIPHERAL_DIVISOR0 {1} \
			CONFIG.PCW_SMC_PERIPHERAL_FREQMHZ {100} \
			CONFIG.PCW_TPIU_PERIPHERAL_CLKSRC {External} \
			CONFIG.PCW_TPIU_PERIPHERAL_DIVISOR0 {1} \
			CONFIG.PCW_TPIU_PERIPHERAL_FREQMHZ {200} \
			CONFIG.PCW_UART1_BAUD_RATE {115200} \
			CONFIG.PCW_UART1_GRP_FULL_ENABLE {0} \
			CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
			CONFIG.PCW_UART1_UART1_IO {MIO 48 .. 49} \
			CONFIG.PCW_UART_PERIPHERAL_CLKSRC {IO PLL} \
			CONFIG.PCW_UART_PERIPHERAL_DIVISOR0 {10} \
			CONFIG.PCW_UART_PERIPHERAL_FREQMHZ {100} \
			CONFIG.PCW_UIPARAM_DDR_ADV_ENABLE {0} \
			CONFIG.PCW_UIPARAM_DDR_AL {0} \
			CONFIG.PCW_UIPARAM_DDR_BANK_ADDR_COUNT {3} \
			CONFIG.PCW_UIPARAM_DDR_BL {8} \
			CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.221} \
			CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.222} \
			CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.217} \
			CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.244} \
			CONFIG.PCW_UIPARAM_DDR_BUS_WIDTH {32 Bit} \
			CONFIG.PCW_UIPARAM_DDR_CL {7} \
			CONFIG.PCW_UIPARAM_DDR_CLOCK_0_LENGTH_MM {18.8} \
			CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PACKAGE_LENGTH {80.4535} \
			CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PROPOGATION_DELAY {160} \
			CONFIG.PCW_UIPARAM_DDR_CLOCK_1_LENGTH_MM {18.8} \
			CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PACKAGE_LENGTH {80.4535} \
			CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PROPOGATION_DELAY {160} \
			CONFIG.PCW_UIPARAM_DDR_CLOCK_2_LENGTH_MM {18.8} \
			CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PACKAGE_LENGTH {80.4535} \
			CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PROPOGATION_DELAY {160} \
			CONFIG.PCW_UIPARAM_DDR_CLOCK_3_LENGTH_MM {18.8} \
			CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PACKAGE_LENGTH {80.4535} \
			CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PROPOGATION_DELAY {160} \
			CONFIG.PCW_UIPARAM_DDR_CLOCK_STOP_EN {0} \
			CONFIG.PCW_UIPARAM_DDR_COL_ADDR_COUNT {10} \
			CONFIG.PCW_UIPARAM_DDR_CWL {6} \
			CONFIG.PCW_UIPARAM_DDR_DEVICE_CAPACITY {4096 MBits} \
			CONFIG.PCW_UIPARAM_DDR_DQS_0_LENGTH_MM {22.8} \
			CONFIG.PCW_UIPARAM_DDR_DQS_0_PACKAGE_LENGTH {105.056} \
			CONFIG.PCW_UIPARAM_DDR_DQS_0_PROPOGATION_DELAY {160} \
			CONFIG.PCW_UIPARAM_DDR_DQS_1_LENGTH_MM {27.9} \
			CONFIG.PCW_UIPARAM_DDR_DQS_1_PACKAGE_LENGTH {66.904} \
			CONFIG.PCW_UIPARAM_DDR_DQS_1_PROPOGATION_DELAY {160} \
			CONFIG.PCW_UIPARAM_DDR_DQS_2_LENGTH_MM {22.9} \
			CONFIG.PCW_UIPARAM_DDR_DQS_2_PACKAGE_LENGTH {89.1715} \
			CONFIG.PCW_UIPARAM_DDR_DQS_2_PROPOGATION_DELAY {160} \
			CONFIG.PCW_UIPARAM_DDR_DQS_3_LENGTH_MM {29.4} \
			CONFIG.PCW_UIPARAM_DDR_DQS_3_PACKAGE_LENGTH {113.63} \
			CONFIG.PCW_UIPARAM_DDR_DQS_3_PROPOGATION_DELAY {160} \
			\
			CONFIG.PCW_UIPARAM_DDR_DQ_0_LENGTH_MM {22.8} \
			CONFIG.PCW_UIPARAM_DDR_DQ_0_PACKAGE_LENGTH {98.503} \
			CONFIG.PCW_UIPARAM_DDR_DQ_0_PROPOGATION_DELAY {160} \
			CONFIG.PCW_UIPARAM_DDR_DQ_1_LENGTH_MM {27.9} \
			CONFIG.PCW_UIPARAM_DDR_DQ_1_PACKAGE_LENGTH {68.5855} \
			CONFIG.PCW_UIPARAM_DDR_DQ_1_PROPOGATION_DELAY {160} \
			CONFIG.PCW_UIPARAM_DDR_DQ_2_LENGTH_MM {22.9} \
			CONFIG.PCW_UIPARAM_DDR_DQ_2_PACKAGE_LENGTH {90.295} \
			CONFIG.PCW_UIPARAM_DDR_DQ_2_PROPOGATION_DELAY {160} \
			CONFIG.PCW_UIPARAM_DDR_DQ_3_LENGTH_MM {29.4} \
			CONFIG.PCW_UIPARAM_DDR_DQ_3_PACKAGE_LENGTH {103.977} \
			CONFIG.PCW_UIPARAM_DDR_DQ_3_PROPOGATION_DELAY {160} \
			CONFIG.PCW_UIPARAM_DDR_DRAM_WIDTH {16 Bits} \
			CONFIG.PCW_UIPARAM_DDR_ECC {Disabled} \
			CONFIG.PCW_UIPARAM_DDR_ENABLE {1} \
			CONFIG.PCW_UIPARAM_DDR_FREQ_MHZ {533.333333} \
			CONFIG.PCW_UIPARAM_DDR_HIGH_TEMP {Normal (0-85)} \
			CONFIG.PCW_UIPARAM_DDR_MEMORY_TYPE {DDR 3 (Low Voltage)} \
			CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K256M16 RE-125} \
			CONFIG.PCW_UIPARAM_DDR_ROW_ADDR_COUNT {15} \
			CONFIG.PCW_UIPARAM_DDR_SPEED_BIN {DDR3_1066F} \
			CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE {1} \
			CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE {1} \
			CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL {1} \
			CONFIG.PCW_UIPARAM_DDR_T_FAW {40.0} \
			CONFIG.PCW_UIPARAM_DDR_T_RAS_MIN {35.0} \
			CONFIG.PCW_UIPARAM_DDR_T_RC {48.75} \
			CONFIG.PCW_UIPARAM_DDR_T_RCD {7} \
			CONFIG.PCW_UIPARAM_DDR_T_RP {7} \
			CONFIG.PCW_UIPARAM_DDR_USE_INTERNAL_VREF {0} \
			CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} \
			CONFIG.PCW_USB0_PERIPHERAL_FREQMHZ {60} \
			CONFIG.PCW_USB0_RESET_ENABLE {1} \
			CONFIG.PCW_USB0_RESET_IO {MIO 46} \
			CONFIG.PCW_USB0_USB0_IO {MIO 28 .. 39} \
			CONFIG.PCW_USB_RESET_ENABLE {1} \
			CONFIG.PCW_USB_RESET_POLARITY {Active Low} \
			CONFIG.PCW_USB_RESET_SELECT {Share reset pin} \
			CONFIG.PCW_USE_AXI_NONSECURE {0} \
			CONFIG.PCW_USE_CROSS_TRIGGER {0} \
			CONFIG.PCW_USE_M_AXI_GP0 {1} ] \
			$processing_system7_0

			# CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {-0.050} \
			# CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {-0.044} \
			# CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {-0.035} \
			# CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {-0.100} \

	set_property -dict [ \
		list CONFIG.PCW_EN_CLK1_PORT {1} \
			CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {83.000000} \
			CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {200.000000} \
			CONFIG.PCW_M_AXI_GP1_ENABLE_STATIC_REMAP {0} \
			CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {0} \
			CONFIG.PCW_USE_M_AXI_GP0 {0} \
			CONFIG.PCW_USE_M_AXI_GP1 {0} \
			CONFIG.PCW_USE_S_AXI_ACP {0} \
			CONFIG.PCW_USE_S_AXI_GP0 {1} \
			CONFIG.PCW_USE_S_AXI_GP1 {0} \
			CONFIG.PCW_USE_S_AXI_HP0 {0} \
			CONFIG.PCW_SD1_PERIPHERAL_ENABLE {1} \
            CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} ] \
			$processing_system7_0

			# @@@
			# CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {83.000000} \
			# CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {200.000000} \
			# CONFIG.preset {ZedBoard*}



	# Create interface connections
	connect_bd_intf_net -intf_net S_AXI_GP0_1 \
		[get_bd_intf_ports S_AXI_GP0] \
		[get_bd_intf_pins processing_system7_0/S_AXI_GP0]

	connect_bd_intf_net -intf_net processing_system7_0_DDR \
		[get_bd_intf_ports DDR] \
		[get_bd_intf_pins processing_system7_0/DDR]

	connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO \
		[get_bd_intf_ports FIXED_IO] \
		[get_bd_intf_pins processing_system7_0/FIXED_IO]

	# Create port connections
	connect_bd_net -net processing_system7_0_FCLK_CLK0 \
		[get_bd_ports FCLK_CLK0] \
		[get_bd_pins processing_system7_0/FCLK_CLK0] \
		[get_bd_pins processing_system7_0/S_AXI_GP0_ACLK]

	connect_bd_net -net processing_system7_0_FCLK_CLK1 \
		[get_bd_ports FCLK_CLK1] \
		[get_bd_pins processing_system7_0/FCLK_CLK1]

	connect_bd_net -net processing_system7_0_FCLK_RESET0_N \
		[get_bd_ports FCLK_RESET0_N] \
		[get_bd_pins processing_system7_0/FCLK_RESET0_N]

	# Create address segments
	create_bd_addr_seg -range 0x20000000 -offset 0x0 \
		[get_bd_addr_spaces S_AXI_GP0] \
		[get_bd_addr_segs processing_system7_0/S_AXI_GP0/GP0_DDR_LOWOCM] \
		SEG_processing_system7_0_GP0_DDR_LOWOCM

	create_bd_addr_seg -range 0x400000 -offset 0xE0000000 \
		[get_bd_addr_spaces S_AXI_GP0] \
		[get_bd_addr_segs processing_system7_0/S_AXI_GP0/GP0_IOP] \
		SEG_processing_system7_0_GP0_IOP

	create_bd_addr_seg -range 0x1000000 -offset 0xFC000000 \
		[get_bd_addr_spaces S_AXI_GP0] \
		[get_bd_addr_segs processing_system7_0/S_AXI_GP0/GP0_QSPI_LINEAR] \
		SEG_processing_system7_0_GP0_QSPI_LINEAR

	# Restore current instance
	current_bd_instance $oldCurInst

	save_bd_design
}
# End of create_root_design()



##################################################################
# MAIN FLOW
##################################################################

create_root_design ""

