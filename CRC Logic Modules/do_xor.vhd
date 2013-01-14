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
-- Simply: if E = 0 then it behaves like a short circuit for B, else it does 
-- A xor B (A ^ B)
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {do_xor} architecture {df_do_xor}}

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

architecture df_do_xor of do_xor is
begin
	C <= (A and E) xor B;
	
end df_do_xor;
