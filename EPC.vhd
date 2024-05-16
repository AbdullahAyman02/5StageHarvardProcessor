LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY EPC IS
    PORT(
        OVERFLOW_PC  : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        PROTECTED_PC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        OVERFLOW_FLAG : IN STD_LOGIC;
        PROTECTED_FLAG  : IN STD_LOGIC;

        EPC_PC : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        EPC_FLAG : OUT STD_LOGIC -- '1' OVERFLOW, '0' PROTECTED
        );
END ENTITY;

ARCHITECTURE EPC_ARCH OF EPC IS
    
BEGIN
    -- If both exceptions are raised, the EPC_PC is set to the protected PC
    EPC_PC <= OVERFLOW_PC WHEN (OVERFLOW_FLAG = '1' AND PROTECTED_FLAG = '0') ELSE
              PROTECTED_PC;
    
    -- If both exceptions are raised, the EPC_FLAG is set to '1'
    EPC_FLAG <= '1' WHEN (OVERFLOW_FLAG = '1' AND PROTECTED_FLAG = '0') ELSE
                '0';
END ARCHITECTURE;