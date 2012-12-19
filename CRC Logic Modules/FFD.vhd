-------------------------------------------------------------------------------
--
-- Title       : ffd
-- Design      : CRCmd
-- Author      : Giuliano
-- Company     : La mia
--
-------------------------------------------------------------------------------
--
-- File        : FFtipoD.vhd
-- Generated   : Tue Dec 18 12:45:56 2012
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : implementazione di un flip flop di tipo D
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {ffd} architecture {ffd_behave}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ffd is
	 port(
		 D : in STD_LOGIC;
		 Q : out STD_LOGIC;
		 Qb : out STD_LOGIC;
		 Clock : in std_logic;
		 Reset : in std_logic
	     );
end ffd;

--}} End of automatically maintained section

-- robust version of the DFF, it set to 0 the input if RESET='0'. This avoids
-- the undefined behaviour of the output at beginning of the simulation.
architecture ffd_behave of ffd is
begin
	
	works : process (Clock)
	begin
		if Reset = '0' then
			Q <= '0';	
		-- rising edge of the clock
		elsif (Clock'event and Clock = '1') then
			Q <= D;
		end if;
		Qb <= not Q;
	end process;
	 -- enter your statements here --

end ffd_behave;
