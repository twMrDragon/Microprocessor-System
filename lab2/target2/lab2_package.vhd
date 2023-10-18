LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE lab2_package IS
	COMPONENT fullAdd
		PORT (
			Cin, x, y : IN STD_LOGIC;
			s, Cout : OUT STD_LOGIC
		);
	END COMPONENT fullAdd;

	COMPONENT hex
		PORT (
			sw0, sw1, sw2, sw3, sw4, sw5, sw6, sw7 : IN STD_LOGIC;
			a1, b1, c1, d1, e1, f1, g1, a2, b2, c2, d2, e2, f2, g2 : OUT STD_LOGIC
		);
	END COMPONENT hex;
END lab2_package;