Library ieee;
USE ieee.std_logic_1164.ALL;

Entity Decode is
    Port (
        Clock : in std_logic;
        Reset : in std_logic;
        Instruction : in std_logic_vector(15 downto 0);
        Pc : in std_logic_vector(31 downto 0);
        Int : in std_logic;
        RegWrite1, RegWrite2 : in std_logic;
        WB_RegDest1, WB_RegDest2 : in std_logic_vector(2 downto 0);
        WB_data1, WB_data2 : in std_logic_vector(31 downto 0);

        RS1, RS2 : out std_logic_vector(31 downto 0);
        Immediate_value : out std_logic_vector(31 downto 0);
        Controls : out std_logic_vector(15 downto 0) 
    );
End Decode;

Architecture Decode_Arch of Decode is
    Component Controller
    PORT(
        OPCODE: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        FUNCTION_BITS: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        CONTROL_SIGNALS: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
    End Component;

    Component RegisterFile
    PORT (
        clk, rst : IN STD_LOGIC;
        addr_read1, addr_read2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- 8 registers -> 3 bits 
        data_read1, data_read2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- Registers are 32 bits wide
        en_write1, en_write2 : IN STD_LOGIC;
        addr_write1, addr_write2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- 8 registers -> 3 bits
        data_write1, data_write2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) -- Registers are 32 bits wide
    );
    End Component;

    Component sign_extend
    port (
        instruction_in: in std_logic_vector(15 downto 0);
        instruction_out: out std_logic_vector(31 downto 0)
    );
    End Component;

begin

    Controller1: Controller PORT MAP(Instruction(14 downto 12), Instruction(11 downto 9), Controls);
    RegisterFile1: RegisterFile PORT MAP(Clock, Reset, Instruction(8 downto 6), Instruction(5 downto 3), RS1, RS2, RegWrite1, RegWrite2, WB_RegDest1, WB_RegDest2, WB_data1, WB_data2);
    sign_extend1: sign_extend PORT MAP(Instruction, Immediate_value);

End Decode_Arch;