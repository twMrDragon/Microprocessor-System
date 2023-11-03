LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.lab4_package.ALL;

ENTITY lab4_target2 IS
	PORT (
		A, B : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		operation : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		--		hex0, hex1 : OUT STD_LOGIC_VECTOR(0 TO 6)
		hexArray : OUT myHexArray(0 TO 7);
		overflow : OUT STD_LOGIC
	);
END lab4_target2;

ARCHITECTURE func OF lab4_target2 IS
	SIGNAL resultTemp : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL cTemp : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL MSB_Sum : STD_LOGIC;
	SIGNAL LSB_SetLess : STD_LOGIC;
	SIGNAL overflowTemp : STD_LOGIC;
BEGIN
	-- ALU
	ALU_LSB_Stage : ALU PORT MAP(A(0), B(0), LSB_SetLess, operation, operation(2), resultTemp(0), cTemp(1));
	G1 : FOR i IN 1 TO 5 GENERATE
		ALU_Stage : ALU PORT MAP(A(i), B(i), '0', operation, cTemp(i), resultTemp(i), cTemp(i + 1));
	END GENERATE;
	ALU_MSB_Stage : ALU_MSB PORT MAP(A(6), B(6), '0', operation, cTemp(6), resultTemp(6), cTemp(7), MSB_Sum, overflowTemp);

	--	set less than
	LSB_SetLess <= MSB_Sum XOR overflowTemp;
	-- overflow
	overflow <= overflowTemp;

	--	7 segment display
	-- 7 bits
	G2 : FOR i IN 0 TO 6 GENERATE
		hexStage : hex PORT MAP("000" & resultTemp(i), hexArray(i));
	END GENERATE;
	hexOverflowStage : hex PORT MAP("000" & overflowTemp, hexArray(7));

	--	hex
	--	hex0Stage : hex PORT MAP(resultTemp(3 DOWNTO 0), hex0);
	--	hex1Stage : hex PORT MAP('0' & resultTemp(6 DOWNTO 4), hex1);
END func;