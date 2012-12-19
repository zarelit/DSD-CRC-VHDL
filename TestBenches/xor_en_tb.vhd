-------------------------------------------------------------------------------
--
-- Title       : xor_en_tb
-- Design      : CRCmd
-- Author      : Giuliano
-- Company     : La mia
--
-------------------------------------------------------------------------------
--
-- File        : xor_en_tb.vhd
-- Generated   : Wed Dec 19 10:57:11 2012
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
--{entity {xor_en_tb} architecture {tb_xor_rn}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity xor_en_tb is
end xor_en_tb;

--}} End of automatically maintained section

architecture tb_xor_rn of xor_en_tb is

component gen_clock is
generic (
		PERIOD : time := 0 ns;
		NUM_OF_PERIODS : positive := 1
		);
	port(
		 CLK : out STD_LOGIC := '0'
	     );
end component gen_clock;

component xor_enable is
	port(
		 A : in STD_LOGIC;
		 B : in STD_LOGIC;
		 E : in STD_LOGIC;
		 C : out STD_LOGIC
	     );
end component xor_enable;

signal clock_wire : std_logic;
signal input_e : std_logic;
signal input_a : std_logic;
signal output_c : std_logic;
begin
	UUT : xor_enable port map(input_a, clock_wire, input_e, output_c);
	CG  : gen_clock generic map (PERIOD => 40 ns, NUM_OF_PERIODS => 30)
	port map (clock_wire);
	
	test : process (clock_wire)
		variable count : integer := 0;
		begin
			count := count + 1;
			-- every 4 cycle
			if (count mod 4 = 0) then
				input_a <= not input_a;
			end if;
			
			case count is
				when 1 =>
				input_a <= '0';
				input_e <= '1';
				when 20 =>
				input_e <= '0';
				when others => null;
			end case;
			
	end process;
	
	 -- enter your statements here --

end tb_xor_rn;
