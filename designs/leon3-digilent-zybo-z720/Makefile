include .config

GRLIB=../..
TOP=leon3mp
BOARD=digilent-zybo-z720
DESIGN=leon3-digilent-zybo-z7
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
#PROTOBOARD=em.avnet.com:zynq:zed:c

DEVICE=$(PART)$(PACKAGE)-$(SPEED)
UCF_PLANAHEAD=$(GRLIB)/boards/$(BOARD)/$(BOARD).ucf
XDC=leon3mp.xdc
TCL=stub.tcl

VHDLSYNFILES= \
	config.vhd ahbrom.vhd leon3mp.vhd

VHDLSIMFILES= \
	leon3_zybo_z7_stub_sim.vhd testbench.vhd

SIMTOP=testbench
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean
VCOMOPT=-explicit
TECHLIBS = secureip unisim

LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip ihp usbhc gsi cypress hynix \
	spansion leon4v0 spw
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan pci ambatest can \
	usb grusbhc ascs slink spi hcan spacewire \
	leon4v0 l2cache pwm gr1553b iommu ac97
FILESKIP = grcan.vhd ddr2.v mobile_ddr.v

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile

##################  project specific targets ##########################

all: help-local

help-local: help
	@echo
	@echo " -----------------------------------------------------------------------------------------"
	@echo " design specific targets:"
	@echo
	@echo " make program-zybo-z7              : Load Leon3 Design and start clocks (using xsdb)"
	@echo " make program-zybo-z7-old          : Load Leon3 Design and start clocks (using xmd)"
	@echo

program-zybo-z7:
	# using new xsdb tool
	@echo "connect" > ./xsdb.ini
	@echo "targets -filter {name =~ \"ARM*#1\"} -set" >> ./xsdb.ini
	@echo "fpga -f ./vivado/$(DESIGN)/$(DESIGN).runs/impl_1/$(TOP).bit" >> ./xsdb.ini
	@echo "#source ./vivado/$(DESIGN)/$(DESIGN).sdk/hw/ps7_init.tcl" >> ./xsdb.ini
	@echo "#ps7_init" >> ./xsdb.ini
	@echo "#ps7_post_config" >> ./xsdb.ini
	@echo "exit" >> ./xsdb.ini

	@echo "#!/bin/bash" > ./program-zybo-z7.sh
	@echo "source /opt/Xilinx/SDK/2017.4/settings64.sh" >> ./program-zybo-z7.sh
	@echo "xsdb -interactive" >> ./program-zybo-z7.sh
	@chmod 755 ./program-zybo-z7.sh

	./program-zybo-z7.sh

program-zybo-z7-old:
	# using xmd tool
	@echo "fpga -f ./vivado/$(DESIGN)/$(DESIGN).runs/impl_1/$(TOP).bit" > ./xmd.ini
	@echo "connect arm hw" >> ./xmd.ini
	@echo "source ./vivado/$(DESIGN)/$(DESIGN).sdk/SDK/SDK_Export/hw/ps7_init.tcl" >> ./xmd.ini
	@echo "ps7_init" >> ./xmd.ini
	@echo "init_user" >> ./xmd.ini
	@echo "exit" >> ./xmd.ini

	@echo "#!/bin/bash" > ./program-zybo-z7-old.sh
	@echo "source /opt/Xilinx/SDK/2017.4/settings64.sh" >> ./program-zybo-z7-old.sh
	@echo "xmd" >> ./program-zybo-z7-old.sh
	@chmod 755 ./program-zybo-z7-old.sh

	./program-zybo-z7-old.sh

