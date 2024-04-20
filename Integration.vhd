LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Integration IS
    PORT (
        clk, rst, int : IN STD_LOGIC;
        Input_Port : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Output_Port : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY Integration;

ARCHITECTURE Integration_arch OF Integration IS
    COMPONENT MyRegister IS
        GENERIC (n : INTEGER := 32);
        PORT (
            clk, rst, en : IN STD_LOGIC;
            d : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT Fetch IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            enable : IN STD_LOGIC;

            Instruction : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            PC_Address_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT Decode IS
        PORT (
            Clock : IN STD_LOGIC;
            Reset : IN STD_LOGIC;
            Instruction : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            Pc : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            Int : IN STD_LOGIC;
            RegWrite1, RegWrite2 : IN STD_LOGIC;
            WB_RegDest1, WB_RegDest2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            WB_data1, WB_data2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            Next_Instruction : IN STD_LOGIC_VECTOR(15 DOWNTO 0);

            RS1, RS2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            Immediate_value : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            Controls : OUT STD_LOGIC_VECTOR(14 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT Execution IS
        PORT (
            RS1_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            RS2_data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            Immediate_value : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            Opcode : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
            Controls : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            mem_data_1, mem_data_2, wb_data_1, wb_data_2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            Input_port : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            Clock : IN STD_LOGIC;
            Reset : IN STD_LOGIC;
            Rti : IN STD_LOGIC;
            Rti_flag : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            Imm : IN STD_LOGIC; -- will be removed after phase 1

            RS2_data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            ALU_result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            Flags : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            Output_port : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT Memory IS
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

            Mem_out : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT WriteBack IS
        PORT (
            mem_out : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            alu_out : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            Controls : IN STD_LOGIC_VECTOR (4 DOWNTO 0);

            RegData1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)

        );
    END COMPONENT;

    -- SIGNAL PC_Address : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- SIGNAL Instruction : STD_LOGIC_VECTOR(15 DOWNTO 0);
    -- SIGNAL INT : STD_LOGIC := '0';

    -- SIGNAL FD_D, FD_Q : STD_LOGIC_VECTOR(48 DOWNTO 0);
    -- SIGNAL DE_D, DE_Q : STD_LOGIC_VECTOR(159 DOWNTO 0);
    -- SIGNAL EM_D, EM_Q : STD_LOGIC_VECTOR(151 DOWNTO 0);
    -- SIGNAL MW_D, MW_Q : STD_LOGIC_VECTOR(108 DOWNTO 0);

    SIGNAL Fetch_Instruction : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL Fetch_PC : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL Fetch_Decode_Reset : STD_LOGIC;
    SIGNAL Fetch_Decode_In : STD_LOGIC_VECTOR(48 DOWNTO 0);
    SIGNAL Fetch_Decode_Out : STD_LOGIC_VECTOR(48 DOWNTO 0) := (OTHERS => '0');
    
    SIGNAL Decode_RS1_Data : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Decode_RS2_Data : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Decode_Immediate_value : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Decode_Controls : STD_LOGIC_VECTOR(14 DOWNTO 0);

    SIGNAL Decode_Execute_In : STD_LOGIC_VECTOR(159 DOWNTO 0);
    SIGNAL Decode_Execute_Out : STD_LOGIC_VECTOR(159 DOWNTO 0);

    SIGNAL Execute_Controls : STD_LOGIC_VECTOR(2 DOWNTO 0);

    SIGNAL Execute_RS2_Data : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Execute_Alu_Result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Execute_Flags : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Execute_Output_Port : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL Execute_Memory_In : STD_LOGIC_VECTOR(151 DOWNTO 0);
    SIGNAL Execute_Memory_Out : STD_LOGIC_VECTOR(151 DOWNTO 0);

    SIGNAL Memory_Mem_Out : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL Memory_WB_In : STD_LOGIC_VECTOR(110 DOWNTO 0);
    SIGNAL Memory_WB_Out : STD_LOGIC_VECTOR(110 DOWNTO 0);

    SIGNAL WB_DATA1_TO_DECODE : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
    Fetch1 : Fetch PORT MAP(clk, rst, '1', Fetch_Instruction, Fetch_PC);
    
    -- FD_D <= INT & PC_Address & Instruction;

    Fetch_Decode_In <= Int & Fetch_PC & Fetch_Instruction;
    Fetch_Decode_Reset <= rst or Fetch_Decode_Out(15);
    
    FETCH_DECODE : MyRegister GENERIC MAP(49) PORT MAP(CLK, Fetch_Decode_Reset, '1', Fetch_Decode_In, Fetch_Decode_Out);

    -- The concatenation of the bits is as follows:
    -- bits 15 to 0 -> Instruction
    -- bits 47 to 16 -> PC
    -- bit 48 -> Interrupt


    Decode1 : Decode PORT MAP(clk, rst, Fetch_Decode_Out(15 DOWNTO 0), Fetch_Decode_Out(47 DOWNTO 16), Fetch_Decode_Out(48), Memory_WB_Out(108), Memory_WB_Out(107), Memory_WB_Out(72 DOWNTO 70), Memory_WB_Out(66 DOWNTO 64), WB_DATA1_TO_DECODE, Memory_WB_Out(31 DOWNTO 0), Fetch_Instruction, Decode_RS1_Data, Decode_RS2_Data, Decode_Immediate_value, Decode_Controls);
    
    -- DE_D <= RS1_DATA & RS2_DATA & RS1 & RS2 & RDEST & Immediate_value & OPCODE & CONTROLS & INT & PC & IMM;

    Decode_Execute_In <= Fetch_Decode_Out(15) & Fetch_Decode_Out(47 DOWNTO 16) & Fetch_Decode_Out(48) & Decode_Controls & Fetch_Decode_Out(14 DOWNto 9) & Decode_Immediate_Value & Fetch_Decode_Out(2 DOWNTO 0) & Fetch_Decode_Out(5 DOWNTO 3) & Fetch_Decode_Out(8 DOWNTO 6) & Decode_RS2_Data & Decode_RS1_Data;  

    DECODE_EXECUTE : MyRegister GENERIC MAP(160) PORT MAP(CLK, RST, '1', Decode_Execute_In, Decode_Execute_Out);

    -- The concatenation of the bits is as follows:
    -- RS1 Data 31-0
    -- RS2 Data 63-32
    -- RS1 66-64
    -- RS2 69-67
    -- RDest 72-70
    -- Immediate_value 104-73
    -- Opcode 110-105
    -- Controls 125-111
    -- Int 126
    -- PC 158-127
    -- Imm 159

    Execute_Controls <= Decode_Execute_Out(125) & Decode_Execute_Out(115 DOWNTO 114);
    
    Execution1 : Execution PORT MAP(Decode_Execute_Out(31 DOWNTO 0), Decode_Execute_Out(63 DOWNTO 32), Decode_Execute_Out(104 DOWNTO 73), Decode_Execute_Out(110 DOWNTO 105), Execute_Controls , Execute_Memory_Out(63 DOWNTO 32), Execute_Memory_Out(31 DOWNTO 0), Memory_WB_Out(63 DOWNTO 32), Memory_WB_Out(31 DOWNTO 0), Input_Port, clk, rst, Memory_WB_Out(105), Memory_WB_Out(76 DOWNTO 73), Decode_Execute_Out(159), Execute_RS2_Data, Execute_Alu_Result, Execute_Flags, Execute_Output_Port);
    
    -- EM_D <= RS2_DATA & ALU_RESULT & FLAGS & RS1 & RS2 & RDEST & CONTROLS & PC & INT & SP;

    Execute_Memory_In <= x"00000000" & Decode_Execute_Out(126) & Decode_Execute_Out(158 DOWNTO 127) & Decode_Execute_Out(124 DOWNTO 118) & Decode_Execute_Out(113 DOWNTO 111) & Decode_Execute_Out(72 DOWNTO 70) & Decode_Execute_Out(69 DOWNTO 67) & Decode_Execute_Out(66 DOWNTO 64) & Execute_Flags & Execute_Alu_Result & Execute_RS2_Data;

    EXECUTE_MEMORY : MyRegister GENERIC MAP(152) PORT MAP(CLK, RST, '1', Execute_Memory_In, Execute_Memory_Out);

    -- The concatenation of the bits is as follows:
    -- RS2 Data 31-0
    -- ALU Result 63-32
    -- Flags 67-64
    -- RS1 70-68
    -- RS2 73-71
    -- RDest 76-74
    -- Controls 86-77
    -- PC 118-87
    -- Int 119
    -- SP 151-120


    Memory1 : Memory PORT MAP(clk, rst, Execute_Memory_Out(31 DOWNTO 0), Execute_Memory_Out(63 DOWNTO 32), Execute_Memory_Out(67 DOWNTO 64), Execute_Memory_Out(86 DOWNTO 77), Execute_Memory_Out(118 DOWNTO 87), Memory_Mem_Out);

    Memory_WB_In <= '0' & Execute_Memory_Out(86) & Execute_Memory_Out(81 DOWNTO 80) & Execute_Memory_Out(78 DOWNTO 77) & Memory_Mem_Out & Execute_Memory_Out(76 DOWNTO 74) & Execute_Memory_Out(73 DOWNTO 71) & Execute_Memory_Out(70 DOWNTO 68) & Execute_Memory_Out(63 DOWNTO 32) & Execute_Memory_Out(31 DOWNTO 0);
    
    MEMORY_WRITEBACK : MyRegister GENERIC MAP(111) PORT MAP(CLK, RST, '1', Memory_WB_In, Memory_WB_Out);

    -- The concatenation of the bits is as follows:
    -- RS2 Data 31-0
    -- ALU Result 63-32
    -- RS1 66-64
    -- RS2 69-67
    -- RDest 72-70
    -- Mem out 104-73
    -- Controls 108-105


    -- Output of this register - not handled yet.
    WriteBack1 : WriteBack PORT MAP(Memory_WB_Out(104 DOWNTO 73), Memory_WB_Out(63 DOWNTO 32), Memory_WB_Out(109 DOWNTO 105), WB_DATA1_TO_DECODE);
END ARCHITECTURE Integration_arch;