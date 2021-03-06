  

-- Author: Group 14, Prajval Malhotra (p6malhot), Rushil Nileshkumar Nagarsheth (rnnagars)
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;

entity Energy_Monitor is 

	port(
		MuxGTCurr, MuxEQCurr, MuxLTCurr, vacation_mode, 
		MC_test_mode, window_open, door_open : in std_logic;
		furnace, at_temp, AC, blower, window, door, 
		vacation, run_n, increase, decrease : out std_logic
	);
	
end Energy_Monitor;

ARCHITECTURE circuit of Energy_Monitor is 

signal win_or_door_open : std_logic;

begin 

win_or_door_open <= window_open or door_open;

	-- HVAC Control
	run_n <= MuxEQCurr or win_or_door_open; -- active low
	increase <= MuxGTCurr; -- when mux > current temp
	decrease <= MuxLTCurr; -- when mux < than current temp

	furnace <= MuxGTCurr;
	at_temp <= MuxEQCurr;
	AC <= MuxLTCurr;
	blower <= not (MuxEQCurr or MC_test_mode or win_or_door_open); -- TODO: confirm this
	window <= window_open;
	door <= door_open;
	vacation <= vacation_mode;

end circuit;