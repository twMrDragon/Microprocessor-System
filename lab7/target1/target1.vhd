LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE work.lab7_target1_package.ALL;

ENTITY target1 IS
	PORT (
		btnClk, clk50m, clear, handOrAuto : IN STD_LOGIC;
		Divisor, Dividend : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		Remainder, Quotient : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		hexOutput : OUT hexArray(3 DOWNTO 0);
		current_state : OUT divisor_fsm_state
	);
END ENTITY;

ARCHITECTURE func OF target1 IS
	SIGNAL myClk : STD_LOGIC;
	SIGNAL debounce_btnClk : STD_LOGIC;

	SIGNAL w : STD_LOGIC := '0';

	SIGNAL fsm_state : divisor_fsm_state := Start;
	SIGNAL repeat_count : INTEGER RANGE 0 TO 9;

	SIGNAL localRemainder : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL localDivisor : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL localQuotient : STD_LOGIC_VECTOR(7 DOWNTO 0);

	SIGNAL hexOutputTemp : hexArray(3 DOWNTO 0);
BEGIN
	-- 解彈跳
	debounceStage : debounce PORT MAP(clk50m, btnClk, debounce_btnClk);
	myClk <= debounce_btnClk WHEN handOrAuto = '0' ELSE
		clk50m;
		
	-- 狀態轉移
	fsmStage : divisor_fsm_transformer PORT MAP(myClk, clear, w, fsm_state);
	current_state <= fsm_state;

	-- 七段顯示器輸出	
	hexStage0 : to7Segment PORT MAP(localRemainder(3 DOWNTO 0), hexOutputTemp(0));
	hexStage1 : to7Segment PORT MAP(localRemainder(7 DOWNTO 4), hexOutputTemp(1));
	hexStage2 : to7Segment PORT MAP(localQuotient(3 DOWNTO 0), hexOutputTemp(2));
	hexStage3 : to7Segment PORT MAP(localQuotient(7 DOWNTO 4), hexOutputTemp(3));

	stage1 : FOR i IN 3 DOWNTO 0 GENERATE
		hexOutput(i) <= hexOutputTemp(i) WHEN fsm_state = S4 ELSE
		(OTHERS => '1');
	END GENERATE;

	-- led輸出
	Remainder <= localRemainder(7 DOWNTO 0);
	Quotient <= localQuotient(7 DOWNTO 0);

	--	邏輯設計
	PROCESS
	BEGIN
		WAIT UNTIL myClk'EVENT AND myClk = '1';
		CASE fsm_state IS
			WHEN Start =>
				localRemainder <= (OTHERS => '0');
				localRemainder(7 DOWNTO 0) <= Dividend;
				localDivisor <= (OTHERS => '0');
				localDivisor(15 DOWNTO 8) <= Divisor;
				localQuotient <= (OTHERS => '0');
				repeat_count <= 0;
				w <= '1';
			WHEN S1 =>
				repeat_count <= repeat_count + 1;
				w <= '1';
				IF localRemainder >= localDivisor THEN
					w <= '0';
				END IF;
				localRemainder <= localRemainder - localDivisor;
			WHEN S2a =>
				localQuotient <= localQuotient(6 DOWNTO 0) & '1';
			WHEN S2b =>
				localQuotient <= localQuotient(6 DOWNTO 0) & '0';
				localRemainder <= localRemainder + localDivisor;
			WHEN S3 =>
				localDivisor <= '0' & localDivisor(15 DOWNTO 1);
				w <= '0';
				IF repeat_count = 9 THEN
					w <= '1';
				END IF;
			WHEN OTHERS =>
				NULL;
		END CASE;
	END PROCESS;

END ARCHITECTURE;