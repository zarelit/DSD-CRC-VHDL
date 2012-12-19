-------------------------------------------------------------------------------
--
-- Title       : xor_enable
-- Design      : CRCmd
-- Author      : Giuliano
-- Company     : La mia
--
-------------------------------------------------------------------------------
--
-- File        : Xor_Enable.vhd
-- Generated   : Wed Dec 19 10:49:19 2012
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
--{entity {xor_enable} architecture {df_xor_enable}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity xor_enable is
	 port(
		 A : in STD_LOGIC;
		 B : in STD_LOGIC;
		 E : in STD_LOGIC;
		 C : out STD_LOGIC
	     );
end xor_enable;

--}} End of automatically maintained section

architecture df_xor_enable of xor_enable is
-- AND's exit
signal y : std_logic;
begin
COMPUTE : process (A,B,E)
begin
	C <= (A and E) xor B;
end process COMPUTE;

end df_xor_enable;
