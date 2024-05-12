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

        Instruction : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        PC_Address_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
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
        inst_address : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT InstructionCache IS
    PORT (
        address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        int : IN STD_LOGIC;
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

    -- Signals
    SIGNAL inst_address : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL inst : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL pc_address : STD_LOGIC_VECTOR(31 DOWNTO 0) := (31 DOWNTO 0 => '0');
    SIGNAL rst_address : STD_LOGIC_VECTOR(15 DOWNTO 0) := (15 DOWNTO 0 => '0');
    SIGNAL int_address : STD_LOGIC_VECTOR(15 DOWNTO 0) := (15 DOWNTO 0 => '0');
BEGIN
    -- Components
    PC1 : PC generic map(32) PORT MAP (rst, enable, clk, pc_address, rst_address, int, int_address, ret_rti, ret_rti_m, inst_address);
    InstructionCache1 : InstructionCache PORT MAP (inst_address, clk, rst, int, rst_address, int_address, inst);
    Adder : my_nadder generic map(32) PORT MAP (inst_address, x"00000001", '0', pc_address, open, open);

    Instruction <= inst;
    PC_Address_out <= inst_address;
END Fetch_Arch;