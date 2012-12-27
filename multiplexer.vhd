-------------------------------------------------------------------------------
--
-- Title       : multiplexer
-- Design      : PhaseAdder
-- Author      : Giuliano
-- Company     : La mia
--
-------------------------------------------------------------------------------
--
-- File        : Multiplexer.vhd
-- Generated   : Thu Nov  8 12:02:08 2012
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
--{entity {multiplexer} architecture {BEHAVIOURAL}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity multiplexer is
	 port(
		 control : in std_logic := '0';
		 in_a : in std_logic;
		 in_b : in std_logic;
		 output : out std_logic
	     );
end multiplexer;

--}} End of automatically maintained section

architecture inv_input of multiplexer is
begin
	process(control) 
	begin
		if (control = '0') then
			output <= in_a;
		else					 
			output <= in_b;
		end if;	
	end process;

end inv_input;
