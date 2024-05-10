LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY SP IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        func : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        int : IN STD_LOGIC;
        memRead : IN STD_LOGIC;
        loadUse : IN STD_LOGIC;
        addressSelector : IN STD_LOGIC;
        stackPointer : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END SP;

ARCHITECTURE sp_arch OF SP IS
    SIGNAL push_address : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL pop_address : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- SIGNAL nextStackPointer : STD_LOGIC_VECTOR(31 DOWNTO 0) := (11 DOWNTO 0 => '1', OTHERS => '0');

BEGIN

    PROCESS (clk, rst, func, int, memRead, loadUse, addressSelector)
    BEGIN
        IF rst = '1' THEN
            -- nextStackPointer <= (11 DOWNTO 0 => '1', OTHERS => '0');
            push_address <= (11 DOWNTO 0 => '1', OTHERS => '0');
        ELSIF falling_edge(clk) THEN
            IF addressSelector = '1' AND loadUse = '0' THEN
                IF func(2) = '1' AND func(1) = '0' AND int = '0' THEN
                    -- pop_address <= STD_LOGIC_VECTOR(unsigned(nextStackPointer) + 1);
                    -- nextStackPointer <= STD_LOGIC_VECTOR(unsigned(nextStackPointer) + 1);
                    stackPointer <= pop_address;
                    pop_address <= STD_LOGIC_VECTOR(unsigned(pop_address) + 2);
                    push_address <= STD_LOGIC_VECTOR(unsigned(push_address) + 2);
                ELSE
                    -- push_address <= nextStackPointer;
                    -- nextStackPointer <= STD_LOGIC_VECTOR(unsigned(nextStackPointer) - 1);
                    pop_address <= push_address;
                    stackPointer <= push_address;
                    push_address <= STD_LOGIC_VECTOR(unsigned(push_address) - 2);
                END IF;
            END IF;
        END IF;
    END PROCESS;

    -- stackPointer <= push_address WHEN memRead = '0' ELSE
    --     pop_address;
END sp_arch;