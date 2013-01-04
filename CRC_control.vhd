-------------------------------------------------------------------------------
--
-- Title       : counter
-- Design      : CRCmd
-- Author      : Giuliano
-- Company     : La mia
--
-------------------------------------------------------------------------------
--
-- File        : CRC_control.vhd
-- Generated   : Wed Dec 19 11:57:28 2012
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Generic simple clock cycles counter that advises through the 
-- port's Q signal when N cycles are passed. 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {counter} architecture {behave_counter}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CRC_control is
	generic (N : positive := 1;
	-- how long the CRC logic must be enabled
	-- after the last bit of data is received
		HOW_LONG : positive := 1);
	 port(
	 	Clock : in STD_LOGIC;
		Reset : in STD_LOGIC; -- active high
		-- qontrol signals
		-- Q clears the inputs
		-- U enables the XORing
		Q : out STD_LOGIC := '0';
		U : out STD_LOGIC := '0'
	     );
end CRC_control;

--}} End of automatically maintained section

architecture behave_control of CRC_control is

begin
	
	-- count every rising edge of the clock. When N cycles passed it sets
	-- Q signal for HOW_LONG cycles then it resets itself
	process (Clock, Reset)
	variable i : natural := 0;
	constant tot_cycles : natural := N + HOW_LONG *2;
	begin
		if Reset = '0' then
			Q <= '0';
			i := 0;
			
		elsif rising_edge(Clock) then
			i := i + 1;				-- count pleease
			
			if i = N then
				Q <= '1';
			
			elsif i = N+HOW_LONG then
				U <= '0';
				
			elsif i = tot_cycles then 
				Q <= '0';			-- reset itself
				U <= '1';
				i := 0;
				
			end if;
		
		end if;

	end process;

end behave_control;
