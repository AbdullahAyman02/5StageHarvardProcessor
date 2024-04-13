LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY InstructionCache IS
    PORT (
        address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        instruction : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        -- No exceptions yet in Phase 1
    );
END ENTITY;

ARCHITECTURE struct_instruction_cache OF InstructionCache IS
    TYPE slot IS ARRAY(0 TO 1023) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL inst : slot;
BEGIN
    instruction <= inst(to_integer(unsigned(address)));
END struct_instruction_cache;