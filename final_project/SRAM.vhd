LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SRAM IS
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
END SRAM;

ARCHITECTURE arch OF SRAM IS
    SIGNAL dataWire : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => 'Z');
BEGIN
    SRAM_ADDR(19 DOWNTO 8) <= (OTHERS => '0');
    SRAM_ADDR(7 DOWNTO 0) <= address;

    SRAM_WE_N <= NOT write_enable;
    SRAM_CE_N <= '0';
    SRAM_OE_N <= '0';
    SRAM_UB_N <= '0';
    SRAM_LB_N <= '0';

    dataWire <= data_in WHEN write_enable = '1' ELSE
        (OTHERS => 'Z');
    SRAM_DQ(15 DOWNTO 8) <= (OTHERS => '0');
    SRAM_DQ(7 DOWNTO 0) <= dataWire;

    data_out <= SRAM_DQ(7 DOWNTO 0);
END arch; -- arch