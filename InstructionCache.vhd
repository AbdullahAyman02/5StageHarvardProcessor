LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY InstructionCache IS
    PORT (
        address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        int : IN STD_LOGIC;
        rst_address : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        int_address : OUT STD_LOGIC_VECTOR(15 DOWNTO 0); 
        instruction : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        -- No exceptions yet in Phase 1
    );
END ENTITY;

ARCHITECTURE struct_instruction_cache OF InstructionCache IS
    TYPE slot IS ARRAY(0 TO 1023) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL inst : slot;
BEGIN
    process(clk, rst, int)
        VARIABLE rst_counter : INTEGER := 0;
        VARIABLE int_counter : INTEGER := 0;
    begin
        if rst = '1' and rst_counter = 0 then
            rst_counter := 1;
            rst_address <= inst(0);
        elsif falling_edge(clk) and rst_counter = 1 then
            rst_address <= inst(1);
            rst_counter := 0;
        elsif int = '1' and int_counter = 0 then
            int_counter := 1;
            int_address <= inst(2);
        elsif falling_edge(clk) and int_counter = 1 then
            int_address <= inst(3);
            int_counter := 0;
        end if;
    end process;
    instruction <= inst(to_integer(unsigned(address)));
END struct_instruction_cache;