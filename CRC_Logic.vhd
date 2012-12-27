-------------------------------------------------------------------------------
--
-- Title       : CRC_logic
-- Design      : CRCmd
-- Author      : Giuliano
-- Company     : La mia
--
-------------------------------------------------------------------------------
--
-- File        : CRC_Logic.vhd
-- Generated   : Wed Dec 19 10:24:09 2012
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : This file defines a generic CRC calculator based on N flip flop
-- of type d. It accept a polinomial and creates the correct structure in order
-- to compute the CRC.
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {CRC_logic} architecture {str_CRC}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CRC_logic is
	generic(
	-- because it doesn't have any sense if order < 1
		POLINOMIAL_ORDER : positive;
	-- its bits are LSB to MSB 
		POLINOMIAL : std_logic_vector(POLINOMIAL_ORDER-1 downto 0)
	);
	 port(
		 D : in STD_LOGIC;
		 CLOCK : in STD_LOGIC;
		 RESET : in STD_LOGIC;
		 ENABLE : in STD_LOGIC;
		 Q : out STD_LOGIC
	     );
end CRC_logic;

--}} End of automatically maintained section

architecture str_CRC of CRC_logic is
component ffd is
	port(
		 D : in STD_LOGIC;
		 Q : out STD_LOGIC;
		 Qb : out STD_LOGIC;
		 Clock : in std_logic;
		 Reset : in std_logic
	     );
end component ffd;

-- if E = 0 the entire logic becomes a shift register
component xor_enable is
	port(
		 A : in STD_LOGIC;
		 B : in STD_LOGIC;
		 E : in STD_LOGIC;
		 C : out STD_LOGIC
	     );
end component xor_enable;

-- internal ffd's i/o signals, they will be o/i for xor_enable cells
signal Qint : std_logic_vector(1 to POLINOMIAL_ORDER);
signal Dint : std_logic_vector(1 to POLINOMIAL_ORDER);

begin
-------------------------------------------------------------------------------
-- Here we generate following structure:
-- 			  ------		  ------
-- Qk-1 ---->+ xor +-- Dk -->+ ffd +--- Qk --->  
-- 			 ---+--			 -+-+-
--       enable |		CLK	  | | RESET
--			----+			--+ +----
-------------------------------------------------------------------------------	

CREATE: for i in 1 to POLINOMIAL_ORDER generate
	FIRST_CELL: if i = 1 generate  -- first cell
		-- iff bit(POLINOMIAL) = '1' add a Xor cell in front of the FFD
		FIRST_XOR: if (POLINOMIAL(i-1)='1') generate
			XE1: xor_enable port map 
			(
				A => Qint(POLINOMIAL_ORDER),
				B => D,
				E => ENABLE,
				C => Dint(i)
			);			
		else generate
			Dint(i) <= D;
		end generate FIRST_XOR;
   		FF1: ffd port map (Dint(i), Qint(i), open, Clock, Reset);  	
	end generate FIRST_CELL;
	
    INT_CELLS: if i > 1 and i < POLINOMIAL_ORDER generate
		INT_XOR: if (POLINOMIAL(i-1)='1') generate
			XEINT: xor_enable port map 
			 (
				 A => Qint(POLINOMIAL_ORDER),
				 B => Qint(i-1),
				 E => ENABLE,
				 C => Dint(i)
			 );
		else generate
			Dint(i) <= Qint(i-1);
		end generate INT_XOR;
     	FFINT: ffd port map (Dint(i), Qint(i), open, Clock, Reset);
     end generate INT_CELLS;
	 
    LAST_CELL: if i= POLINOMIAL_ORDER generate  -- last cell
		LAST_XOR: if (POLINOMIAL(i-1)='1') generate
			XEINT: xor_enable port map 
			 (
				 A => Qint(POLINOMIAL_ORDER),
				 B => Qint(i-1),
				 E => ENABLE,
				 C => Dint(i)
			 );
		else generate
			Dint(i) <= Qint(i-1);
		 end generate LAST_XOR;
     	FFL: ffd port map (Dint(i), Qint(i), open, Clock, Reset);
	 end generate LAST_CELL;
	 
    end generate CREATE;
end str_CRC;
