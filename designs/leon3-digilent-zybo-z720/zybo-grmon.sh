#!/bin/bash

# Start GRMON and connect to Zybo-Z7 running Leon3

# Change path to GRMON
cd /usr/local/bin/grmon/linux/bin64
export GRMON_SHARE=/usr/local/bin/grmon/linux/share
#./grmon --help
./grmon -uart /dev/ttyUSB0 -u

