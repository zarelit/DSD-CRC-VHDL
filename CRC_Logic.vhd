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
-- Description : This file defines a generic CRC calculator based on N DFF. 
-- It accepts a polynomial and creates the correct structure for the register
-- in order to compute the CRC based on the given polynomial.
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {CRC_logic} architecture {str_CRC}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CRC_logic is
	generic(
	-- number of bit of the polinomial
		NUM_BITS_POLYNOMIAL : natural;
		
	-- its bits are LSB to MSB 
		POLYNOMIAL_BITS : std_logic_vector(NUM_BITS_POLYNOMIAL-1 downto 0)
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
-- Flip Flop type D
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
component do_xor is
	port(
		 A : in STD_LOGIC;
		 B : in STD_LOGIC;
		 E : in STD_LOGIC;
		 C : out STD_LOGIC
	     );
end component do_xor;

-- internal ffd's i/o signals, they will be o/i for do_xor cells
signal Qint : std_logic_vector(1 to NUM_BITS_POLYNOMIAL);
signal Dint : std_logic_vector(1 to NUM_BITS_POLYNOMIAL);

begin
-------------------------------------------------------------------------------
-- Here we generate following structure:
-- 			  ------		  ------
-- Qk-1 ---->+ xor +-- Dk -->+ ffd +--- Qk --->  
-- 			 ---+--			 -+-+--
--      		|			  | | 
--	enable -----+		CLK	--+ +---- RESET
-------------------------------------------------------------------------------	

CREATE: for i in 1 to NUM_BITS_POLYNOMIAL - 1 generate
	
	FIRST_CELL: if i = 1 generate  
		-- iff bit(POLINOMIAL) = '1' add a Xor cell in front of the FFD
		FIRST_XOR: if (POLYNOMIAL_BITS(i-1)='1') generate
			XE1: do_xor port map 
			(
				A => Qint(NUM_BITS_POLYNOMIAL-1), -- last ffd's output
				B => D,
				E => ENABLE,
				C => Dint(i)
			);			
		else generate
			Dint(i) <= D;
		end generate;
		
   		FF1: ffd port map (
		   			Dint(i), -- connected to the do_xor cell's output 
		   			Qint(i), 
					open, 
					Clock, 
					Reset); 
				
	end generate FIRST_CELL;
	
    INT_CELLS: if i > 1 generate
		INT_XOR: if (POLYNOMIAL_BITS(i-1)='1') generate
			XEINT: do_xor port map 
			 (
				 A => Qint(NUM_BITS_POLYNOMIAL-1), -- last ffd's output
				 B => Qint(i-1),
				 E => ENABLE,
				 C => Dint(i)
			 );
		else generate
		
			-- if there isn't the i-1 term of the polinomial then 
			-- attach the input of ith ffd to the i-1th ffd's output
			Dint(i) <= Qint(i-1);
		end generate;
		
     	FFINT: ffd port map (
		 			Dint(i), 
		 			Qint(i), 
					open, 
					Clock, 
					Reset);
					
     end generate INT_CELLS;
	 
end generate CREATE;

-- connect to external port
Q <= Qint(NUM_BITS_POLYNOMIAL-1);

end str_CRC;
