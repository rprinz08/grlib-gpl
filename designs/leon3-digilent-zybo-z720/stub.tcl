
# Script to build Zynq stub and export files for SDK
# richard.prinz@min.at 2019

set_property target_language VHDL [current_project]

source {leon3_zybo_z7_stub.tcl}

generate_target all [ \
	get_files vivado/leon3-digilent-zybo-z7/leon3-digilent-zybo-z7.srcs/sources_1/bd/leon3_zybo_z7_stub/leon3_zybo_z7_stub.bd]

make_wrapper -files [ \
	get_files vivado/leon3-digilent-zybo-z7/leon3-digilent-zybo-z7.srcs/sources_1/bd/leon3_zybo_z7_stub/leon3_zybo_z7_stub.bd] \
	-top

add_files -norecurse \
	vivado/leon3-digilent-zybo-z7/leon3-digilent-zybo-z7.srcs/sources_1/bd/leon3_zybo_z7_stub/hdl/leon3_zybo_z7_stub_wrapper.vhd

update_compile_order -fileset sources_1

#export_hardware [ \
#	get_files vivado/leon3-digilent-zybo-z7/leon3-digilent-zybo-z7.srcs/sources_1/bd/leon3_zybo_z7_stub/leon3_zybo_z7_stub.bd]

write_hwdef -force \
	vivado/leon3-digilent-zybo-z7/leon3-digilent-zybo-z7.sdk/leon3_zybo_z7_stub.hdf

