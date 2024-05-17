LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY EPC IS
    PORT (
        clk : IN STD_LOGIC;
        OVERFLOW_PC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        PROTECTED_PC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        OVERFLOW_FLAG : IN STD_LOGIC;
        PROTECTED_FLAG : IN STD_LOGIC;

        EPC_PC : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        EPC_FLAG : OUT STD_LOGIC -- '1' OVERFLOW, '0' PROTECTED
    );
END ENTITY;

ARCHITECTURE EPC_ARCH OF EPC IS
    SIGNAL FREEZE_PC : STD_LOGIC;
    SIGNAL EPC_PC_SIGNAL : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL EPC_FLAG_SIGNAL : STD_LOGIC;
BEGIN
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            -- If both exceptions are raised, the EPC_PC is set to the protected PC

            IF FREEZE_PC = '1' THEN
                EPC_PC_SIGNAL <= EPC_PC_SIGNAL;
                EPC_FLAG_SIGNAL <= EPC_FLAG_SIGNAL;
            ELSIF PROTECTED_FLAG = '0' AND OVERFLOW_FLAG = '1' THEN
                EPC_PC_SIGNAL <= OVERFLOW_PC;
                EPC_FLAG_SIGNAL <= '1';
            ELSE
                EPC_PC_SIGNAL <= PROTECTED_PC;
                EPC_FLAG_SIGNAL <= '0';
            END IF;

            IF OVERFLOW_FLAG = '1' OR PROTECTED_FLAG = '1' OR FREEZE_PC = '1' THEN
                FREEZE_PC <= '1';
            ELSE
                FREEZE_PC <= '0';
            END IF;
        END IF;
    END PROCESS;
    EPC_PC <= EPC_PC_SIGNAL;
    EPC_FLAG <= EPC_FLAG_SIGNAL;
END EPC_ARCH;