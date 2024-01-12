LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.final_project_package.ALL;

ENTITY final_project IS
    PORT (
        opcode : IN opcode_type;
        rs, rt : IN NATURAL RANGE 0 TO 3;
        data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        btnClk : IN STD_LOGIC;
        clk50M : IN STD_LOGIC;
        hex : OUT hexArray(7 DOWNTO 0);
        dataHazard : OUT STD_LOGIC;

        SRAM_ADDR : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);-- 與SRAM溝通之位址
        SRAM_DQ : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);-- 與SRAM溝通之資料
        SRAM_CE_N : OUT STD_LOGIC;-- 與SRAM溝通之腳位
        SRAM_OE_N : OUT STD_LOGIC;-- 與SRAM溝通之腳位
        SRAM_WE_N : OUT STD_LOGIC;-- 與SRAM溝通之Write Enable
        SRAM_UB_N : OUT STD_LOGIC;-- 與SRAM溝通之腳位
        SRAM_LB_N : OUT STD_LOGIC -- 與SRAM溝通之腳位
    );
END final_project;

ARCHITECTURE func OF final_project IS
    CONSTANT ZERO : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL debounce_btnClk : STD_LOGIC := '0';
    SIGNAL isInitialize : BOOLEAN := false;

    SIGNAL isRsHazard_MEM, isRtHazard_MEM : BOOLEAN;
    SIGNAL isRsHazard_WB, isRtHazard_WB : BOOLEAN;

    -- divider
    SIGNAL dividerQuotient, dividerRemainder : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL enableDivider : STD_LOGIC;
    SIGNAL dividerDone : STD_LOGIC;

    SIGNAL ID_stage_rs_data, ID_stage_rt_data : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL EXE_A_data, EXE_B_data : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL alu_result : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL EXE_Result : STD_LOGIC_VECTOR(7 DOWNTO 0);

    SIGNAL LW_Result : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL MEM_Result : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL MEM_MUX_Result : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL MEM_Write : STD_LOGIC;

    -- register
    SIGNAL registerArray : register_Array_type(0 TO 3);
    SIGNAL IF_ID_Register : IF_ID_Register_type := (NOP, 0, 0, ZERO);
    SIGNAL ID_EXE_Register : ID_EXE_Register_type := (NOP, 0, 0, ZERO, ZERO);
    SIGNAL EXE_MEM_Register : EXE_MEM_Register_type := (NOP, 0, ZERO, ZERO, ZERO);
    SIGNAL MEM_WB_Register : MEM_WB_Register_type := (NOP, 0, ZERO);
