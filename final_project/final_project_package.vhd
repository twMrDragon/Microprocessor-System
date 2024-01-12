LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE final_project_package IS

    TYPE hexArray IS ARRAY (NATURAL RANGE <>) OF STD_LOGIC_VECTOR(0 TO 6);

    TYPE opcode_type IS (Load, Move, Add, Sub, OP_And, OP_Or, OP_Nor, Slt, NOP, Div, Lw, Sw);
    ATTRIBUTE enum_encoding : STRING;
    ATTRIBUTE enum_encoding OF opcode_type : TYPE IS "0000 0001 0010 0011 0100 0101 0110 0111 1111 1000 1001 1010";

    TYPE register_Array_type IS ARRAY (NATURAL RANGE <>) OF STD_LOGIC_VECTOR(7 DOWNTO 0);

    TYPE IF_ID_Register_type IS RECORD
        opcode : opcode_type;
        rs_id : NATURAL RANGE 0 TO 3;
        rt_id : NATURAL RANGE 0 TO 3;
        data : STD_LOGIC_VECTOR(7 DOWNTO 0);
    END RECORD;

    TYPE ID_EXE_Register_type IS RECORD
        opcode : opcode_type;
        rs_id : NATURAL RANGE 0 TO 3;
        rt_id : NATURAL RANGE 0 TO 3;
        rs_data : STD_LOGIC_VECTOR(7 DOWNTO 0);
        rt_data : STD_LOGIC_VECTOR(7 DOWNTO 0);
    END RECORD;

    TYPE EXE_MEM_Register_type IS RECORD
        opcode : opcode_type;
        rs_id : NATURAL RANGE 0 TO 3;
        rs_data : STD_LOGIC_VECTOR(7 DOWNTO 0);
        -- address
        rt_data : STD_LOGIC_VECTOR(7 DOWNTO 0);
        alu_result : STD_LOGIC_VECTOR(7 DOWNTO 0);
    END RECORD;

    TYPE MEM_WB_Register_type IS RECORD
        opcode : opcode_type;
        write_back_register_id : NATURAL RANGE 0 TO 3;
        write_back_data : STD_LOGIC_VECTOR(7 DOWNTO 0);
    END RECORD;

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

    COMPONENT alu
        PORT (
            opcode : IN opcode_type;
            rs_data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            rt_data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            result : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT DataHazardDetect
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
    END COMPONENT;

    COMPONENT Divider
        PORT (
            dividend : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            divisor : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            quotient : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            remainder : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            enable : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            isDone : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT SRAM
        PORT (
            address : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            data_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            write_enable : IN STD_LOGIC;
            SRAM_ADDR : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);-- 與SRAM溝通之位址
            SRAM_DQ : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);-- 與SRAM溝通之資料
            SRAM_CE_N : OUT STD_LOGIC;-- 與SRAM溝通之腳位
            SRAM_OE_N : OUT STD_LOGIC;-- 與SRAM溝通之腳位
            SRAM_WE_N : OUT STD_LOGIC;-- 與SRAM溝通之Write Enable
            SRAM_UB_N : OUT STD_LOGIC;-- 與SRAM溝通之腳位
            SRAM_LB_N : OUT STD_LOGIC -- 與SRAM溝通之腳位
        );
    END COMPONENT;
END PACKAGE;