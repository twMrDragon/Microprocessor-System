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
	-- 臨時變數 用於全加器
	SIGNAL C : STD_LOGIC_VECTOR(0 TO 8);
	SIGNAL S : STD_LOGIC_VECTOR(0 TO 7);
	-- 臨時變數 用於出現負數時處理顯示的七段顯示器的資料
	SIGNAL CN : STD_LOGIC_VECTOR(0 TO 8);
	SIGNAL SN : STD_LOGIC_VECTOR(0 TO 7);
	-- 正負號
	SIGNAL sign : STD_LOGIC;
BEGIN
	-- 全加器改的全減器(2的補數)
	stage0 : fullAdd PORT MAP('1', A(0), NOT B(0), S(0), C(1));
	stage1 : fullAdd PORT MAP(C(1), A(1), NOT B(1), S(1), C(2));
	stage2 : fullAdd PORT MAP(C(2), A(2), NOT B(2), S(2), C(3));
	stage3 : fullAdd PORT MAP(C(3), A(3), NOT B(3), S(3), C(4));
	stage4 : fullAdd PORT MAP(C(4), A(4), NOT B(4), S(4), C(5));
	stage5 : fullAdd PORT MAP(C(5), A(5), NOT B(5), S(5), C(6));
	stage6 : fullAdd PORT MAP(C(6), A(6), NOT B(6), S(6), C(7));
	stage7 : fullAdd PORT MAP(C(7), A(7), NOT B(7), S(7), C(8));

	-- 處理正負號結果 
	-- 輸入A為8bit，可以看為帶有一個sign bit且永遠為0(0_xxxx_xxxx)
	-- 輸入B為8bit，可以看為帶有一個sign bit且永遠為1(1_xxxx_xxxx)
	-- 是否為負號是看sign bit是否為1
	-- 因為上面兩sign bit相加一定為1
	-- 所以只要看前一級進位並可判斷結果是否為負
	sign <= NOT C(8);
	-- 輸出正負號至LED
	Cout <= sign;

	-- 處理2的補數計算後，如果結果為負數的例外狀況
	stage8 : fullAdd PORT MAP(sign, '0', sign XOR S(0), SN(0), CN(1));
	stage9 : fullAdd PORT MAP(CN(1), '0', sign XOR S(1), SN(1), CN(2));
	stage10 : fullAdd PORT MAP(CN(2), '0', sign XOR S(2), SN(2), CN(3));
	stage11 : fullAdd PORT MAP(CN(3), '0', sign XOR S(3), SN(3), CN(4));
	stage12 : fullAdd PORT MAP(CN(4), '0', sign XOR S(4), SN(4), CN(5));
	stage13 : fullAdd PORT MAP(CN(5), '0', sign XOR S(5), SN(5), CN(6));
	stage14 : fullAdd PORT MAP(CN(6), '0', sign XOR S(6), SN(6), CN(7));
	stage15 : fullAdd PORT MAP(CN(7), '0', sign XOR S(7), SN(7), CN(8));

	-- 七段顯示器
	hexStage : hex PORT MAP(
		SN(3), SN(2), SN(1), SN(0), SN(7), SN(6), SN(5), SN(4),
		hex0(0), hex0(1), hex0(2), hex0(3), hex0(4), hex0(5), hex0(6),
		hex1(0), hex1(1), hex1(2), hex1(3), hex1(4), hex1(5), hex1(6));
END func;