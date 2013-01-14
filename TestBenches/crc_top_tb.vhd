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

---------------------------------------------------------------------------------------
-- This architecture tests the preload_behave architecture only!
architecture preload_behave_testbench of crc_module_tb is

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
constant TIMES : positive:= 100000;
constant CLK_PERIOD : time := 40 ns;
constant NUM_BITS_READ : natural := 56;
constant CRC_SIZE : natural := 8;

-- input/output signals
signal clock_signal : std_logic;
signal reset_signal : std_logic := '1';
signal test_data_bit: std_logic := '0';	 
signal expected_output_bit : std_logic := '0';
signal test_data_vec: std_logic_vector(NUM_BITS_READ - 1 downto 0):=(others => '0');
signal out_data_vec: std_logic_vector(0 to NUM_BITS_READ + CRC_SIZE - 1):=(others => '0');
signal tx_out : std_logic;
signal tx_busy : std_logic;
signal error : std_logic := '1'; -- 1 when an unexpected result is found

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

-- read_line process
-- reads the input from the data file
-- and the output (after a delay) for comparison
-- with the actual output of the module
read_line: process (reset_signal, tx_busy, clock_signal)
file INFILE: text is in "TestBenches/testInputNonRev.txt";
file OUTFILE: text is in "TestBenches/testOutputNonRev.txt";
variable myLine : line;
variable myLineBits : bit_vector (NUM_BITS_READ-1 downto 0);
variable resultLine: line;
variable resultLineBits : bit_vector (NUM_BITS_READ+CRC_SIZE -1 downto 0);
variable count : integer := -1;
begin
	if( falling_edge(tx_busy) or rising_edge(reset_signal)) then
		-- read input
		readline(INFILE,myLine);
		read(myLine,myLineBits);
		test_data_vec <= to_stdlogicvector(myLineBits);
		count := 0;
	elsif rising_edge(clock_signal) and count >=0 then 
		-- delay and load results from file
		count := count+1;
		if count = CRC_SIZE then
			readline(OUTFILE,resultLine);
			read(resultLine,resultLineBits); 
			out_data_vec <= to_stdlogicvector(resultLineBits);
		end if;
	end if;
end process;

