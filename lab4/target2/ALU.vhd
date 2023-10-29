LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.lab4_package.ALL;

ENTITY ALU IS
	PORT (
		a, b : IN STD_LOGIC;
		setLessThan : IN STD_LOGIC;
		operation : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		cin : IN STD_LOGIC;
		result : OUT STD_LOGIC;
		cout : OUT STD_LOGIC
	);
END ALU;
ARCHITECTURE func OF ALU IS
	SIGNAL muxA, muxB : STD_LOGIC;
	SIGNAL andResult : STD_LOGIC;
	SIGNAL orResult : STD_LOGIC;
	SIGNAL FAResult : STD_LOGIC;
BEGIN
	muxAStage : mux2to1 PORT MAP(NOT a, a, operation(3), muxA);
	muxBStage : mux2to1 PORT MAP(NOT b, b, operation(2), muxB);

	andResult <= muxA AND muxB;
	orResult <= muxA OR muxB;
	FAStage : fullAdd PORT MAP(cin, muxA, muxB, FAResult, cout);
	muxStage : mux4to1 PORT MAP(setLessThan & FAResult & orResult & andResult, operation(1), operation(0), result);
END func;