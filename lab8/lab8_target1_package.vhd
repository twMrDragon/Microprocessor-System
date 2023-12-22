LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE lab8_target1_package IS
    TYPE hexArray IS ARRAY (NATURAL RANGE <>) OF STD_LOGIC_VECTOR(0 TO 6);

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