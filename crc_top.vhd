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

architecture simplest_arch of crc_module is

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

begin

end simplest_arch;
