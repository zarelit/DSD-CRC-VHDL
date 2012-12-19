-------------------------------------------------------------------------------
--
-- Title       : CRC_logic
-- Design      : CRCmd
-- Author      : Giuliano
-- Company     : La mia
--
-------------------------------------------------------------------------------
--
-- File        : CRC_Logic.vhd
-- Generated   : Wed Dec 19 10:24:09 2012
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : This file defines a generic CRC calculator based on N flip flop
-- of type d. It accept a polinomial and creates the correct structure in order
-- to compute the CRC.
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {CRC_logic} architecture {str_CRC}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CRC_logic is
	 port(
		 D : in STD_LOGIC;
		 CLOCK : in STD_LOGIC;
		 RESET : in STD_LOGIC;
		 ENABLE : in STD_LOGIC;
		 Q : out STD_LOGIC
	     );
end CRC_logic;

--}} End of automatically maintained section

architecture str_CRC of CRC_logic is
begin

	 -- enter your statements here --

end str_CRC;
