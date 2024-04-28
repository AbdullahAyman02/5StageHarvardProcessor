LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ProtectionUnit IS
    PORT (
        -- In reset do we need to make all bits unprotected??
        MemWrite, Protect, Free : IN STD_LOGIC;
        Address : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        MemoryEn, Exception : OUT STD_LOGIC
    );
END ProtectionUnit;

ARCHITECTURE struct_ProtectionUnit OF ProtectionUnit IS
    SIGNAL memory : STD_LOGIC_VECTOR(4096 DOWNTO 0) := (OTHERS => '0');
BEGIN
    memory(to_integer(unsigned(Address))) <= '1' WHEN (Protect = '1' AND Free = '0') ELSE '0' WHEN (Protect = '0' AND Free = '1') ELSE memory(to_integer(unsigned(Address)));
    MemoryEn <= '1' WHEN (MemWrite = '1' AND (memory(to_integer(unsigned(Address))) = '0' OR Free = '1')) ELSE '0';
    Exception <= '1' WHEN (memory(to_integer(unsigned(Address))) = '1' AND MemWrite = '1' ) ELSE '0';
END struct_ProtectionUnit;