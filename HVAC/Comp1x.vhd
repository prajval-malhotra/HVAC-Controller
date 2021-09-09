
-- Author: Group 14, Prajval Malhotra (p6malhot), Rushil Nileshkumar Nagarsheth (rnnagars)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;

ENTITY Compx1 is
	PORT (
		A, B : in std_logic;
		ALTB, AGTB, AEQB : out std_logic
	);
END Compx1;

ARCHITECTURE comparator of Compx1 IS

BEGIN 

AGTB <= A AND (NOT B);
ALTB <= B AND (NOT A);
AEQB <= A XNOR B;

END comparator;