feed_input: process (test_data_vec, clock_signal,reset_signal)
variable index : natural := 0;
begin
	if(reset_signal'event and reset_signal = '0') or
	  (test_data_vec'event) then
		index := 0;
		--MSB first
		test_data_bit <= test_data_vec(NUM_BITS_READ - 1);
	elsif (clock_signal'event and clock_signal='1') then
	    index := (index+1) mod NUM_BITS_READ;
		-- MSB first
		test_data_bit <= test_data_vec(NUM_BITS_READ - 1 - index);
	end if;
end process;

compare_output: process (out_data_vec, clock_signal)
variable index : natural := 0;
begin
	if( falling_edge(reset_signal) or out_data_vec'event ) then
		index := 0;
		expected_output_bit <= out_data_vec(index);
	elsif (clock_signal'event and clock_signal='1') then
	    index := (index+1) mod (NUM_BITS_READ + CRC_SIZE);
		expected_output_bit <= out_data_vec(index);
	end if;
end process;			  

error <= expected_output_bit xor tx_out;

end preload_behave_testbench; 


---------------------------------------------------------------------------------------
-- This architecture tests the no_preload_behave architecture only!
architecture no_preload_behave_testbench of crc_module_tb is

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
constant CRC_SIZE : natural := 8;

-- input/output signals
signal clock_signal : std_logic;
signal reset_signal : std_logic := '1';
signal test_data_bit: std_logic := '0';	 
signal expected_output_bit : std_logic := '0';
signal test_data_vec: std_logic_vector(NUM_BITS_READ - 1 downto 0):=(others => '0');
signal out_data_vec: std_logic_vector(0 to NUM_BITS_READ + CRC_SIZE - 1):=(others => '0');
signal tx_out : std_logic;
signal tx_busy : std_logic;
signal error : std_logic := '1'; -- 1 when an unexpected result is found

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

-- read_line process
-- reads the input from the data file
-- and the output (after a delay) for comparison
-- with the actual output of the module
read_line: process (reset_signal, tx_busy, clock_signal)
file INFILE: text is in "TestBenches/testInputNonRev.txt";
file OUTFILE: text is in "TestBenches/testOutputNonRev.txt";
variable myLine : line;
variable myLineBits : bit_vector (NUM_BITS_READ-1 downto 0);
variable resultLine: line;
variable resultLineBits : bit_vector (NUM_BITS_READ+CRC_SIZE -1 downto 0);
variable count : integer := -1;
begin
	if( falling_edge(tx_busy) or rising_edge(reset_signal)) then
		-- read input
		readline(INFILE,myLine);
		read(myLine,myLineBits);
		test_data_vec <= to_stdlogicvector(myLineBits);
		count := 0;
	elsif rising_edge(clock_signal) and count >=0 then 
		-- delay and load results from file
		count := count+1;
		if count = CRC_SIZE then
			readline(OUTFILE,resultLine);
			read(resultLine,resultLineBits); 
			out_data_vec <= to_stdlogicvector(resultLineBits);
		end if;
	end if;
end process;

feed_input: process (test_data_vec, clock_signal,reset_signal)
variable index : natural := 0;
begin
	if(reset_signal'event and reset_signal = '0') or
	  (test_data_vec'event) then
		index := 0;
		--MSB first
		test_data_bit <= test_data_vec(NUM_BITS_READ - 1);
	elsif (clock_signal'event and clock_signal='1') then
	    index := (index+1) mod NUM_BITS_READ;
		-- MSB first
		test_data_bit <= test_data_vec(NUM_BITS_READ - 1 - index);
	end if;
end process;

compare_output: process (out_data_vec, clock_signal)
variable index : natural := 0;
begin
	if( falling_edge(reset_signal) or out_data_vec'event ) then
		index := 0;
		expected_output_bit <= out_data_vec(index);
	elsif (rising_edge(clock_signal)) then
	    index := (index+1) mod (NUM_BITS_READ + CRC_SIZE + CRC_SIZE);
		if( index >= NUM_BITS_READ+CRC_SIZE ) then
			expected_output_bit <= '0';
		else
			expected_output_bit <= out_data_vec(index);
		end if;
	end if;
end process;			  

error <= expected_output_bit xor tx_out;

end no_preload_behave_testbench;


---------------------------------------------------------------------------------------
-- RECEIVER MODE NO-PRELOAD
architecture rx_no_preload of crc_module_tb is

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
constant NUM_BITS_READ : natural := 64;
constant CRC_SIZE : natural := 8;

-- input/output signals
signal clock_signal : std_logic;
signal reset_signal : std_logic := '1';
signal test_data_bit: std_logic := '0';	 
signal expected_output_bit : std_logic := '0';
signal test_data_vec: std_logic_vector(NUM_BITS_READ - 1 downto 0):=(others => '0');
signal tx_out : std_logic;
signal tx_busy : std_logic;
signal error : std_logic := '1'; -- 1 when an unexpected result is found
signal indexs : integer;

begin
TRANSMITTER : crc_module port map('1', test_data_bit, clock_signal,
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

-- read_line process
read_line: process (reset_signal, tx_busy, clock_signal)
file INFILE: text is in "TestBenches/testOutputNonRev.txt";
variable myLine : line;
variable myLineBits : bit_vector (NUM_BITS_READ-1 downto 0);
begin
	if( falling_edge(tx_busy) or rising_edge(reset_signal)) then
		-- read input
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
		--MSB first
		test_data_bit <= test_data_vec(NUM_BITS_READ - 1);
	elsif (clock_signal'event and clock_signal='1') then
	    index := (index+1) mod NUM_BITS_READ;
		-- MSB first
		test_data_bit <= test_data_vec(NUM_BITS_READ - 1 - index);
	end if;
end process;

compare_output: process (reset_signal, test_data_vec, clock_signal)
variable index : natural := 0;
begin
	if( falling_edge(reset_signal) or test_data_vec'event ) then
		index := 0;
		indexs <= index;
		expected_output_bit <= '0';
	elsif (clock_signal'event and clock_signal='1') then
	    index := (index+1) mod (NUM_BITS_READ + CRC_SIZE + CRC_SIZE);
		indexs <= index;
		
		if index < 8 then
			expected_output_bit <= '0'; -- "padding"
		elsif index < NUM_BITS_READ  then  
			expected_output_bit <= test_data_vec(NUM_BITS_READ-index+8-1);
		else
			expected_output_bit <= '0'; -- CRC should be okay
		end if;
	end if;
end process;			  

error <= expected_output_bit xor tx_out;

end rx_no_preload;

---------------------------------------------------------------------------------------
-- RECEIVER MODE PRELOAD
architecture rx_preload of crc_module_tb is

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
constant NUM_BITS_READ : natural := 64;
constant CRC_SIZE : natural := 8;

-- input/output signals
signal clock_signal : std_logic;
signal reset_signal : std_logic := '1';
signal test_data_bit: std_logic := '0';	 
signal expected_output_bit : std_logic := '0';
signal test_data_vec: std_logic_vector(NUM_BITS_READ - 1 downto 0):=(others => '0');
signal tx_out : std_logic;
signal tx_busy : std_logic;
signal error : std_logic := '1'; -- 1 when an unexpected result is found
signal indexs : integer;

begin
TRANSMITTER : crc_module port map('1', test_data_bit, clock_signal,
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

-- read_line process
read_line: process (reset_signal, tx_busy, clock_signal)
file INFILE: text is in "TestBenches/testOutputNonRev.txt";
variable myLine : line;
variable myLineBits : bit_vector (NUM_BITS_READ-1 downto 0);
begin
	if( falling_edge(tx_busy) or rising_edge(reset_signal)) then
		-- read input
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
		--MSB first
		test_data_bit <= test_data_vec(NUM_BITS_READ - 1);
	elsif (clock_signal'event and clock_signal='1') then
	    index := (index+1) mod NUM_BITS_READ;
		-- MSB first
		test_data_bit <= test_data_vec(NUM_BITS_READ - 1 - index);
	end if;
end process;

compare_output: process (reset_signal, test_data_vec, clock_signal)
variable index : natural := 0;
begin
	if( falling_edge(reset_signal) or test_data_vec'event ) then
		index := 0;
		indexs <= index;
		expected_output_bit <= '0';
	elsif (clock_signal'event and clock_signal='1') then
	    index := (index+1) mod (NUM_BITS_READ + CRC_SIZE);
		indexs <= index;
		
		if index < 8 then
			expected_output_bit <= '0'; -- "CRC of the previous data"
		elsif index < NUM_BITS_READ  then  
			expected_output_bit <= test_data_vec(NUM_BITS_READ-index+8-1);
		end if;
	end if;
end process;			  

error <= expected_output_bit xor tx_out;

end rx_preload;