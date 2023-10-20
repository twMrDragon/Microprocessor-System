LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.lab3_package.ALL;

ENTITY BCDAdd IS
	PORT (
		Cin : IN STD_LOGIC;
		A, B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		S : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		Cout : OUT STD_LOGIC
	);
END BCDAdd;

ARCHITECTURE func OF BCDAdd IS
	SIGNAL S_Temp : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL C_Temp : STD_LOGIC;
	SIGNAL isCarry : STD_LOGIC;
	SIGNAL Cout_Temp : STD_LOGIC;
BEGIN
	-- 第一次加法
	stage0 : FA4 PORT MAP(Cin, A, B, S_Temp, C_Temp);
	-- 檢查是否進位
	isCarry <= C_Temp OR (S_Temp(3) AND S_Temp(2)) OR (S_Temp(3) AND S_Temp(1));
	Cout <= isCarry;
	-- 修正電路
	stage1 : FA4 PORT MAP('0', S_Temp, '0' & isCarry & isCarry & '0', S, Cout_Temp);
END func;