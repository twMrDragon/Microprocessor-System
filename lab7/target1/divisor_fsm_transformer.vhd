LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE work.lab7_target1_package.ALL;

ENTITY divisor_fsm_transformer IS
    PORT (
        clk, reset, w : IN STD_LOGIC;
        state : BUFFER divisor_fsm_state := Start
    );
END ENTITY;

ARCHITECTURE func OF divisor_fsm_transformer IS
BEGIN
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