LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ProtectionUnit IS
    PORT (
        Clk, Rst, MemWrite, Protect, Free : IN STD_LOGIC;
        Address : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        MemoryEn, Exception : OUT STD_LOGIC
    );
END ProtectionUnit;

ARCHITECTURE struct_ProtectionUnit OF ProtectionUnit IS
    SIGNAL memory : STD_LOGIC_VECTOR(0 TO 4096) := (OTHERS => '0');
BEGIN
    PROCESS (Clk, Rst)
    BEGIN
        IF Rst = '1' THEN
            memory <= (OTHERS => '0');
        ELSIF rising_edge(Clk) THEN
            IF Protect = '1' AND Free = '0' THEN
                memory(to_integer(unsigned(Address))) <= '1';
            ELSIF Protect = '0' AND Free = '1' THEN
                memory(to_integer(unsigned(Address))) <= '0';
            END IF;
        ELSIF falling_edge(Clk) THEN
            IF MemWrite = '1' AND (memory(to_integer(unsigned(Address))) = '0' OR Free = '1') THEN
                MemoryEn <= '1';
            ELSE
                MemoryEn <= '0';
            END IF;
            IF (memory(to_integer(unsigned(Address))) = '1' OR memory(to_integer(unsigned(Address) + 1)) = '1') AND MemWrite = '1' AND Free ='0' THEN
                Exception <= '1';
            ELSE
                Exception <= '0';
            END IF;
        END IF;
    END PROCESS;
END struct_ProtectionUnit;