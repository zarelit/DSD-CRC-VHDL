-------------------------------------------------------------------------------
--
-- Title       : do_xor
-- Design      : CRCmd
-- Author      : Giuliano
-- Company     : La mia
--
-------------------------------------------------------------------------------
--
-- File        : do_xor.vhd
-- Generated   : Wed Dec 19 10:49:19 2012
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : it implements the logic function
--
--			C = (A & E) ^ B
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {xor_enable} architecture {df_xor_enable}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity do_xor is
	 port(
		 A : in STD_LOGIC;
		 B : in STD_LOGIC;
		 E : in STD_LOGIC;
		 C : out STD_LOGIC
	     );
end do_xor;

--}} End of automatically maintained section

architecture df_xor_enable of do_xor is
begin
	C <= (A and E) xor B;
	
end df_xor_enable;
