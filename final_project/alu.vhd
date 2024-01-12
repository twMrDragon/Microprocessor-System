LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE work.final_project_package.ALL;

ENTITY alu IS
    PORT (
        opcode : IN opcode_type;
        rs_data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        rt_data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        result : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END alu;

ARCHITECTURE func OF alu IS
    SIGNAL slt_result : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL slt_LSB : STD_LOGIC;
BEGIN
    slt_LSB <= '1' WHEN rs_data < rt_data ELSE
        '0';
    slt_result <= (0 => slt_LSB, OTHERS => '0');
    WITH opcode SELECT
        result <= rs_data + rt_data WHEN Add | Load | Move | Lw | Sw,
        rs_data - rt_data WHEN Sub,
        rs_data AND rt_data WHEN OP_And,
        rs_data OR rt_data WHEN OP_Or,
        rs_data NOR rt_data WHEN OP_Nor,
        slt_result WHEN Slt,
        (OTHERS => '0') WHEN OTHERS;
END ARCHITECTURE; -- arch