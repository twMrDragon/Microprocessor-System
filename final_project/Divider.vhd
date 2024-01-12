LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY Divider IS
    PORT (
        dividend : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        divisor : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        quotient : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        remainder : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        enable : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        isDone : OUT STD_LOGIC
    );
END Divider;

ARCHITECTURE func OF Divider IS
    SIGNAL localDivisor : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL localRemainder : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL localQuotient : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL counter : NATURAL RANGE 0 TO 9;
BEGIN
    quotient <= localQuotient;
    remainder <= localRemainder(7 DOWNTO 0);
    isDone <= '1' WHEN counter = 9 ELSE
        '0';
    PROCESS (enable, clk)
    BEGIN
        IF clk'EVENT AND clk = '1' AND enable = '1' THEN
            IF counter = 0 THEN
                counter <= 1;
                localDivisor(14 DOWNTO 7) <= divisor;
                localRemainder(7 DOWNTO 0) <= dividend;
                localQuotient <= (OTHERS => '0');
            ELSIF counter = 9 THEN
                counter <= 0;
            ELSE
                counter <= counter + 1;
                IF localRemainder >= localDivisor THEN
                    localQuotient <= localQuotient(6 DOWNTO 0) & '1';
                    localRemainder <= localRemainder - localDivisor;
                ELSE
                    localQuotient <= localQuotient(6 DOWNTO 0) & '0';
                END IF;
                localDivisor <= '0' & localDivisor(15 DOWNTO 1);
            END IF;
        END IF;
    END PROCESS;
END ARCHITECTURE;