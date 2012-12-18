library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sb_tb is
end entity;

architecture tb_sb of sb_tb is
component simple_block is
	port(
		A_IN : in std_logic;
		B_IN : in std_logic;
		C_OUT : out std_logic;
		CLOCK : in std_logic;
		RESET : in std_logic
	);
end component;

component gen_clock is
	generic (
		PERIOD : time := 0 ns;
		NUM_OF_PERIODS : positive := 1
	);
	port(
		 CLK : out STD_LOGIC := '0'
	     );		
end component;

constant CLK_PERIOD : time := 40 ns;
constant TIMES : positive : = 50;

-- input signals
signal A : std_logic := '1';
signal B : std_logic := '1';
signal clock_wire : std_logic;
signal reset_wire : std_logic := '0';

-- output signals
signal C : std_logic;
begin
	CG 	: gen_clock generic map (PERIOD => CLK_PERIOD, NUM_OF_PERIODS => TIMES)
			port map (clock_wire);
	UUT : simple_block port map(A, B, C, clock_wire, reset_wire);
test : process (clock_wire)
variable count : integer := 0;
begin
	count := count + 1;
	case count is
		when 3	=> reset_wire <= '1';
		when 4	=> 
		A <= '1' after 10 ns;
		B <= '1' after 20 ns;
		when 8	=> input <= not output;
		when 12 => input <= '0';
		when 16	=> input <= '1';
		when 20 => 
		when 30 => reset_wire <= '0';
		when others => null;
	end case;
end process;

end architecture;