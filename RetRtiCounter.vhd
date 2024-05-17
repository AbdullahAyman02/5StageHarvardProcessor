LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY RetRtiCounter IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        ret_rti : IN STD_LOGIC;
        enable : IN STD_LOGIC;
        branch_in_execute : IN STD_LOGIC;
        stall : OUT STD_LOGIC
    );
END RetRtiCounter;

ARCHITECTURE RetRtiCounter_arch OF RetRtiCounter IS
    SIGNAL temp : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";

BEGIN
    PROCESS (clk, branch_in_execute, ret_rti, rst)
        VARIABLE stall : INTEGER := 0;
    BEGIN
        IF (rising_edge(clk) AND to_integer(unsigned(temp)) > 0) THEN
            IF enable = '1' THEN
                temp <= STD_LOGIC_VECTOR(unsigned(temp) - 1);
            END IF;
        END IF;
        IF rst = '1' OR branch_in_execute = '1' THEN
            temp <= "000";
            stall := 1;
        ELSIF RET_RTI = '1' AND stall = 0 THEN
            temp <= "011";
        ELSE
            stall := 0;
        END IF;
    END PROCESS;

    stall <= '1' WHEN unsigned(temp) > 0
        ELSE
        '0';
END RetRtiCounter_arch;