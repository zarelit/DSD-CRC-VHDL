-------------------------------------------------------------------------------
--
-- Title       : Configuration crc_module_tb_rx_preload for crc_module_tb
-- Design      : CRC
-- Author      : Dreamspark
-- Company     : .
--
-------------------------------------------------------------------------------
--
-- File        : F:\HDL_Designs\DSD_exercise\CRC\src\crc_module_tb_rx_preload.vhd
-- Generated   : 1/11/2013, 12:10 PM
-- From        : no source file
-- By          : Active-HDL Built-in Configuration Generator ver. 1.2s
--
-------------------------------------------------------------------------------
--
-- Description : Automatically generated configuration file for crc_module_tb
--
-------------------------------------------------------------------------------

library crcmd;
use CRCmd.all;

configuration crc_module_tb_rx_preload of crc_module_tb is
for rx_preload
	for TRANSMITTER : crc_module 
		use entity CRCmd.crc_module (no_preload);
		for no_preload
			for CRC_CTRL_LG : CRC_control 
				use entity CRCmd.CRC_control (preload_behave);
			end for;
		end for;
	end for;
end for;
end crc_module_tb_rx_preload;
