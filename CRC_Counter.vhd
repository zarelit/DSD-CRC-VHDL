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

entity counter is
	generic (N : positive := 1);
	 port(
	 	Clock : in STD_LOGIC;
		Reset : in STD_LOGIC; -- active high
		Q : out STD_LOGIC
	     );
end counter;

--}} End of automatically maintained section

architecture behave_counter of counter is
signal counter : integer := 0;
begin
	-- it resets the counter and the exit's signal when
	reset : process (Reset)
	begin
		if Reset = '1' then
			Q <= '0';
			counter <= 0;
		end if;
	end process reset;
	
	-- count every rising edge of the clock
	count : process (Clock)
	begin
		if rising_edge(Clock) and Q = '0' then
			counter <= counter + 1;
			if counter = N then
				Q <= '1';
			end if;
		end if;
	end process count;
		
				
	 -- enter your statements here --

end behave_counter;
