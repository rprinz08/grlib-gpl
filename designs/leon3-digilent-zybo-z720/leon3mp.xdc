
# Bank 13, Vcco = 3.3V
#set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]];
#set_property IOSTANDARD LVCMOS33 [get_ports -filter { IOBANK == 13 }];

# Bank 34, Vcco = 3.3V
#set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 34]];
#set_property IOSTANDARD LVCMOS33 [get_ports -filter { IOBANK == 34 }];

# Bank 35, Vcco = 3.3V
#set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 35]];
#set_property IOSTANDARD LVCMOS33 [get_ports -filter { IOBANK == 35 }];


set_property IOSTANDARD LVCMOS33 [get_ports led]
set_property PACKAGE_PIN M14 [get_ports {led[0]}]; # LED0
set_property PACKAGE_PIN M15 [get_ports {led[1]}]; # LED1
set_property PACKAGE_PIN G14 [get_ports {led[2]}]; # LED2
set_property PACKAGE_PIN D18 [get_ports {led[3]}]; # LED3

set_property PACKAGE_PIN T5  [get_ports {led[4]}]; # LED5_G
set_property PACKAGE_PIN Y11 [get_ports {led[5]}]; # LED5_R
set_property PACKAGE_PIN F17 [get_ports {led[6]}]; # LED6_G
set_property PACKAGE_PIN V16 [get_ports {led[7]}]; # LED6_R


set_property IOSTANDARD LVCMOS33 [get_ports button]
set_property PACKAGE_PIN K18 [get_ports {button[0]}]; # BTN0
set_property PACKAGE_PIN P16 [get_ports {button[1]}]; # BTN1
set_property PACKAGE_PIN K19 [get_ports {button[2]}]; # BTN2
set_property PACKAGE_PIN Y16 [get_ports {button[3]}]; # BTN3


set_property IOSTANDARD LVCMOS33 [get_ports switch]
set_property PACKAGE_PIN G15 [get_ports {switch[0]}]; # SW0
set_property PACKAGE_PIN P15 [get_ports {switch[1]}]; # SW1
set_property PACKAGE_PIN W13 [get_ports {switch[2]}]; # SW2
set_property PACKAGE_PIN T16 [get_ports {switch[3]}]; # SW3
set_property PACKAGE_PIN V13 [get_ports {switch[4]}]; # JE7
set_property PACKAGE_PIN U17 [get_ports {switch[5]}]; # JE8
set_property PACKAGE_PIN T17 [get_ports {switch[6]}]; # JE9
set_property PACKAGE_PIN Y17 [get_ports {switch[7]}]; # JE10


# Debug UART on PMOD JE
set_property IOSTANDARD LVCMOS33 [get_ports rsrx]
set_property PACKAGE_PIN V12 [get_ports rsrx]; # JE1

set_property IOSTANDARD LVCMOS33 [get_ports rstx]
set_property PACKAGE_PIN W16 [get_ports rstx]; # JE2

