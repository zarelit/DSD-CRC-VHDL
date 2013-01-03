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
-- 1.1			GPeraz	03 Jan 2013		minor changes just to adapt the design
--										to CRC project
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY shift_reg is

   generic (N : INTEGER:=4);
   port( d          : in  std_logic;
   		 q          : out std_logic;
         clk        : in  std_logic;
         reset      : in  std_logic
         );
END shift_reg;

architecture STRUCTURAL of shift_reg is

   COMPONENT ffd
   port( d          : in  std_logic;
   		 q          : out std_logic;
   	 	 qb 		: out std_logic;
   		 clock      : in  std_logic;
         reset      : in  std_logic
         );
   END COMPONENT;

   SIGNAL Qint: std_logic_vector(1 to N-1);
BEGIN

   GEN: for i in 1 to N generate
     FIRST: if i= 1 generate  -- first cell
       FF1: ffd port map (d, Qint(i), open, clk, reset);
     end generate FIRST;
     INTERNAL: if i > 1 and i < N generate
       FFI: ffd port map (Qint(i-1), Qint(i), open, clk, reset);
     end generate INTERNAL;
     LAST: if i= N generate  -- last cell
       FF1: ffd port map (Qint(N-1), q, open, clk, reset);
      end generate LAST;
    end generate GEN;


END STRUCTURAL;