BEGIN
    -- output 7 segment
    -- 不知道為什麼要一直顯示出來 Lw forward 才不會有問題
    hexStage7 : to7Segment PORT MAP(MEM_WB_Register.write_back_data(7 DOWNTO 4), hex(7));
    hexStage6 : to7Segment PORT MAP(MEM_WB_Register.write_back_data(3 DOWNTO 0), hex(6));

    hexStage5 : to7Segment PORT MAP(registerArray(rt)(7 DOWNTO 4), hex(5));
    hexStage4 : to7Segment PORT MAP(registerArray(rt)(3 DOWNTO 0), hex(4));

    hexStage3 : to7Segment PORT MAP(registerArray(rs)(7 DOWNTO 4), hex(3));
    hexStage2 : to7Segment PORT MAP(registerArray(rs)(3 DOWNTO 0), hex(2));

    hexStage1 : to7Segment PORT MAP(data(7 DOWNTO 4), hex(1));
    hexStage0 : to7Segment PORT MAP(data(3 DOWNTO 0), hex(0));

    debounceStage : debounce PORT MAP(clk50M, btnClk, debounce_btnClk);
    ID_stage_rs_data <= registerArray(IF_ID_Register.rs_id);
    ID_stage_rt_data <= registerArray(IF_ID_Register.rt_id);

    -- alu
    EXE_A_data <= EXE_MEM_Register.alu_result WHEN isRsHazard_MEM ELSE
        MEM_WB_Register.write_back_data WHEN isRsHazard_WB ELSE
        ID_EXE_Register.rs_data;
    EXE_B_data <= EXE_MEM_Register.alu_result WHEN isRtHazard_MEM ELSE
        MEM_WB_Register.write_back_data WHEN isRtHazard_WB ELSE
        ID_EXE_Register.rt_data;
    EXE_Result <= dividerQuotient WHEN ID_EXE_Register.opcode = Div ELSE
        alu_result;

    aluStage : alu PORT MAP(
        ID_EXE_Register.opcode,
        EXE_A_data,
        EXE_B_data,
        alu_result
    );

    -- divider
    enableDivider <= '1' WHEN (ID_EXE_Register.opcode = Div) ELSE
        '0';

    dividerStage : Divider PORT MAP(
        EXE_A_data,
        EXE_B_data,
        dividerQuotient,
        dividerRemainder,
        enableDivider,
        debounce_btnClk,
        dividerDone
    );

    -- mem
    SRAMStage : SRAM PORT MAP(
        EXE_MEM_Register.rt_data,
        EXE_MEM_Register.rs_data,
        MEM_Result,
        MEM_Write,
        SRAM_ADDR,
        SRAM_DQ,
        SRAM_CE_N,
        SRAM_OE_N,
        SRAM_WE_N,
        SRAM_UB_N,
        SRAM_LB_N
    );
    MEM_Write <= '1' WHEN EXE_MEM_Register.opcode = Sw ELSE
        '0';
    MEM_MUX_Result <= MEM_Result WHEN EXE_MEM_Register.opcode = Lw ELSE
        EXE_MEM_Register.alu_result;

    -- data hazard
    dataHazard <= '1' WHEN isRsHazard_MEM OR isRtHazard_MEM OR isRsHazard_WB OR isRtHazard_WB ELSE
        '0';
    dataHazardStage : DataHazardDetect PORT MAP(
        ID_EXE_Register.opcode,
        ID_EXE_Register.rs_id,
        ID_EXE_Register.rt_id,
        EXE_MEM_Register.opcode,
        EXE_MEM_Register.rs_id,
        MEM_WB_Register.opcode,
        MEM_WB_Register.write_back_register_id,
        isRsHazard_MEM,
        isRtHazard_MEM,
        isRsHazard_WB,
        isRtHazard_WB
    );

    -- pipeline
    PROCESS
    BEGIN
        WAIT UNTIL debounce_btnClk'EVENT AND debounce_btnClk = '1';
        IF NOT isInitialize THEN
            isInitialize <= true;
        ELSE
            IF ID_EXE_Register.opcode = Div AND dividerDone = '0' THEN
                -- do nothing until divider done
                NULL;
            ELSE
                -- IF
                IF_ID_Register <= (opcode, rs, rt, data);

                -- ID
                IF IF_ID_Register.opcode = Load THEN
                    ID_EXE_Register <= (
                        IF_ID_Register.opcode,
                        IF_ID_Register.rs_id, IF_ID_Register.rt_id,
                        IF_ID_Register.data, ZERO
                        );
                ELSIF IF_ID_Register.opcode = Move THEN
                    ID_EXE_Register <= (
                        IF_ID_Register.opcode,
                        IF_ID_Register.rs_id, IF_ID_Register.rt_id,
                        ZERO, ID_stage_rt_data
                        );
                ELSIF IF_ID_Register.opcode = Lw OR IF_ID_Register.opcode = Sw THEN
                    ID_EXE_Register <= (
                        IF_ID_Register.opcode,
                        IF_ID_Register.rs_id, IF_ID_Register.rt_id,
                        ID_stage_rs_data, ID_stage_rt_data
                        );
                ELSE
                    ID_EXE_Register <= (
                        IF_ID_Register.opcode,
                        IF_ID_Register.rs_id, IF_ID_Register.rt_id,
                        ID_stage_rs_data, ID_stage_rt_data
                        );
                END IF;

                -- MEM
                EXE_MEM_Register <= (
                    ID_EXE_Register.opcode,
                    ID_EXE_Register.rs_id,
                    EXE_A_Data,
                    EXE_B_Data,
                    EXE_Result
                    );

                -- EXE
                MEM_WB_Register <= (
                    EXE_MEM_Register.opcode,
                    EXE_MEM_Register.rs_id,
                    MEM_MUX_Result
                    );
            END IF;
        END IF;
    END PROCESS;

    PROCESS
    BEGIN
        WAIT UNTIL debounce_btnClk'EVENT AND debounce_btnClk = '0';
        -- WB
        -- do write back at first half-cycle
        IF ID_EXE_Register.opcode = Div AND dividerDone = '0' THEN
            NULL;
        ELSE
            IF MEM_WB_Register.opcode /= NOP AND MEM_WB_Register.opcode /= Sw THEN
                registerArray(MEM_WB_Register.write_back_register_id) <= MEM_WB_Register.write_back_data;
            END IF;
        END IF;
    END PROCESS;

END func; -- func