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

signal in_a_wire : std_logic;
signal in_b_wire : std_logic;
signal out_wire : std_logic;

begin
	in_a_wire <= in_a;
	in_b_wire <= in_b;
	output <= out_wire;
	out_wire <= (in_a_wire and not control) or (in_b_wire and control);

end inv_input;
