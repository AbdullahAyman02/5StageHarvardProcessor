LIBRARY IEEE;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

ENTITY PC IS
    GENERIC (n : INTEGER := 32);
    PORT (
        rst, enable, clk : IN STD_LOGIC;
        update : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        rst_m : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        inst_address : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
    );
END ENTITY PC;

ARCHITECTURE programCounter OF PC IS
    SIGNAL curr_address : STD_LOGIC_VECTOR(n - 1 DOWNTO 0) := (OTHERS => '0');
BEGIN
    PROCESS (clk, rst)
        VARIABLE rst_counter : INTEGER := 0;
    BEGIN
        IF rising_edge(clk) THEN
            IF rst = '1' AND rst_counter = 0 THEN
                rst_counter := 1;
                curr_address <= "0000000000000000" & rst_m;
            ELSIF rst_counter = 1 THEN
                curr_address <= rst_m & curr_address(15 DOWNTO 0);
                rst_counter := rst_counter - 1;
            ELSIF enable = '1' THEN
                curr_address <= update;
            END IF;
        END IF;
    END PROCESS;

    inst_address <= curr_address;

END ARCHITECTURE programCounter;