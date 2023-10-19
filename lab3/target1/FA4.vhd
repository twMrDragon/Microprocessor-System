LIBRARY IEEE;
USE IEEE.sTD_LOGIC_1164.ALL;
USE work.lab3_package.ALL;

ENTITY FA4 IS
	PORT (
		Cin : IN STD_LOGIC;
		A, B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		S : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		Cout : OUT STD_LOGIC
	);
END FA4;

ARCHITECTURE func OF FA4 IS
	-- 臨時變數
	SIGNAL C : STD_LOGIC_VECTOR(4 DOWNTO 1);
BEGIN
	-- 把全加器串在一起	
	stage0 : fullAdd PORT MAP(Cin, A(0), B(0), S(0), C(1));
	stage1 : fullAdd PORT MAP(C(1), A(1), B(1), S(1), C(2));
	stage2 : fullAdd PORT MAP(C(2), A(2), B(2), S(2), C(3));
	stage3 : fullAdd PORT MAP(C(3), A(3), B(3), S(3), Cout);
END func;