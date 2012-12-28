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

entity crc_module is
	 port(
		 md : in STD_LOGIC;
		 line_in : in STD_LOGIC;
		 clock : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 line_out : out STD_LOGIC;
		 busy : out std_logic --active low
	     );
end crc_module;

-- control constants
constant TIMES : positive:= 40;
constant CLK_PERIOD : time := 40 ns;

-- input/output signals
signal clock_signal : std_logic;
signal reset_signal : std_logic := '0';


begin
--UUT : crc_module port map()


CG : gen_clock generic map (PERIOD => CLK_PERIOD, NUM_OF_PERIODS => TIMES)
port map (clock_signal);

test : process (clock_signal)
	variable count_per : natural := 0;
	begin
		if rising_edge(clock_signal) then
			count_per := count_per + 1;
		end if;
		reset_signal <= '1' when count_per = 30;
		reset_signal <= '0' when count_per = 32;
	end process;

end tb_counter;
