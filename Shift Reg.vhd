-------------------------------------------------------------------------------
--
-- Title       : shift_reg
-- Design      : CRCmd
-- Author      : Giuliano
-- Company     : La mia
--
-------------------------------------------------------------------------------
--
-- File        : Shift Reg.vhd
-- Generated   : Wed Dec 19 09:38:19 2012
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {shift_reg} architecture {str_shift_reg}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity shift_reg is
	 port(
		 E : in STD_LOGIC;
		 CLK : in STD_LOGIC;
		 RESET : in STD_LOGIC;
		 Q : out STD_LOGIC;
		 Qb : out STD_LOGIC
	     );
end shift_reg;

--}} End of automatically maintained section

architecture str_shift_reg of shift_reg is
begin

	 -- enter your statements here --

end str_shift_reg;
