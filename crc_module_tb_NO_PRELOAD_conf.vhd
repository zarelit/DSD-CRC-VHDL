-------------------------------------------------------------------------------
--
-- Title       : Configuration crc_module_tb_NO_PRELOAD_conf for crc_module_tb
-- Design      : CRC
-- Author      : Dreamspark
-- Company     : .
--
-------------------------------------------------------------------------------
--
-- File        : F:\HDL_Designs\DSD_exercise\CRC\src\crc_module_tb_NO_PRELOAD_conf.vhd
-- Generated   : 1/10/2013, 5:18 PM
-- From        : no source file
-- By          : Active-HDL Built-in Configuration Generator ver. 1.2s
--
-------------------------------------------------------------------------------
--
-- Description : Automatically generated configuration file for crc_module_tb
--
-------------------------------------------------------------------------------

library CRCmd;
use CRCmd.all;

configuration crc_module_tb_NO_PRELOAD_conf of crc_module_tb is
for no_preload_behave_testbench
	for TRANSMITTER : crc_module 
		use entity CRCmd.crc_module (no_preload);
		for no_preload
			for CRC_CTRL_LG : CRC_control 
				use entity CRCmd.CRC_control (no_preload_behave);
			end for;
		end for;
	end for;
end for;
end crc_module_tb_NO_PRELOAD_conf;
