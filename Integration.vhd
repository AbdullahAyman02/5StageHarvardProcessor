LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Integration IS
    PORT (
        rst, clk : IN STD_LOGIC;
        signextend_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY Integration;

ARCHITECTURE Behavioral OF Integration IS
    COMPONENT PC
        GENERIC (n : INTEGER := 32);
        PORT (
            rst, enable, clk : IN STD_LOGIC;
            update : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            inst_address : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
        );
    END COMPONENT PC;

    COMPONENT my_nadder
        GENERIC (n : INTEGER := 32);
        PORT (
            a, b : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            cin : IN STD_LOGIC;
            s : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            cout : OUT STD_LOGIC
        );
    END COMPONENT my_nadder;

    COMPONENT InstructionCache
        PORT (
            address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            instruction : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT InstructionCache;

    COMPONENT sign_extend
        PORT (
            instruction_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            instruction_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT sign_extend;


    SIGNAL update : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL instruction : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL cout : STD_LOGIC;

BEGIN
    PC1 : PC PORT MAP(rst, enable, clk, update, inst_address);
    Adder1 : my_adder PORT MAP(inst_address,(1 => '1', others => '0') ,'0', update, cout);
    Cache1 : InstructionCache PORT MAP(inst_address, instruction);
    sign_extend1 : sign_extend PORT MAP(instruction, signextend_out);
END Behavioral;


