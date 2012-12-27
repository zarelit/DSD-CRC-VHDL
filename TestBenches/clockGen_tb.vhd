--------------------------------------------------
--
-- Testbench (gen_clock)
-- 
-- Filename   :
-- Purpose    : Generates stimuli for gen_clock
-- Author     : David Costa <david@zarel.net>
-- Start date :
--
--------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY gen_clock_tb IS
    -- A Testbench has no inputs nor outputs
END gen_clock_tb;

ARCHITECTURE gen_clock_test OF gen_clock_tb IS
    -- We need to declare the type of the entity under test
    COMPONENT gen_clock
		-- diversi periodi per ovvie esigenze
		generic (
		PERIOD : time := 0 ns;
		NUM_OF_PERIODS : positive := 1
		);
		port(
		CLK : inout STD_LOGIC := '0'
	    ); 
	END COMPONENT;

	-- Constants
	CONSTANT MckPer : TIME := 200 ns; -- Master clock period
	CONSTANT TestLen : INTEGER := 50; -- Duration of test as a count of Clock/2

    -- Signals used by the testbench
	SIGNAL clk : std_logic := '0';
	SIGNAL clk_cycle: INTEGER; -- "absolute time", # of clock cycles
	SIGNAL Testing: Boolean := True; -- When false clock generation is stopped

    -- Signals related to the entity under test
	SIGNAL reset : std_logic := '1'; --reset is enabled with 0


-- A single process that generates the clock and changes the input signals
BEGIN
	-- Instantiate here an instance of the unit under test
	I : gen_clock GENERIC MAP(PERIOD=>MckPer, NUM_OF_PERIODS=>TestLen) PORT MAP (open);
	-- Clock generation
	clk <= NOT clk AFTER MckPer/2 WHEN Testing ELSE '0';

        -- Testing process
	-- Updates the clock counter, stops the simulation after TestLen cycles
	-- Feeds signals to the entity under test
        Test_Proc: PROCESS (clk)
	    VARIABLE count: INTEGER := 0; --local variable of the process
	BEGIN
	    clk_cycle <= (count+1)/2; --the process is executed both on the rise and fall edge of the clk
            
	    -- List of events to be generated at a certain time
	    CASE count IS
	        WHEN (TestLen-1) => Testing <= False;
		WHEN OTHERS => NULL;
	    END CASE;
	    
            count:=count+1;
	END PROCESS Test_Proc;

END gen_clock_test;
