LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.lab4_package.ALL;

ENTITY mux4to1 IS
	PORT (
		w : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		s1, s0 : IN STD_LOGIC;
		f : OUT STD_LOGIC
	);
END mux4to1;
ARCHITECTURE func OF mux4to1 IS
	SIGNAL f1, f2 : STD_LOGIC;
BEGIN
	muxStage0 : mux2to1 PORT MAP(w(1), w(0), s0, f1);
	muxStage1 : mux2to1 PORT MAP(w(3), w(2), s0, f2);
	muxStage2 : mux2to1 PORT MAP(f2, f1, s1, f);
END func;