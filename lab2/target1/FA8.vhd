LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.lab2_package.ALL;

ENTITY FA8 IS
	PORT (
		A, B : IN STD_LOGIC_VECTOR(0 TO 7);
		hex0, hex1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		Cout : OUT STD_LOGIC
	);
END FA8;

ARCHITECTURE func OF FA8 IS
	-- 臨時變數
	SIGNAL C : STD_LOGIC_VECTOR(0 TO 7);
	SIGNAL S : STD_LOGIC_VECTOR(0 TO 7);
BEGIN
	-- 把全加器串在一起	
	stage0 : fullAdd PORT MAP('0', A(0), B(0), S(0), C(1));
	stage1 : fullAdd PORT MAP(C(1), A(1), B(1), S(1), C(2));
	stage2 : fullAdd PORT MAP(C(2), A(2), B(2), S(2), C(3));
	stage3 : fullAdd PORT MAP(C(3), A(3), B(3), S(3), C(4));
	stage4 : fullAdd PORT MAP(C(4), A(4), B(4), S(4), C(5));
	stage5 : fullAdd PORT MAP(C(5), A(5), B(5), S(5), C(6));
	stage6 : fullAdd PORT MAP(C(6), A(6), B(6), S(6), C(7));
	stage7 : fullAdd PORT MAP(C(7), A(7), B(7), S(7), Cout);

	-- 七段顯示器
	hexStage : hex PORT MAP(
		S(3), S(2), S(1), S(0), S(7), S(6), S(5), s(4),
		hex0(0), hex0(1), hex0(2), hex0(3), hex0(4), hex0(5), hex0(6),
		hex1(0), hex1(1), hex1(2), hex1(3), hex1(4), hex1(5), hex1(6));
END func;