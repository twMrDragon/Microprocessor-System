LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE work.lab8_target1_package.ALL;

ENTITY target1 IS
    PORT (
        clock, clock50m : IN STD_LOGIC;
        opcode : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        rs, rt : IN INTEGER RANGE 0 TO 3;
        data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        hex : OUT hexArray(5 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE func OF target1 IS
    SIGNAL divisionCount : INTEGER := 0;
    SIGNAL localRemainder : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL localDivisor : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL localQuotient : STD_LOGIC_VECTOR(7 DOWNTO 0);

    TYPE regArray IS ARRAY (NATURAL RANGE <>) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL reg : regArray(0 TO 3);
    SIGNAL debounce_btnClk : STD_LOGIC;
BEGIN
    hexStage5 : to7Segment PORT MAP(reg(rt)(7 DOWNTO 4), hex(5));
    hexStage4 : to7Segment PORT MAP(reg(rt)(3 DOWNTO 0), hex(4));

    hexStage3 : to7Segment PORT MAP(reg(rs)(7 DOWNTO 4), hex(3));
    hexStage2 : to7Segment PORT MAP(reg(rs)(3 DOWNTO 0), hex(2));

    hexStage1 : to7Segment PORT MAP(data(7 DOWNTO 4), hex(1));
    hexStage0 : to7Segment PORT MAP(data(3 DOWNTO 0), hex(0));

    debounceStage : debounce PORT MAP(clock50m, clock, debounce_btnClk);
    PROCESS
    BEGIN
        WAIT UNTIL debounce_btnClk'EVENT AND debounce_btnClk = '0';
        CASE opcode IS
            WHEN "0000" =>
                reg(rs) <= data;
            WHEN "0001" =>
                reg(rs) <= reg(rt);
                reg(rt) <= (OTHERS => '0');
            WHEN "0010" =>
                reg(rs) <= reg(rs) + reg(rt);
            WHEN "0011" =>
                reg(rs) <= reg(rs) AND reg(rt);
            WHEN "0101" =>
                reg(rs) <= reg(rs) - reg(rt);
            WHEN "1001" =>
                reg(rs) <= reg(rt) - reg(rs);
            WHEN "0100" =>
                reg(rs) <= (OTHERS => '0');
                IF reg(rs) < reg(rt) THEN
                    reg(rs)(0) <= '1';
                END IF;
            WHEN "1111" =>
                IF divisionCount = 0 THEN
                    divisionCount <= 1;
                    localRemainder <= (OTHERS => '0');
                    localRemainder(7 DOWNTO 0) <= reg(rs);
                    localDivisor <= (OTHERS => '0');
                    localDivisor(15 DOWNTO 8) <= reg(rt);
                    localQuotient <= (OTHERS => '0');
                ELSIF divisionCount = 10 THEN
                    reg(rs) <= localQuotient;
                    divisionCount <= 0;
                ELSE
                    divisionCount <= divisionCount + 1;
                    IF localRemainder >= localDivisor THEN
                        localQuotient <= localQuotient(6 DOWNTO 0) & '1';
                        localRemainder <= localRemainder - localDivisor;
                    ELSE
                        localQuotient <= localQuotient(6 DOWNTO 0) & '0';
                    END IF;
                    localDivisor <= '0' & localDivisor(15 DOWNTO 1);
                END IF;
            WHEN OTHERS =>
                NULL;
        END CASE;
    END PROCESS;
END ARCHITECTURE;