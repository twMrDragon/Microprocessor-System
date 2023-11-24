LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY target1 IS
	GENERIC (N : INTEGER := 8);
	PORT (
		clk : IN STD_LOGIC;
		clear : IN STD_LOGIC;
		load : IN STD_LOGIC;
		lr_sel : IN STD_LOGIC;
		di : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
		sdi : IN STD_LOGIC;
		qo : BUFFER STD_LOGIC_VECTOR(N - 1 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE func OF target1 IS
BEGIN
	PROCESS
	BEGIN
		WAIT UNTIL clk'EVENT AND clk = '1';
		IF clear = '1' THEN
			clearLoop : FOR i IN N - 1 DOWNTO 0 LOOP
				qo(i) <= '0';
			END LOOP;
		ELSIF load = '1'THEN
			qo <= di;
		ELSIF lr_sel = '1' THEN
			leftShiftLoop : FOR i IN N - 1 DOWNTO 1 LOOP
				qo(i) <= qo(i - 1);
			END LOOP;
			qo(0) <= sdi;
		ELSIF lr_sel = '0' THEN
			rightShiftLoop : FOR i IN 0 TO N - 2 LOOP
				qo(i) <= qo(i + 1);
			END LOOP;
			qo(N - 1) <= sdi;
		END IF;
	END PROCESS;
END ARCHITECTURE;