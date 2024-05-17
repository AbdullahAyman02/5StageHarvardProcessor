LIBRARY IEEE;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_1164.ALL;

ENTITY PC IS
    GENERIC (n : INTEGER := 32);
    PORT (
        rst, enable, clk : IN STD_LOGIC;
        update : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        rst_m : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        int : IN STD_LOGIC;
        int_m : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        ret_rti : IN STD_LOGIC;
        ret_rti_m : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        immediate: IN STD_LOGIC;
        ret_rti_stall: IN STD_LOGIC;
        loadUse : IN STD_LOGIC;
        inst_address : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
    );
END ENTITY PC;

ARCHITECTURE programCounter OF PC IS
    SIGNAL curr_address : STD_LOGIC_VECTOR(n - 1 DOWNTO 0) := (OTHERS => '0');
BEGIN
    PROCESS (clk, rst, int)
        VARIABLE rst_counter : INTEGER := 0;
        VARIABLE int_counter : INTEGER := 0;
    BEGIN
        IF rising_edge(clk) THEN
            IF rst = '1' AND rst_counter = 0 THEN
                rst_counter := 2;
                curr_address <= "0000000000000000" & rst_m;
            ELSIF rst_counter = 2 THEN
                curr_address <= rst_m & curr_address(15 DOWNTO 0);
                rst_counter := rst_counter - 1;
            ELSIF int = '1' AND int_counter = 0 AND immediate = '0' AND ret_rti_stall = '0' AND loadUse = '0' THEN
                int_counter := 2;
                curr_address <= "0000000000000000" & int_m;
            ELSIF int_counter = 2 THEN
                curr_address <= int_m & curr_address(15 DOWNTO 0);
                IF int = '0' THEN
                    int_counter := int_counter - 1;
                END IF;
            ELSIF ret_rti = '1' THEN
                curr_address <= ret_rti_m;
            ELSIF enable = '1' THEN
                IF rst = '0' THEN
                    rst_counter := 0;
                END IF;
                IF int = '0' THEN
                    int_counter := 0;
                END IF;
                IF rst_counter = 0 AND int_counter = 0 THEN
                    curr_address <= update;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    inst_address <= curr_address;

END ARCHITECTURE programCounter;