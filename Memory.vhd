LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Memory IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        RS2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        ALU_result : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        Flags : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        --    RS1, RS2 : in STD_LOGIC_VECTOR (2 downto 0);
        --    RDest : in STD_LOGIC_VECTOR (2 downto 0);
        Controls : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
        PC : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        -- Int , stack pointer

        Exception : OUT STD_LOGIC;
        Mem_out : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
    );
END Memory;

ARCHITECTURE Memory_arch OF Memory IS
    COMPONENT data_memory IS
        PORT (
            write_enable, read_enable, rst, clk : IN STD_LOGIC;
            address : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT ProtectionUnit IS
        PORT (
            Clk, Rst, MemWrite, Protect, Free : IN STD_LOGIC;
            Address : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            MemoryEn, Exception : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL MemWriteEn : STD_LOGIC := '0';
BEGIN
    Memory1 : data_memory PORT MAP(write_enable => MemWriteEn, read_enable => Controls(9), rst => reset, clk => clk, address => ALU_result(11 DOWNTO 0), data_in => RS2, data_out => Mem_out);
    ProtectionUnit1 : ProtectionUnit PORT MAP(Clk => clk, Rst => reset, MemWrite => Controls(8), Protect => Controls(6), Free => Controls(5), Address => ALU_result(11 DOWNTO 0), MemoryEn => MemWriteEn, Exception => Exception);
END Memory_arch;