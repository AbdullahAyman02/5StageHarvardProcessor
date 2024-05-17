LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Fetch IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        enable : IN STD_LOGIC;
        int : IN STD_LOGIC;
        ret_rti : IN STD_LOGIC;
        ret_rti_m : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        address_selector : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        decode_address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        execute_address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        correction_address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        branch : IN STD_LOGIC;
        immediate : IN STD_LOGIC;
        ret_rti_stall : IN STD_LOGIC;
        exception : IN STD_LOGIC;
        loadUse : IN STD_LOGIC;

        Instruction : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        PC_Address_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        pc_to_store : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END Fetch;

ARCHITECTURE Fetch_Arch OF Fetch IS
    COMPONENT PC IS
        GENERIC (n : INTEGER := 32);
        PORT (
            rst, enable, clk : IN STD_LOGIC;
            update : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            rst_m : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            int : IN STD_LOGIC;
            int_m : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            ret_rti : IN STD_LOGIC;
            ret_rti_m : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            immediate : IN STD_LOGIC;
            ret_rti_stall : IN STD_LOGIC;
            loadUse : IN STD_LOGIC;
            inst_address : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT InstructionCache IS
        PORT (
            address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            int : IN STD_LOGIC;
            immediate : IN STD_LOGIC;
            ret_rti_stall : IN STD_LOGIC;
            loadUse : IN STD_LOGIC;
            rst_address : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            int_address : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            instruction : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
            -- No exceptions yet in Phase 1
        );
    END COMPONENT;

    COMPONENT my_nadder IS
        GENERIC (n : INTEGER := 32);
        PORT (
            a, b : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            cin : IN STD_LOGIC;
            s : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            cout, overflow : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT Mux4 IS
        GENERIC (n : INTEGER := 10);
        PORT (
            selectors : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            input1, input2, input3, input4 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            output : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
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

    -- Signals
    SIGNAL inst_address : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL inst : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL pc_update : STD_LOGIC_VECTOR(31 DOWNTO 0) := (31 DOWNTO 0 => '0');
    SIGNAL rst_address : STD_LOGIC_VECTOR(15 DOWNTO 0) := (15 DOWNTO 0 => '0');
    SIGNAL int_address : STD_LOGIC_VECTOR(15 DOWNTO 0) := (15 DOWNTO 0 => '0');
    SIGNAL pc_address : STD_LOGIC_VECTOR(31 DOWNTO 0) := (31 DOWNTO 0 => '0');
    SIGNAL which_pc_selector : STD_LOGIC_VECTOR(1 DOWNTO 0) := (1 DOWNTO 0 => '0');
    SIGNAL normal_pc_or_exception_pc : STD_LOGIC_VECTOR(31 DOWNTO 0) := (31 DOWNTO 0 => '0');
    SIGNAL store_branch : STD_LOGIC := '0';

BEGIN
    store_branch <= '1' WHEN branch = '1' OR ((inst(14 DOWNTO 12) = "110" OR inst(14 DOWNTO 12) = "111") AND inst(11 DOWNTO 9) = "000")
        ELSE
        '0';
    which_pc_selector <= int & store_branch;

    -- Components
    PC1 : PC GENERIC MAP(32) PORT MAP(rst, enable, clk, normal_pc_or_exception_pc, rst_address, int, int_address, ret_rti, ret_rti_m, immediate, ret_rti_stall, loadUse, inst_address);
    InstructionCache1 : InstructionCache PORT MAP(inst_address, clk, rst, int, immediate, ret_rti_stall, loadUse, rst_address, int_address, inst);
    Adder : my_nadder GENERIC MAP(32) PORT MAP(inst_address, x"00000001", '0', pc_update, OPEN, OPEN);
    NextAddressMux : Mux4 GENERIC MAP(32) PORT MAP(address_selector, decode_address, execute_address, correction_address, pc_update, pc_address);
    WhichPCToStore : Mux4 GENERIC MAP(32) PORT MAP(which_pc_selector, inst_address, pc_update, inst_address, pc_address, pc_to_store);

    Mux2_1 : Mux2 GENERIC MAP(32) PORT MAP(exception, pc_address, x"00000ff1", normal_pc_or_exception_pc);

    Instruction <= inst;
    PC_Address_out <= inst_address;
END Fetch_Arch;