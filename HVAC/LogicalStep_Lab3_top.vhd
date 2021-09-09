-- Author: Group 14, Prajval Malhotra (p6malhot), Rushil Nileshkumar Nagarsheth (rnnagars)

library ieee;
use ieee.std_logic_1164.all;

entity LogicalStep_Lab3_top is port (
	clk_in		: in 	std_logic;
	pb				: in	std_logic_vector(3 downto 0);
 	sw   			: in  std_logic_vector(7 downto 0); 	
   	leds			: out std_logic_vector(11 downto 0)		
); 
end LogicalStep_Lab3_top;

architecture design of LogicalStep_Lab3_top is
--
-- Provided Project Components Used
------------------------------------------------------------------- 
	
component Tester port (
	MC_TESTMODE				: in  std_logic;
	I1EQI2,I1GTI2,I1LTI2	: in	std_logic;
	input1					: in  std_logic_vector(3 downto 0);
	input2					: in  std_logic_vector(3 downto 0);
	TEST_PASS  				: out	std_logic							 
	); 
end component;	
	
component HVAC 	port (
	clk						: in std_logic; 
	run_n		   			: in std_logic;
	increase, decrease	: in std_logic;
	temp						: out std_logic_vector (3 downto 0)
	);
end component;

------------------------------------------------------------------
-- Other required components declared here

component Compx4
port(
	A, B : in std_logic_vector(3 downto 0);
	AGTB, AEQB, ALTB : out std_logic
);
end component;

-- Selects one of the two input 4-bit numbers based on the value of mux_select
component two_one_mux
port (
	num1, num0 		: in std_logic_vector(3 downto 0);
	mux_select 		: in std_logic; 
	mux_out			: out std_logic_vector(3 downto 0)
);
end component;

component Energy_Monitor 
port(
	MuxGTCurr, MuxEQCurr, MuxLTCurr, vacation_mode, 
	MC_test_mode, window_open, door_open : in std_logic;
	furnace, at_temp, AC, blower, window, door, 
	vacation, run_n, increase, decrease : out std_logic
);
end component;

------------------------------------------------------------------	
-- Create any signals to be used

signal desired_temp, vacation_temp, current_temp, mux_temp : std_logic_vector(3 downto 0);
signal MuxGTCurr, MuxEQCurr, MuxLTCurr : std_logic;
signal vacation_mode, MC_test_mode, window_open, door_open : std_logic;
signal increase, decrease, run_n : std_logic;
signal dummy : std_logic; -- TODO: Remove later

------------------------------------------------------------------- 
	
-- Here the circuit begins

begin

	-- Assign Input Signals from Input Ports
	desired_temp <= sw(3 downto 0);
	vacation_temp <= sw(7 downto 4);

	vacation_mode <= pb(3);
	MC_test_mode <= pb(2);
	window_open <= pb(1);
	door_open <= pb(0);

	
	
	temp_selector : two_one_mux port map (
		vacation_temp, desired_temp,
		vacation_mode,
		mux_temp
	);

	comparator: Compx4 port map (
		mux_temp, current_temp,
		MuxGTCurr, MuxEQCurr, MuxLTCurr
	);

	--			
--	component Tester port (
--		MC_TESTMODE				: in  std_logic;
--		I1EQI2,I1GTI2,I1LTI2	: in	std_logic;
--		input1					: in  std_logic_vector(3 downto 0);
--		input2					: in  std_logic_vector(3 downto 0);
--		TEST_PASS  				: out	std_logic							 
--		); 
--	end component;	

	tester_logic: Tester port map (
		MC_test_mode, 
		MuxEQCurr, MuxGTCurr, MuxLTCurr,
		desired_temp, 
		current_temp,
		leds(6)
	);

	hvac_logic: HVAC port map (
		clk_in,
		run_n,
		increase, decrease,
		current_temp
	);

	monitor: Energy_Monitor port map (
		MuxGTCurr, MuxEQCurr, MuxLTCurr, vacation_mode, 
		MC_test_mode, window_open, door_open,
		leds(0), leds(1), leds(2), leds(3), leds(4), leds(5), 
		leds(7), run_n, increase, decrease
	);
	

	
	

	-- Assign Output ports
	leds(11 downto 8) <= current_temp;

end design;
