
-- Author: Group 14, Prajval Malhotra (p6malhot), Rushil Nileshkumar Nagarsheth (rnnagars)
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;

entity Compx4 is 

	port(
		A, B : in std_logic_vector(3 downto 0);
		AGTB, AEQB, ALTB : out std_logic
	);
	
end Compx4;

ARCHITECTURE circuit of Compx4 is 

component Compx1
	PORT (
		A, B : IN STD_LOGIC;
		ALTB, AGTB, AEQB : out std_logic
	);
end component;

signal A3LTB3, A3GTB3, A3EQB3 : std_logic;
signal A2LTB2, A2GTB2, A2EQB2 : std_logic;
signal A1LTB1, A1GTB1, A1EQB1 : std_logic;
signal A0LTB0, A0GTB0, A0EQB0 : std_logic;

begin 

bit3: Compx1 port map (A(3), B(3), A3LTB3, A3GTB3, A3EQB3);
bit2: Compx1 port map (A(2), B(2), A2LTB2, A2GTB2, A2EQB2);
bit1: Compx1 port map (A(1), B(1), A1LTB1, A1GTB1, A1EQB1);
bit0: Compx1 port map (A(0), B(0), A0LTB0, A0GTB0, A0EQB0);

-- Checks if most significant bits compare, else move on to the lower significant bits
AGTB <= A3GTB3 OR (A3EQB3 AND (A2GTB2 OR (A2EQB2 AND (A1GTB1 OR (A1EQB1 AND A0GTB0)))));
AEQB <= A3EQB3 AND A2EQB2 AND A1EQB1 AND A0EQB0;
ALTB <= A3LTB3 OR (A3EQB3 AND (A2LTB2 OR (A2EQB2 AND (A1LTB1 OR (A1EQB1 AND A0LTB0)))));

end circuit;