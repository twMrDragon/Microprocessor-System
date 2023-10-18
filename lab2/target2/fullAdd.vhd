LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY fullAdd IS
	PORT (
		Cin, x, y : IN STD_LOGIC;
		s, Cout : OUT STD_LOGIC
	);
END fullAdd;

ARCHITECTURE func OF fullAdd IS
BEGIN
	s <= x XOR y XOR Cin;
	Cout <= (x AND y) OR (Cin AND x) OR (Cin AND y);
END func;