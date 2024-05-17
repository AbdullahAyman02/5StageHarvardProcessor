LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY InstructionCache IS
    PORT (
        address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        int : IN STD_LOGIC;
        immediate : IN STD_LOGIC;
        ret_rti_stall : IN STD_LOGIC;
        loadUse : IN STD_LOGIC;
        rst_address : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        int_address : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        instruction : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        -- No exceptions yet in Phase 1
    );
END ENTITY;

ARCHITECTURE struct_instruction_cache OF InstructionCache IS
    TYPE slot IS ARRAY(0 TO 4095) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL inst : slot;
BEGIN
    PROCESS (clk, rst, int)
        VARIABLE rst_counter : INTEGER := 0;
        VARIABLE int_counter : INTEGER := 0;
    BEGIN
        IF rst = '1' AND rst_counter = 0 THEN
            rst_counter := 2;
            rst_address <= inst(0);
        ELSIF falling_edge(clk) AND rst_counter = 2 THEN
            rst_address <= inst(1);
            rst_counter := 1;
        ELSIF int = '1' AND int_counter = 0 AND immediate = '0' AND ret_rti_stall = '0' AND loadUse = '0' THEN
            int_counter := 2;
            int_address <= inst(2);
        ELSIF falling_edge(clk) AND int_counter = 2 THEN
            int_address <= inst(3);
            IF int = '0' THEN
                int_counter := int_counter - 1;
            END IF;
        ELSIF rst = '0' AND rst_counter = 1 THEN
            rst_counter := 0;
        ELSIF int = '0' AND int_counter = 1 THEN
            int_counter := 0;
        END IF;
    END PROCESS;
    instruction <= inst(to_integer(unsigned(address)));
END struct_instruction_cache;