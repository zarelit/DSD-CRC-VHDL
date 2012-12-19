-------------------------------------------------------------------------------
-- (Behavioral)
--
-- File name : shift_reg.vhdl
-- Purpose   : N Shift Register
--           :
-- Library   : IEEE
-- Author(s) : Luca Fanucci
-- Copyrigth : CSMDR-CNR 2000. No part may be reproduced
--           : in any form without the prior written permission by CNR.
--
-- Simulator : Synopsys VSS v. 1999.10, on SUN Solaris 8
-------------------------------------------------------------------------------
-- Revision List
-- Version      Author  Date            Changes
--
-- 1.0          LFanu   24 April 2001   New version
-- 1.1			GPeraz	19/12/12		minor changes
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY shift_reg is
	-- if N <= 0 it doesn't have any meaning
   generic (Cells_num : positive := 4);
   port( d          : in  std_logic;
         clk        : in  std_logic;
         reset      : in  std_logic;
         q          : out std_logic);
END shift_reg;

architecture STRUCTURAL of shift_reg is

   COMPONENT ffd
   port( 
   		D : in std_logic;
		Q : out std_logic;
		Qb : out std_logic;
		Clock : in std_logic;
		Reset : in std_logic
		);
   END COMPONENT;

   SIGNAL Qint: std_logic_vector(1 to Cells_num-1);
BEGIN

   CREATE: for i in 1 to Cells_num generate
     FIRST_CELL: if i = 1 generate  -- first cell
	-- we don't care about Qb
     	FF1: ffd port map (d, Qint(i), open, clk, reset);
     end generate FIRST_CELL;
	 -- internal flip flops
     INT_CELLS: if i > 1 and i < Cells_num generate
     	FFINT: ffd port map (Qint(i-1), Qint(i), open, clk, reset);
     end generate INT_CELLS;
	 
     LAST_CELL: if i= Cells_num generate  -- last cell
     	FFL: ffd port map (Qint(Cells_num-1), q, open, clk, reset);
	 end generate LAST_CELL;
	 
    end generate CREATE;


END STRUCTURAL;
