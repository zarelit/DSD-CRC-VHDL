-------------------------------------------------------------------------------
--
-- Title       : counter_tb
-- Design      : CRCmd
-- Author      : Giuliano
-- Company     : La mia
--
-------------------------------------------------------------------------------
--
-- File        : counter_tb.vhd
-- Generated   : Wed Dec 19 12:43:46 2012
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
--{entity {counter_tb} architecture {tb_counter}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity counter_tb is
end counter_tb;

--}} End of automatically maintained section

architecture tb_counter of counter_tb is

component gen_clock is
	generic (
	PERIOD : time := 0 ns;
	NUM_OF_PERIODS : positive := 1
	);
	port(
		 CLK : out STD_LOGIC := '0'
	     );
end component gen_clock;

component clock_counter is
	generic (N : positive := 1);
	 port(
	 	Clock : in STD_LOGIC;
		Reset : in STD_LOGIC; -- active high
		Q : out STD_LOGIC
	     );
end component clock_counter;

-- control constants
constant TIMES : positive:= 40;
constant CLK_PERIOD : time := 40 ns;
constant HOW_MANY_PERIODS : positive := 5;

-- input/output signals
signal clock_signal : std_logic;
signal reset_signal : std_logic := '0';
signal counter_exit : std_logic;

begin
UUT : clock_counter generic map (N => HOW_MANY_PERIODS)
port map (clock_signal, reset_signal, counter_exit);

CG : gen_clock generic map (PERIOD => CLK_PERIOD, NUM_OF_PERIODS => TIMES)
port map (clock_signal);

test : process (clock_signal)
	variable count_per : natural := 0;
	begin
		if rising_edge(clock_signal) then
			count_per := count_per + 1;
		end if;
		reset_signal <= '1' when count_per = 10;
		reset_signal <= '0' when count_per = 20;
		reset_signal <= '1' when count_per = 30;
		reset_signal <= '0' when count_per = 32;
	end process;

end tb_counter;
