LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY target1 IS
    PORT (
        clk, reset, w : IN STD_LOGIC;
        output : OUT STD_LOGIC_VECTOR(2 DOWNTO 0) := "000"
    );
END ENTITY;

ARCHITECTURE func OF target1 IS
    TYPE FSMState IS (Start, S1, S2a, S2b, S3, S4);
    SIGNAL state : FSMState := Start;
BEGIN
    WITH state SELECT
        output <= "000" WHEN Start,
        "001" WHEN S1,
        "010" WHEN S2a,
        "011" WHEN S2b,
        "100" WHEN S3,
        "101" WHEN S4,
        "000" WHEN OTHERS;

    PROCESS
    BEGIN
        WAIT UNTIL clk'EVENT AND clk = '1';
        IF reset = '1' THEN
            state <= Start;
        ELSE
            CASE state IS
                WHEN Start =>
                    IF w = '1' THEN
                        state <= S1;
                    END IF;
                WHEN S1 =>
                    IF w = '0' THEN
                        state <= S2a;
                    ELSE
                        state <= S2b;
                    END IF;
                WHEN S2a =>
                    state <= S3;
                WHEN S2b =>
                    state <= S3;
                WHEN S3 =>
                    IF w = '0' THEN
                        state <= S1;
                    ELSE
                        state <= S4;
                    END IF;
                WHEN OTHERS =>
            END CASE;
        END IF;
    END PROCESS;
END ARCHITECTURE;