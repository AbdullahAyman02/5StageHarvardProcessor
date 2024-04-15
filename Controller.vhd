LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY CONTROLLER IS
    PORT(
            OPCODE: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            FUNCTION_BITS: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            
            CONTROL_SIGNALS: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
END ENTITY;

ARCHITECTURE CONTROLLER_ARCH OF CONTROLLER IS
    SIGNAL  ALU_OPERATION, MEM_READ, MEM_WRITE, SELECT_PC, PROTECT, FREE, REG_WRITE, REG_WRITE_2, MEM_TO_REG, BRANCH, UNCONDITIONAL_BRANCH, 
            IN_ENABLE, OUT_ENABLE, ADDRESS_SELECTOR, RET_OR_RTI, RTI, IMM: STD_LOGIC;
BEGIN
    ALU_OPERATION           <= '1'  WHEN (OPCODE = "001" OR OPCODE = "010")
                                    ELSE '0';
   
    MEM_READ                <= '1'  WHEN ((OPCODE = "100" AND FUNCTION_BITS(1) = '0') OR (OPCODE = "110" AND FUNCTION_BITS(2) = '1')) 
                                    ELSE '0';
    MEM_WRITE               <= '1'  WHEN ((OPCODE = "100" AND FUNCTION_BITS(1) = '1') OR (OPCODE = "110" AND FUNCTION_BITS(2) = '0')) 
                                    ELSE '0';
   
    SELECT_PC               <= '1'  WHEN (OPCODE = "110" AND FUNCTION_BITS(2) = '0') 
                                    ELSE '0';
   
    PROTECT                 <= '1'  WHEN (OPCODE = "101" AND FUNCTION_BITS(0) = '0') 
                                    ELSE '0';
    FREE                    <= '1'  WHEN (OPCODE = "101" AND FUNCTION_BITS(0) = '1') 
                                    ELSE '0';
   
    REG_WRITE               <= '1'  WHEN ((OPCODE = "001" AND FUNCTION_BITS /= "010") OR (OPCODE = "010") OR (OPCODE = "011" AND FUNCTION_BITS(0) = '1') OR (OPCODE = "100" AND FUNCTION_BITS(1) = '0')) 
                                    ELSE '0';
    REG_WRITE_2             <= '1'  WHEN (OPCODE = "001" AND FUNCTION_BITS = "110") 
                                    ELSE '0';
   
    MEM_TO_REG              <= '1'  WHEN (OPCODE = "100" AND FUNCTION_BITS(1) = '0') 
                                    ELSE '0';
   
    BRANCH                  <= '1'  WHEN (OPCODE(2 DOWNTO 1) = "11") 
                                    ELSE '0';
    UNCONDITIONAL_BRANCH    <= '1'  WHEN ((OPCODE = "110") OR (OPCODE = "111" AND FUNCTION_BITS(0) = '1')) 
                                    ELSE '0';  
   
    IN_ENABLE               <= '1'  WHEN (OPCODE = "011" AND FUNCTION_BITS(0) = '1') 
                                    ELSE '0';
    OUT_ENABLE              <= '1'  WHEN (OPCODE = "011" AND FUNCTION_BITS(0) = '0') 
                                    ELSE '0';
   
    ADDRESS_SELECTOR        <= '1'  WHEN ((OPCODE = "100" AND FUNCTION_BITS(2) = '1') OR (OPCODE = "110")) 
                                    ELSE '0';
   
    RET_OR_RTI              <= '1'  WHEN (OPCODE = "110" AND FUNCTION_BITS(2) = '1') 
                                    ELSE '0';
    RTI                     <= '1' WHEN (OPCODE = "110" AND FUNCTION_BITS(0) = '1')
                                    ELSE '0';
   
    CONTROL_SIGNALS <= ALU_OPERATION & MEM_READ & MEM_WRITE & SELECT_PC & PROTECT & FREE & REG_WRITE & REG_WRITE_2 & MEM_TO_REG & BRANCH & UNCONDITIONAL_BRANCH 
                    & IN_ENABLE & OUT_ENABLE & ADDRESS_SELECTOR & RET_OR_RTI & RTI;
END ARCHITECTURE;