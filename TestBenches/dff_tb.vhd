-- si testa anche il clock generator
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity dff_tb is
end entity;

architecture tb_ffd of dff_tb is
component gen_clock is
	generic (
		PERIOD : time := 0 ns;
		NUM_OF_PERIODS : positive := 1
	);
	port(
		 CLK : out STD_LOGIC
	     );
end component;

component ffd
	port (
		 D : in STD_LOGIC;
		 Q : out STD_LOGIC;
		 Qb : out STD_LOGIC;
		 Clock : in std_logic;
		 Reset : in std_logic
		);
end component;
-- useful signal(s)
signal clock_wire : std_logic;
signal reset_wire : std_logic := '0';
constant test_length : integer := 40;

-- flip flop input/output signals
signal input : std_logic := '0';
signal output : std_logic;

-- how long is the master clock period in nano seconds
constant NS_CLOCK_PERIOD : time := 20 ns;

begin
	-- Clock To Test
CTT : gen_clock generic map (PERIOD=> NS_CLOCK_PERIOD, NUM_OF_PERIODS => test_length)
	port map (CLK => clock_wire);
	-- Flip Flop To Test
FFTT: ffd port map (input, output, open, clock_wire, reset_wire);
-- end simulation condition
test_proc : process (clock_wire)
variable count : integer := 0;
begin
	count := count + 1;
	case count is
		when 3	=> reset_wire <= '1';
		when 4	=> input <= '1' after 10 ns;
		when 8	=> input <= not output;
		when 12 => input <= '0';
		when 16	=> input <= '1';
		when 17 => reset_wire <= '0';
		when others => null;
	end case;
	
end process;

end tb_ffd;