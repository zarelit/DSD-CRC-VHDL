#! /bin/bash
set -x
find . -name '*.vhd' -exec ghdl -a {} \;
ghdl -e crc_module_tb
ghdl -r crc_module_tb --vcd="output.vcd"
