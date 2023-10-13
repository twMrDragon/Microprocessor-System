LIBRARY IEEE;
USE IEEE.sTD_LOGIC_1164.all;

ENTITY fullAdd is
	port(
		Cin,x,y : in std_logic;
		s,Cout : out std_logic
	);
END fullAdd;

ARCHITECTURE func of fullAdd is
BEGIN
	s <= x xor y xor Cin;
	Cout <= (x and y) or (Cin and x) or (Cin and y);
END func;