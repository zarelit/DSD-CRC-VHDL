-------------------------------------------------------------------------------
--
-- Title       : crc_module
-- Design      : CRCmd
-- Author      : Giuliano
-- Company     : La mia
--
-------------------------------------------------------------------------------
--
-- File        : crc_def.vhd
-- Generated   : Tue Dec 18 09:29:41 2012
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : It defines the entity and the different architecture for a
-- CRC hardware module.
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {crc_module} architecture {simplest_arch}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity crc_module is
	 port(
		 md : in STD_LOGIC;
		 line_in : in STD_LOGIC;
		 clock : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 line_out : out STD_LOGIC;
		 ready_n : out std_logic; --active low
	     );
end crc_module;

--}} End of automatically maintained section

architecture simplest_arch of crc_module is
begin

end simplest_arch;
