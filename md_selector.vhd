-------------------------------------------------------------------------------
--
-- Title       : md_selector
-- Design      : CRCmd
-- Author      : Giuliano
-- Company     : La mia
--
-------------------------------------------------------------------------------
--
-- File        : md_selector.vhd
-- Generated   : Thu Dec 27 17:11:25 2012
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : it implements the logic function 
--					
--					output = (in_a | in_b) & in_c
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {md_selector} architecture {behave_md_selector}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity md_sel is
	 port(
		 in_a : in STD_LOGIC;
		 in_b : in STD_LOGIC;
		 in_c : in STD_LOGIC;
		 output : out STD_LOGIC
	     );
end md_sel;

--}} End of automatically maintained section

architecture behave_md_selector of md_sel is

begin
	output <= (in_a or in_b) and in_c;

end behave_md_selector;
