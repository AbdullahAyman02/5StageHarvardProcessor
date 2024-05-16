Library ieee;
USE ieee.std_logic_1164.ALL;

Entity Decode is
    PORT (
            Clock : IN STD_LOGIC;
            Reset : IN STD_LOGIC;
            Instruction : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            Pc : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            Int : IN STD_LOGIC;
            RegWrite1, RegWrite2 : IN STD_LOGIC;
            WB_RegDest1, WB_RegDest2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            WB_data1, WB_data2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            Next_instruction : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            Fetch_rst : IN STD_LOGIC;

            RS1, RS2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            Immediate_value : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            Controls : OUT STD_LOGIC_VECTOR(14 DOWNTO 0);
            ValidRS1, ValidRS2 : OUT STD_LOGIC
        );
End Decode;

Architecture Decode_Arch of Decode is
    Component Controller
    PORT(
            OPCODE: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            FUNCTION_BITS: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            IMMEDIATE: IN STD_LOGIC;
            RESET : IN STD_LOGIC;
            INT : IN STD_LOGIC;
            
            CONTROL_SIGNALS: OUT STD_LOGIC_VECTOR(14 DOWNTO 0);
            ValidRS1, ValidRS2: OUT STD_LOGIC
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
        func : in std_logic_vector(2 downto 0);
        instruction_in: in std_logic_vector(15 downto 0);
        instruction_out: out std_logic_vector(31 downto 0)
    );
    End Component;

begin

    Controller1: Controller PORT MAP(Instruction(14 downto 12), Instruction(11 downto 9), Instruction(15), Fetch_rst, Int, Controls, ValidRS1, ValidRS2);
    RegisterFile1: RegisterFile PORT MAP(Clock, Reset, Instruction(8 downto 6), Instruction(5 downto 3), RS1, RS2, RegWrite1, RegWrite2, WB_RegDest1, WB_RegDest2, WB_data1, WB_data2);
    sign_extend1: sign_extend PORT MAP(Instruction(11 downto 9), Next_instruction, Immediate_value);

End Decode_Arch;