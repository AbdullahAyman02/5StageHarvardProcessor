LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY MyRegister IS
    GENERIC (n : INTEGER := 32);
    PORT (
        clk, rst, en : IN STD_LOGIC;
        d : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE struct_MyRegister OF MyRegister IS
BEGIN
    PROCESS (clk, rst)
    BEGIN -- Reset synchronously
        IF rising_edge(clk) THEN -- Write on rising edge
            IF rst = '1' THEN
                q <= (n - 1 DOWNTO 0 => '0');
            ELSIF en = '1' THEN
                q <= d;
            END IF;
        END IF;
    END PROCESS;
END struct_MyRegister;