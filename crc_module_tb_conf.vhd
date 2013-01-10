-------------------------------------------------------------------------------
--
-- Title       : Configuration crc_module_tb_conf for crc_module_tb
-- Design      : CRC
-- Author      : Dreamspark
-- Company     : .
--
-------------------------------------------------------------------------------
--
-- File        : F:\HDL_Designs\DSD_exercise\CRC\src\crc_module_tb_conf.vhd
-- Generated   : 1/10/2013, 5:19 PM
-- From        : no source file
-- By          : Active-HDL Built-in Configuration Generator ver. 1.2s
--
-------------------------------------------------------------------------------
--
-- Description : Automatically generated configuration file for crc_module_tb
--
-------------------------------------------------------------------------------

library CRC;
use CRC.all;

configuration crc_module_tb_conf of crc_module_tb is
for preload_behave_testbench
	for TRANSMITTER : crc_module 
		use entity CRC.crc_module (no_preload);
		for no_preload
			for CRC_CTRL_LG : CRC_control 
				use entity CRC.CRC_control (preload_behave);
			end for;
		end for;
	end for;
end for;
end crc_module_tb_conf;
