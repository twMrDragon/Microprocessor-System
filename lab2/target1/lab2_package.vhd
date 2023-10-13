LIBRARY IEEE;
USE IEEE.sTD_LOGIC_1164.all;

PACKAGE lab2_package IS
	component fullAdd
		port(	
		Cin,x,y : in std_logic;
		s,Cout : out std_logic
		);
	end component fullAdd;
	
	component hex
		port(
			sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7: in std_logic;
			a1,b1,c1,d1,e1,f1,g1,a2,b2,c2,d2,e2,f2,g2: out std_logic
		);
	end component hex;
END lab2_package;