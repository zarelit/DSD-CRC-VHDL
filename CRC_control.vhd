-------------------------------------------------------------------------------
--
-- Title       : counter
-- Design      : CRCmd
-- Author      : Giuliano
-- Company     : La mia
--
-------------------------------------------------------------------------------
--
-- File        : CRC_control.vhd
-- Generated   : Wed Dec 19 11:57:28 2012
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Generic simple clock cycles counter that advises through the 
-- port's Q signal when N cycles are passed and it remains active for 
---ACTIVE_TIME clock cycles. Signal U is used in order to control the xor
-- modules in the CRC_Logic module.
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {counter} architecture {behave_counter}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CRC_control is
	generic (N : positive := 1;
	-- how long the CRC logic must be enabled
	-- after the last bit of data is received
		ACTIVE_TIME : positive := 1);
	 port(
	 	Clock : in STD_LOGIC;
		Reset : in STD_LOGIC; -- active high
		-- qontrol signals
		-- Q clears the inputs
		-- U enables the XORing
		Q : out STD_LOGIC := '0';
		U : out STD_LOGIC := '0' -- active low
	     );
end CRC_control;

--}} End of automatically maintained section

architecture no_preload_behave of CRC_control is

begin
	
	-- count every rising edge of the clock. When N cycles passed it sets
	-- Q signal for ACTIVE_TIME cycles then it resets itself
	process (Clock, Reset)
	variable i : natural := 0;
	constant tot_cycles : natural := N + ACTIVE_TIME *2;
	begin
		if Reset = '0' then
			Q <= '0';
			i := 0;
			
		elsif rising_edge(Clock) then
			i := i + 1;				-- count pleease
			
			if i = N then
				Q <= '1';
			
			elsif i = N + ACTIVE_TIME then
				U <= '0';
				
			elsif i = tot_cycles then 
				Q <= '0';			-- reset itself
				U <= '1';
				i := 0;
				
			end if;
		
		end if;

	end process;

end no_preload_behave;

architecture preload_behave of CRC_control is

-- internal signals
signal Qint : std_logic;

begin
Q <= Qint;
-- it changes after N clock signal if reset = 1
Q_SIGNAL : process (Clock, Reset)
	variable counter :  integer := 0;
	begin
		if Reset = '0' then
			Qint <= '0';
			counter := 0;
			
		elsif rising_edge(Clock) then
			counter := counter + 1;		-- count pleease
			
			if counter = N then
				Qint <= '1';
				
			elsif counter = N + ACTIVE_TIME then
				Qint <= '0';
				counter := 0;
				
			end if;
			
		end if;
		
	end process Q_SIGNAL;
	
-- U changes only when Q is low
U_SIGNAL : process (Qint, Clock, Reset)
	variable counter :  integer := 0;
	begin
		
		if Reset = '0' then
			U <= '1';
			counter := 0;
			
		elsif falling_edge(Qint) then
			counter := 0;
			U <= '0';
			
		elsif rising_edge(Clock) and U = '0' then
			counter := counter + 1;		-- count pleease
			
			if counter = ACTIVE_TIME then
				U <= '1';
				
			end if;
			
		end if;
			
	end process U_SIGNAL;

end architecture preload_behave;
