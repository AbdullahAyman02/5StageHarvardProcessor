LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY InterruptFSM IS
    PORT (
        clk : IN STD_LOGIC;
        int : IN STD_LOGIC;
        rti : IN STD_LOGIC;
        stall : OUT STD_LOGIC;
        flagsOrPC : OUT STD_LOGIC
    );
END InterruptFSM;

ARCHITECTURE InterruptFSM_arch OF InterruptFSM IS

    SIGNAL prevStall : STD_LOGIC := '0';
    SIGNAL tempFlagsOrPC : STD_LOGIC := '0';

BEGIN
    PROCESS (clk)
    BEGIN
        IF falling_edge(clk) THEN
            IF int = '1' OR rti = '1' THEN
                IF prevStall = '0' THEN
                    prevStall <= '1';
                    tempFlagsOrPC <= '0';
                ELSE
                    prevStall <= '0';
                    tempFlagsOrPC <= '1';
                END IF;
            END IF;
        END IF;
    END PROCESS;

    stall <= prevStall;
    flagsOrPC <= tempFlagsOrPC;
END InterruptFSM_arch;