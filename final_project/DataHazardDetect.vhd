LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.final_project_package.ALL;

ENTITY DataHazardDetect IS
    PORT (
        ID_EXE_opcode : IN opcode_type;
        ID_EXE_rs_id : IN NATURAL RANGE 0 TO 3;
        ID_EXE_rt_id : IN NATURAL RANGE 0 TO 3;
        EXE_MEM_opcode : IN opcode_type;
        EXE_MEM_rs_id : IN NATURAL RANGE 0 TO 3;
        MEM_WB_opcode : IN opcode_type;
        MEM_WB_rs_id : IN NATURAL RANGE 0 TO 3;
        isRsHazard_MEM : OUT BOOLEAN;
        isRtHazard_MEM : OUT BOOLEAN;
        isRsHazard_WB : OUT BOOLEAN;
        isRtHazard_WB : OUT BOOLEAN
    );
END DataHazardDetect;

ARCHITECTURE func OF DataHazardDetect IS
    SIGNAL ID_EXE_rs_opcode_may_hazard : BOOLEAN;
    SIGNAL ID_EXE_rt_opcode_may_hazard : BOOLEAN;
    SIGNAL EXE_MEM_rs_opcode_may_hazard : BOOLEAN;
    SIGNAL MEM_WB_rs_opcode_may_hazard : BOOLEAN;

    SIGNAL MEM_rt_rs_same_id : BOOLEAN;
    SIGNAL MEM_rs_rs_same_id : BOOLEAN;
    SIGNAL WB_rt_rs_same_id : BOOLEAN;
    SIGNAL WB_rs_rs_same_id : BOOLEAN;
BEGIN
    -- opcode will read rs register
    WITH ID_EXE_opcode SELECT
        ID_EXE_rs_opcode_may_hazard <= true WHEN Add | Sub,
        true WHEN OP_And | OP_Or | OP_Nor,
        true WHEN Slt,
        true WHEN Div,
        true WHEN Sw,
        false WHEN OTHERS;

    -- opcode will read rt register    
    WITH ID_EXE_opcode SELECT
        ID_EXE_rt_opcode_may_hazard <= true WHEN Move,
        true WHEN Add | Sub,
        true WHEN OP_And | OP_Or | OP_Nor,
        true WHEN Slt,
        true WHEN Div,
        true WHEN Lw | Sw,
        false WHEN OTHERS;

    -- opcode will write register EX_MEM
    WITH EXE_MEM_opcode SELECT
        EXE_MEM_rs_opcode_may_hazard <= true WHEN Load | Move,
        true WHEN Add | Sub,
        true WHEN OP_And | OP_Or | OP_Nor,
        true WHEN Slt,
        true WHEN Div,
        false WHEN OTHERS;

    -- opcode will write register MEM_WB
    WITH MEM_WB_opcode SELECT
        MEM_WB_rs_opcode_may_hazard <= true WHEN Load | Move,
        true WHEN Add | Sub,
        true WHEN OP_And | OP_Or | OP_Nor,
        true WHEN Slt,
        true WHEN Div,
        true WHEN Lw,
        false WHEN OTHERS;

    MEM_rs_rs_same_id <= ID_EXE_rs_id = EXE_MEM_rs_id;
    MEM_rt_rs_same_id <= ID_EXE_rt_id = EXE_MEM_rs_id;
    WB_rs_rs_same_id <= ID_EXE_rs_id = MEM_WB_rs_id;
    WB_rt_rs_same_id <= ID_EXE_rt_id = MEM_WB_rs_id;

    isRsHazard_MEM <= EXE_MEM_rs_opcode_may_hazard AND ID_EXE_rs_opcode_may_hazard AND MEM_rs_rs_same_id;
    isRtHazard_MEM <= EXE_MEM_rs_opcode_may_hazard AND ID_EXE_rt_opcode_may_hazard AND MEM_rt_rs_same_id;
    isRsHazard_WB <= MEM_WB_rs_opcode_may_hazard AND ID_EXE_rs_opcode_may_hazard AND WB_rs_rs_same_id;
    isRtHazard_WB <= MEM_WB_rs_opcode_may_hazard AND ID_EXE_rt_opcode_may_hazard AND WB_rt_rs_same_id;
END ARCHITECTURE; -- func