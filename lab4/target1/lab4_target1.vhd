LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.lab4_package.ALL;

ENTITY lab4_target1 IS
	PORT (
		a, b : IN STD_LOGIC;
		operation : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		hex1, hex0 : OUT STD_LOGIC_VECTOR(0 TO 6)
	);
END lab4_target1;

ARCHITECTURE func OF lab4_target1 IS
	SIGNAL resultTemp : STD_LOGIC;
	SIGNAL coutTemp : STD_LOGIC;
BEGIN
	ALUStage : ALU PORT MAP(a, b, '0', operation, operation(2), resultTemp, coutTemp);

	hexStage1 : hex PORT MAP("000" & coutTemp, hex1);
	hexStage0 : hex PORT MAP("000" & resultTemp, hex0);
END func;