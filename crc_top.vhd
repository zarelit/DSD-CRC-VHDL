-------------------------------------------------------------------------------
--
-- Title       : crc_module
-- Design      : CRCmd
-- Author      : Giuliano
-- Company     : La mia
--
-------------------------------------------------------------------------------
--
-- File        : crc_def.vhd
-- Generated   : Tue Dec 18 09:29:41 2012
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : It defines the interface and the architecture used for CRC 
-- module
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {crc_module} architecture {simplest_arch}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity crc_module is
	 port(
		 md : in STD_LOGIC;
		 line_in : in STD_LOGIC;
		 clock : in STD_LOGIC;
		 reset : in STD_LOGIC; --active low
		 line_out : out STD_LOGIC;
		 -- it indicates when the module ignores input in order to calculate
		 -- the Cyclic Redundancy Code
		 busy : out std_logic 
	     );
end crc_module;

--}} End of automatically maintained section

architecture no_preload of crc_module is

-- enables the input to the shift register and the CRC_Logic
component md_sel is
	 port(
		 in_a : in STD_LOGIC;
		 in_b : in STD_LOGIC;
		 in_c : in STD_LOGIC;
		 in_d : in STD_LOGIC;
		 output : out STD_LOGIC
	     );
end component;

-- computes CRC
component CRC_logic is
	generic(
		NUM_BITS_POLYNOMIAL : natural;
		POLYNOMIAL_BITS : std_logic_vector(64-1 downto 0)
	);
	 port(
		 d : in std_logic;
		 clock : in std_logic;
		 reset : in std_logic;
		 enable : in std_logic;
		 q : out std_logic
	     );
		 
end component;

-- Control different things :
-- -> output of the multiplexer;
-- -> input of shift register and CRC_Logic through md_sel
-- -> enable/disable Xor logic in CRC_Logic;
-- N = number of periods before it resets itself
-- ACTIVE_TIME = number of periods signals must be active
-- Q and U have different behaviour dependant on architecture chosen by the user
component CRC_control is
	generic (N : positive := 1;
		ACTIVE_TIME : positive := 1);
	port (
	 	Clock : in STD_LOGIC;
		Reset : in STD_LOGIC; -- active high
		-- qontrol signals
		Q : out STD_LOGIC := '0';
		U : out STD_LOGIC := '0'
	);
end component;

-- stages = number of FFD in the shift register
component shift_reg is
	generic (N:integer := 4);
	port( d          : in  std_logic;
   		 q          : out std_logic;
   		 stages		: out std_logic_vector(0 to N-1);
         clk        : in  std_logic;
         reset      : in  std_logic
	     );
end component;

component multiplexer is
	 port(
		 control : in std_logic := '0';
		 in_a : in std_logic;
		 in_b : in std_logic;
		 output : out std_logic
	     );
end component;

-- internal signals
signal md_sel_out : std_logic;
signal crc_ctrl_out : std_logic;
signal crc_enable : std_logic;
signal crc_enable_n : std_logic;
signal ffd_q : std_logic; -- exits of the last ffd of the shift_reg
signal crc_logic_out : std_logic;

-- for input signals
signal input_wire : std_logic;
signal md_wire : std_logic;
signal clk_wire : std_logic;
signal rst_wire : std_logic := '0';

-- for output signals
signal busy_wire : std_logic;
signal output_wire : std_logic;

begin
-- connections from port to internal signals
-- input signals
	md_wire <= md;
	input_wire <= line_in;
	clk_wire <= clock;
	rst_wire <= reset;

-- output signals 
	busy <= busy_wire;
	line_out <= output_wire;
	busy_wire <= crc_ctrl_out;

-- internal signals
	crc_enable_n <= not crc_enable;
	
-- it selects the correct behaviour of the module
	MD_S : md_sel 
		port map (
			md_wire,
			crc_ctrl_out,
			line_in,
			crc_enable,
			md_sel_out);
			
	-- it synchronize the output with the clock.
	MSG_SHIFT_REG : shift_reg generic map( N=> 8)
		port map (
			md_sel_out, 
			ffd_q, 
			open, 
			clk_wire, 
			rst_wire);
	
	-- it choices what is the output to be sent out
	MUX : multiplexer 
		port map (
			crc_enable_n,
			ffd_q,
			crc_logic_out,
			output_wire);
			
	-- it computes the CRC based on the input message
	CRC_REG : crc_logic
		generic map(
			-- Our polynomial: x^8+x^4+x^2+1
			NUM_BITS_POLYNOMIAL => 9,
			-- MSB to LSB (100010101, 0x115)
			 POLYNOMIAL_BITS => (8=>'1',4=>'1',2=>'1',0=>'1',others=>'0')
			)
		port map (
			md_sel_out,
			clk_wire,
			rst_wire,
			crc_enable,
			crc_logic_out);
	
	-- it controls the data flow, from message received to crc computed and sent
	-- through output signals
	CRC_CTRL_LG : crc_control
		generic map(
			N => 56,
			ACTIVE_TIME => 8
		)
		port map (
			clk_wire,
			rst_wire,
			crc_ctrl_out,
			crc_enable);
	
end no_preload;
