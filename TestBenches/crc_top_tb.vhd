-------------------------------------------------------------------------------
--
-- Title       : counter_tb
-- Design      : CRCmd
-- Author      : Giuliano
-- Company     : La mia
--
-------------------------------------------------------------------------------
--
-- File        : counter_tb.vhd
-- Generated   : Wed Dec 19 12:43:46 2012
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {counter_tb} architecture {tb_counter}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use STD.TEXTIO.all;

entity crc_module_tb is
end crc_module_tb;

--}} End of automatically maintained section

architecture tb_crc_module of crc_module_tb is

component gen_clock is
	generic (
	PERIOD : time := 0 ns;
	NUM_OF_PERIODS : positive := 1
	);
	port(
		 CLK : out STD_LOGIC := '0'
	     );
end component gen_clock;

component crc_module is
	 port(
		 md : in STD_LOGIC;
		 line_in : in STD_LOGIC;
		 clock : in STD_LOGIC;
		 reset : in STD_LOGIC;
		 line_out : out STD_LOGIC;
		 busy : out std_logic --active low
	     );
end component crc_module;

-- control constants
constant TIMES : positive:= 1000;
constant CLK_PERIOD : time := 40 ns;
constant NUM_BITS_READ : natural := 56;

-- input/output signals
signal clock_signal : std_logic;
signal reset_signal : std_logic := '1';
signal test_data_bit: std_logic := '0';
signal test_data_vec: std_logic_vector(NUM_BITS_READ - 1 downto 0):=(others => '0');
signal tx_out : std_logic;
signal tx_busy : std_logic;

signal indexs:integer;

begin
TRANSMITTER : crc_module port map('0', test_data_bit, clock_signal,
		 reset_signal, tx_out, tx_busy);

CG : gen_clock generic map (PERIOD => CLK_PERIOD, NUM_OF_PERIODS => TIMES)
port map (clock_signal);


progress_and_reset : process (clock_signal)
	variable count_per : natural := 0;
	begin
		if rising_edge(clock_signal) then
			count_per := count_per + 1;
		end if;
		case count_per is
			when 28 => reset_signal <= '0';
			when 31 => reset_signal <= '1';
			when others => null;
		end case;
end process;

read_line: process (reset_signal, tx_busy)
file INFILE: text is in "TestBenches/testInputNonRev.txt";
variable myLine : line;
variable myLineBits : bit_vector (NUM_BITS_READ-1 downto 0);
begin
	if( falling_edge(tx_busy) or rising_edge(reset_signal)) then
		-- read a line and put it on test_data_vec
		readline(INFILE,myLine);
		read(myLine,myLineBits);
		test_data_vec <= to_stdlogicvector(myLineBits);
	end if;
end process;

feed_input: process (test_data_vec, clock_signal,reset_signal)
variable index : natural := 0;
begin
	if(reset_signal'event and reset_signal = '0') or
	  (test_data_vec'event) then
		index := 0;
		indexs <= index;
		--MSB first
		test_data_bit <= test_data_vec(NUM_BITS_READ - 1);
		--LSB first
		--test_data_bit <= test_data_vec(0);
	elsif (clock_signal'event and clock_signal='1') then
	    index := (index+1) mod NUM_BITS_READ;
	    indexs <= index;
		-- MSB first
		test_data_bit <= test_data_vec(NUM_BITS_READ - 1 - index);
		-- LSB first
		--test_data_bit <= test_data_vec(index);
	end if;
end process;

end tb_crc_module;
