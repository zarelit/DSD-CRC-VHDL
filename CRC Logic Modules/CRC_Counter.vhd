-------------------------------------------------------------------------------
--
-- Title       : counter
-- Design      : CRCmd
-- Author      : Giuliano
-- Company     : La mia
--
-------------------------------------------------------------------------------
--
-- File        : CRC_Counter.vhd
-- Generated   : Wed Dec 19 11:57:28 2012
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Generic simple clock cycle counter that advises by the port's 
-- Q signal when N cycles are passed. 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {counter} architecture {behave_counter}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity clock_counter is
	generic (N : positive := 1);
	 port(
	 	Clock : in STD_LOGIC;
		Reset : in STD_LOGIC; -- active high
		Q : out STD_LOGIC := '0' -- this  avoids undefined behaviour
	     );
end clock_counter;

--}} End of automatically maintained section

architecture behave_counter of clock_counter is

begin
	
	-- count every rising edge of the clock
	count : process (Clock, Reset)
	variable i : natural := 0;
	begin
		
		if Reset = '1' then
			Q <= '0';
			i:= 0;
			
		elsif rising_edge(Clock) and Q = '0' then
			i := i + 1;
			
			if i = N then
				Q <= '1';
			end if;
		end if;

	end process count;
		
				
	 -- enter your statements here --

end behave_counter;
