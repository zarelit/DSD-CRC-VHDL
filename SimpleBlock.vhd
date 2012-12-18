-------------------------------------------------------------------------------
-- Comments:
-- A ---------------+ 
-- B --> | ffd | ---+ xor +----> | ffd | --> C
-------------------------------------------------------------------------------

entity simple_block is
	port(
	A_IN : std_logic;
	B_IN : std_logic;
	C_OUT : std_logic;
	CLOCK : std_logic;
	RESET : std_logic;
	);
end entity;

architecture sb_str of simple_block is
signal ffd_to_xor : std_logic;
signal xor_out : std_logic;
FF_IN : ffd port map (B_IN, ffd_to_xor);
FF_OUT : ffd port map (xor_out, C_OUT);
end sb_str;
