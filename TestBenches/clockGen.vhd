-------------------------------------------------------------------------------
--
-- Title       : gen_clock
-- Design      : CRCmd
-- Author      : Giuliano
-- Company     : La mia
--
-------------------------------------------------------------------------------
--
-- File        : clockGen.vhd
-- Generated   : Tue Dec 18 12:41:24 2012
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : clock generator per i test bench
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {gen_clock} architecture {g_clock}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity gen_clock is
	-- diversi periodi per ovvie esigenze
	generic (
	PERIOD : time := 0 ns;
	NUM_OF_PERIODS : positive := 1
	);
	port(
		 CLK : inout STD_LOGIC := '0'
	     );
end gen_clock;

--}} End of automatically maintained section

architecture g_clock of gen_clock is

begin
	gen_clk : process
	constant tot_semi_periods : integer := NUM_OF_PERIODS * 2;
	begin
		for i in 0 to tot_semi_periods - 1 loop
			clk <= not clk after period/2;
			wait for period/2;
		end loop;
		wait;
	end process;
end g_clock;
