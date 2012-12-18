-------------------------------------------------------------------------------
-- Comments:
-- A ---------------+ 
-- B --> | ffd | ---+ xor +----> | ffd |
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity simple_block is
	port(
	A_IN : in std_logic;
	B_IN : in std_logic;
	C_OUT : out std_logic;
	-- it enables the xor logic part of the block
	ENABLE : in std_logic;
	CLOCK : in std_logic;
	RESET : in std_logic
	);
end entity;

architecture sb_str of simple_block is
-- Flip Flop D
component ffd is
	port(
		 D : in STD_LOGIC;
		 Q : out STD_LOGIC;
		 Qb : out STD_LOGIC;
		 Clock : in std_logic;
		 Reset : in std_logic
	     );
end component;

-- internal signals
signal ffd_to_xor : std_logic;
signal xor_out : std_logic;

begin
FF_IN : ffd port map (B_IN, ffd_to_xor, open, clock, reset);
FF_OUT : ffd port map (xor_out, C_OUT, open, clock, reset);

compute : process (clock)
begin
	xor_out <= (A_IN and ENABLE) xor ffd_to_xor;
end process;

end sb_str;
