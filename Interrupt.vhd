LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Interrupt IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        int : IN STD_LOGIC;
        retRtiCounter : IN STD_LOGIC;
        branch : IN STD_LOGIC;
        decodeConditionalBranch : IN STD_LOGIC;
        intFSM : IN STD_LOGIC;
        immediate : IN STD_LOGIC;
        latchedInterrupt : OUT STD_LOGIC
    );
END Interrupt;

ARCHITECTURE struct_InterruptLatch OF Interrupt IS
    SIGNAL enable : STD_LOGIC := '0';
    SIGNAL previousLatchedInterrupt : STD_LOGIC := '0';
BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            enable <= '0';
        ELSIF rising_edge(clk) THEN
            IF (retRtiCounter = '1' AND previousLatchedInterrupt = '1') OR decodeConditionalBranch = '1' OR intFSM = '1' OR immediate = '1' THEN
                enable <= '1';
            ELSE
                enable <= '0';
            END IF;
        END IF;
    END PROCESS;

    PROCESS (branch)
    BEGIN
        IF branch = '1' THEN
            enable <= '1';
        ELSE
            enable <= '0';
        END IF;
    END PROCESS;
    previousLatchedInterrupt <= int WHEN enable = '0'
        ELSE
        previousLatchedInterrupt;
    latchedInterrupt <= previousLatchedInterrupt;
END ARCHITECTURE struct_InterruptLatch;