LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

PACKAGE lab7_target1_package IS

	TYPE divisor_fsm_state IS (Start, S1, S2a, S2b, S3, S4);
	ATTRIBUTE enum_encoding : STRING;
	ATTRIBUTE enum_encoding OF divisor_fsm_state : TYPE IS "sequential";

	TYPE hexArray IS ARRAY(NATURAL RANGE <>) OF STD_LOGIC_VECTOR(0 TO 6);

	COMPONENT divisor_fsm_transformer
		PORT (
			clk, reset, w : IN STD_LOGIC;
			state : BUFFER divisor_fsm_state := Start
		);
	END COMPONENT;

	COMPONENT to7Segment
		PORT (
			I : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			O : OUT STD_LOGIC_VECTOR(0 TO 6)
		);
	END COMPONENT;

	COMPONENT debounce
		PORT (
			clock : IN STD_LOGIC;
			btn : IN STD_LOGIC;
			btn_debounce : OUT STD_LOGIC
		);
	END COMPONENT;

END PACKAGE;