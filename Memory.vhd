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
        INT : IN STD_LOGIC;
        StackPointer : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        INT_FSM : IN STD_LOGIC;

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

    COMPONENT Mux2 IS
        GENERIC (n : INTEGER := 32);
        PORT (
            selector : IN STD_LOGIC;
            input1, input2 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            output : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Mux4 IS
        GENERIC (n : INTEGER := 32);
        PORT (
            selectors : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            input1, input2, input3, input4 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            output : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL MemWriteEn : STD_LOGIC := '0';
    SIGNAL address : STD_LOGIC_VECTOR(11 DOWNTO 0);
    SIGNAL data_in_to_memory : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL mux4_selector : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL extended_flags : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
    mux4_selector <= Controls(7) & INT_FSM;
    extended_flags <= "0000000000000000000000000000" & Flags;

    Mux2_1 : Mux2 GENERIC MAP(12) PORT MAP(selector => Controls(2), input1 => ALU_result(11 DOWNTO 0), input2 => StackPointer(11 DOWNTO 0), output => address);
    Mux4_1 : Mux4 GENERIC MAP(32) PORT MAP(selectors => mux4_selector, input1 => RS2, input2 => RS2, input3 => PC, input4 => extended_flags, output => data_in_to_memory);

    Memory1 : data_memory PORT MAP(write_enable => MemWriteEn, read_enable => Controls(9), rst => reset, clk => clk, address => address, data_in => data_in_to_memory, data_out => Mem_out);
    ProtectionUnit1 : ProtectionUnit PORT MAP(Clk => clk, Rst => reset, MemWrite => Controls(8), Protect => Controls(6), Free => Controls(5), Address => address, MemoryEn => MemWriteEn, Exception => Exception);
END Memory_arch;