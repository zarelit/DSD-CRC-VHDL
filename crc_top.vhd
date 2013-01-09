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
-- Description : It defines the entity and the different architecture for a
-- CRC hardware module.
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
		 reset : in STD_LOGIC;
		 line_out : out STD_LOGIC;
		 busy : out std_logic --active low
	     );
end crc_module;

--}} End of automatically maintained section

architecture serial_behave of crc_module is

component md_sel is
	port (
		 in_a : in STD_LOGIC;
		 in_b : in STD_LOGIC;
		 in_c : in STD_LOGIC;
		 output : out STD_LOGIC
	);
end component;

component CRC_logic is
	generic(
		POLINOMIAL_ORDER : natural;
		POLINOMIAL : std_logic_vector(64-1 downto 0)
	);
	 port(
		 d : in std_logic;
		 clock : in std_logic;
		 reset : in std_logic;
		 enable : in std_logic;
		 q : out std_logic
	     );
		 
end component;

component CRC_control is
	generic (N : positive := 1;
		HOW_LONG : positive := 1);
	port (
	 	Clock : in STD_LOGIC;
		Reset : in STD_LOGIC; -- active high
		-- qontrol signal
		Q : out STD_LOGIC := '0';
		U : out STD_LOGIC := '0'
	);
end component;

component shift_reg is
	port( d          : in  std_logic;
   		 q          : out std_logic;
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
signal crc_ctrl_out_n : std_logic;
signal crc_enable : std_logic;
signal ffd_q : std_logic;
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
	crc_ctrl_out_n <= not crc_ctrl_out;
	
-- it selects the correct behaviour of the module
	MD_S : md_sel 
		port map (
			md_wire,
			crc_ctrl_out_n,
			line_in,
			md_sel_out);
			
	-- it synchronize the output with the clock.
	MSG_SHIFT_REG : shift_reg
		port map (
			md_sel_out, 
			ffd_q,  
			clk_wire, 
			rst_wire);
	
	-- it choices what is the output to be sent out
	MUX : multiplexer 
		port map (
			crc_ctrl_out,
			ffd_q,
			crc_logic_out,
			output_wire);
			
	-- it computes the CRC based on the input message
	CRC_REG : crc_logic
		generic map(
			-- Our polynomial: x^8+x^4+x^2+1
			POLINOMIAL_ORDER => 9,
			-- MSB to LSB (100010101, 0x115)
			 POLINOMIAL => (8=>'1',4=>'1',2=>'1',0=>'1',others=>'0')
			-- LSB to MSB (101010001)
			--POLINOMIAL => (8=>'1',6=>'1',4=>'1',0=>'1', others=>'0')
			)
		port map (
			md_sel_out,
			clk_wire,
			rst_wire,
			crc_enable,
			crc_logic_out);
	
	-- it controls the data flow, from message received to crc computed and sent
	-- throug output signals
	CRC_CTRL_LG : crc_control
		generic map(
			N => 56,
			HOW_LONG => 8
		)
		port map (
			clk_wire,
			rst_wire,
			crc_ctrl_out,
			crc_enable);
	
end serial_behave;
