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
		md : in std_logic;
		CRC_control : in std_logic;
		input : in std_logic;
		output : out std_logic
	);
end component;

component CRC_logic is
	 port(
		 MSG_IN : in STD_LOGIC;
		 CLOCK : in STD_LOGIC;
		 RESET : in STD_LOGIC;
		 CRC_ENABLE : in STD_LOGIC;
		 MSG_OUT : out STD_LOGIC
	     );
		 
end component;

component CRC_control is
	port (
		CLOCK : in std_logic;
		RESET : in std_logic;
		-- CRC control
		CRC_CTRL : out std_logic
	);
end component;

component ffd is
		 port(
			 D : in STD_LOGIC;
			 Q : out STD_LOGIC;
			 Qb : out STD_LOGIC;
			 Clock : in std_logic;
			 Reset : in std_logic
	     );
end component;

component multiplexer is
	port(
			 output_ctrl : in std_logic := '0';
			 in_a : in std_logic;
			 in_b : in std_logic;
			 output : out std_logic
	     );
end component;

-- internal signals
signal md_sel_out : std_logic;
signal crc_ctrl_out : std_logic;
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
	clk_wire <= clock;
	rst_wire <= reset;
	
-- output signals 
	busy <= busy_wire;
	line_out <= output_wire;
	
-- it selects the correct behaviour of the module
	MD_S : md_sel 
		port map (
			md => md_wire,
			CRC_control => crc_ctrl_out,
			input => input_wire,
			output => md_sel_out);
			
	-- it synchronize the output with the clock.
	MSG_FFD : ffd 
		port map (
			d => md_sel_out, 
			q => ffd_q, 
			qb => open, 
			clock => clk_wire, 
			reset => rst_wire);
	
	-- it choices what is the output to be sent out
	MUX : multiplexer 
		port map (
			output_ctrl => crc_ctrl_out,
			in_a => ffd_q,
			in_b => crc_logic_out,
			output => output_wire);
			
	-- it computes the CRC based on the input message
	CRC_REG : crc_logic
		port map (
			MSG_IN => md_sel_out,
			clock => clk_wire,
			reset => rst_wire,
			CRC_ENABLE => crc_ctrl_out,
			MSG_OUT => crc_logic_out);
	
	-- it controls the data flow, from message received to crc computed and sent
	-- throug output signals
	CRC_CTRL_LG : crc_control
		port map (
			clock => clk_wire,
			reset => rst_wire,
			crc_ctrl => crc_ctrl_out);
	
end serial_behave;
