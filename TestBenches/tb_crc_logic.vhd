-------------------------------------------------------------------------------
--
-- Title       : crc_logic_tb
-- Design      : CRCmd
-- Author      : Giuliano
-- Company     : La mia
--
-------------------------------------------------------------------------------
--
-- File        : tb_crc_logic.vhd
-- Generated   : Thu Jan  3 18:12:11 2013
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
--{entity {crc_logic_tb} architecture {tb_crc_logic}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity crc_logic_tb is
end crc_logic_tb;

--}} End of automatically maintained section

architecture tb_crc_logic of crc_logic_tb is
-- clock generator 
component gen_clock is
	generic (
		PERIOD : time := 0 ns;
		NUM_OF_PERIODS : positive := 1
	);
	port(
		 CLK : out STD_LOGIC := '0'
	     );
end component;

component crc_logic is
	generic(
	-- if order = 0 then the crc logic is a simple shift register
		NUM_BITS_POLYNOMIAL : natural;
		-- LSB to MSB
		POLYNOMIAL_BITS : std_logic_vector(8 downto 0)
	);
	 port(
		 D : in STD_LOGIC;
		 CLOCK : in STD_LOGIC;
		 RESET : in STD_LOGIC; -- active low
		 ENABLE : in STD_LOGIC;
		 Q : out STD_LOGIC
	     );
		 
end component;

component shift_reg is
	generic (N : integer);
	port(
		 d          : in  std_logic;
   		 q          : out std_logic;
         clk        : in  std_logic;
         reset      : in  std_logic
		 );
end component;

-- control parameters
constant HOW_LONG_I_TEST : integer := 400;
constant PERIOD_LENGTH : time := 40 ns;
constant MY_NUM_BITS_POLYNOMIAL : natural := 9;
constant MY_POLYNOMIAL_BITS : std_logic_vector(MY_NUM_BITS_POLYNOMIAL - 1 downto 0) := "101010001";

-- input signals
signal line_in : std_logic := '1';
signal reset_wire : std_logic := '1';
signal enable_wire : std_logic := '0';

-- output signals
signal clock_wire	: std_logic;
signal line_out 	: std_logic;
signal reg_out 		: std_logic; -- shift register output

begin
UUT : crc_logic 
	generic map (
		NUM_BITS_POLYNOMIAL => MY_NUM_BITS_POLYNOMIAL,
		POLYNOMIAL_BITS => MY_POLYNOMIAL_BITS)
	port map (
		line_in,
		clock_wire,
		reset_wire,
		enable_wire,
		line_out
	);
	
clk_gen : gen_clock generic map (
	PERIOD => PERIOD_LENGTH,
	NUM_OF_PERIODS => HOW_LONG_I_TEST
	)
	port map (clock_wire);
-- shift register to compare
SRTC : shift_reg generic map (N => 8) port map (line_in, reg_out, clock_wire, reset_wire);
test_proc : process (clock_wire)
variable count : integer := 0;
begin
	count := count + 1;
	case count is
		when 3	=> reset_wire <= '0';
		when 5 => reset_wire <= '1';
		when others => null;
	end case;
	
end process;
end tb_crc_logic;
