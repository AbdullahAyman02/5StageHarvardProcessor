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
            int : IN STD_LOGIC;
            ret_rti : IN STD_LOGIC;
            ret_rti_m : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            address_selector : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            decode_address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            execute_address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            correction_address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            branch : IN STD_LOGIC;

            Instruction : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            PC_Address_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            pc_to_store : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
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
            Fetch_rst : IN STD_LOGIC;

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

            RS1_data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
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
            INT : IN STD_LOGIC;
            StackPointer : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            INT_FSM : IN STD_LOGIC;

            Exception : OUT STD_LOGIC;
            Mem_out : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
        );
    END COMPONENT;
    COMPONENT WriteBack IS
        PORT (
            mem_out : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            alu_out : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
            Controls : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
            Int_Fsm : IN STD_LOGIC;

            RegData1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
            Rti : OUT STD_LOGIC;
            Ret_rti : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT SP IS
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
    END COMPONENT;

    COMPONENT InterruptFSM IS
        PORT (
            clk : IN STD_LOGIC;
            int : IN STD_LOGIC;
            rti : IN STD_LOGIC;
            stall : OUT STD_LOGIC;
            flagsOrPC : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT RetRtiCounter IS
        PORT (
            clk : IN STD_LOGIC;
            rst : IN STD_LOGIC;
            ret_rti : IN STD_LOGIC;
            enable : IN STD_LOGIC;
            stall : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT myBranchingController IS
        PORT (
            a_branch_instruction_is_in_decode : IN STD_LOGIC; -- 1 if a branch instruction is in decode stage, 0 otherwise
            a_branch_instruction_is_in_execute : IN STD_LOGIC; -- 1 if a branch instruction is in execute stage, 0 otherwise
            decode_branch_unconditional : IN STD_LOGIC; -- 1 if the instruction in decode stage is a conditional branch, 0 otherwise
            execute_branch_unconditional : IN STD_LOGIC; -- 1 if the instruction in execute stage is a conditional branch, 0 otherwise
            branched_in_decode : IN STD_LOGIC; -- 1 if i already have branched in decode stage, 0 otherwise
            can_branch : IN STD_LOGIC; -- 1 if the branch can be taken in decode stage, 0 otherwise
            zero_flag : IN STD_LOGIC; -- 1 if the zero flag is set after execute stage, 0 otherwise
            prediction_out : OUT STD_LOGIC; -- 1 bit prediction of the branch instruction in decode stage, can be 0 or 1 and it toggles
            two_bit_PC_selector : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- 2 bit selector for the PC, 00 for decode branch update, 01 for execute branch update, 10 for register address, 11 for normal PC update +2
            will_branch_in_decode : OUT STD_LOGIC; -- 1 if the branch will be taken in decode stage, 0 otherwise
            branch_out : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT InterruptLatch IS
        PORT (
            CLK : IN STD_LOGIC;
            Reset : IN STD_LOGIC;
            Interrupt : IN STD_LOGIC;
            Stall : IN STD_LOGIC;
            From_ret_rti_counter : IN STD_LOGIC;
            Immediate_bit_from_fetch : IN STD_LOGIC;
            Branch : IN STD_LOGIC;
            -- Branched_from_decode : IN STD_LOGIC;
            -- Reset_previous_latch : OUT STD_LOGIC;
            Latched_interrupt : OUT STD_LOGIC
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
    SIGNAL PC_To_Store : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL Fetch_Decode_Reset : STD_LOGIC;
    SIGNAL Fetch_Decode_In : STD_LOGIC_VECTOR(49 DOWNTO 0);
    SIGNAL Fetch_Decode_Out : STD_LOGIC_VECTOR(49 DOWNTO 0) := (OTHERS => '0');

    SIGNAL Decode_RS1_Data : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Decode_RS2_Data : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Decode_Immediate_value : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Decode_Controls : STD_LOGIC_VECTOR(14 DOWNTO 0);

    SIGNAL Decode_Execute_Reset : STD_LOGIC;
    SIGNAL Decode_Execute_In : STD_LOGIC_VECTOR(160 DOWNTO 0);
    SIGNAL Decode_Execute_Out : STD_LOGIC_VECTOR(160 DOWNTO 0);

    SIGNAL Execute_Controls : STD_LOGIC_VECTOR(2 DOWNTO 0);

    SIGNAL Execute_RS1_Data : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Execute_RS2_Data : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Execute_Alu_Result : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Execute_Flags : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Execute_Output_Port : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL Execute_Memory_In : STD_LOGIC_VECTOR(148 DOWNTO 0);
    SIGNAL Execute_Memory_Out : STD_LOGIC_VECTOR(148 DOWNTO 0);

    SIGNAL Exception : STD_LOGIC := '0';
    SIGNAL Memory_Mem_Out : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL Memory_WB_In : STD_LOGIC_VECTOR(107 DOWNTO 0);
    SIGNAL Memory_WB_Out : STD_LOGIC_VECTOR(107 DOWNTO 0);

    SIGNAL WB_DATA1_TO_DECODE : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL WB_Rti : STD_LOGIC;
    SIGNAL WB_Ret_rti : STD_LOGIC;

    SIGNAL StackPointer : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL IntrerruptFSM_Stall : STD_LOGIC;
    SIGNAL IntrerruptFSM_FlagsOrPC : STD_LOGIC;

    SIGNAL RetRtiCounterStall : STD_LOGIC := '0';

    SIGNAL PC_Enable : STD_LOGIC := '1';
    SIGNAL Fetch_Decode_Enable : STD_LOGIC := '1';
    SIGNAL Decode_Execute_Enable : STD_LOGIC := '1';

    SIGNAL BranchedInDecode : STD_LOGIC;
    SIGNAL PredictionOut : STD_LOGIC;
    SIGNAL TwoBitPCSelector : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL BranchOut : STD_LOGIC;

    SIGNAL LatchedInterrupt : STD_LOGIC := '0';

BEGIN
    PC_Enable <= NOT (IntrerruptFSM_Stall);

    -- Fetch1 : Fetch PORT MAP(clk, rst, PC_Enable, int, WB_Ret_rti, WB_DATA1_TO_DECODE, TwoBitPCSelector, Decode_RS1_Data, Execute_RS1_Data, x"00000000", BranchOut, Fetch_Instruction, Fetch_PC, PC_To_Store);
    Fetch1 : Fetch PORT MAP(clk, rst, PC_Enable, LatchedInterrupt, WB_Ret_rti, WB_DATA1_TO_DECODE, TwoBitPCSelector, Decode_RS1_Data, Execute_RS1_Data, x"00000000", BranchOut, Fetch_Instruction, Fetch_PC, PC_To_Store);

    RetRtiCounter1 : RetRtiCounter PORT MAP(clk, rst, Decode_Controls(1), '1', RetRtiCounterStall);

    InterruptLatch1 : InterruptLatch PORT MAP(
        clk => clk,
        Reset => rst,
        Interrupt => int,
        Stall => IntrerruptFSM_Stall,
        From_ret_rti_counter => RetRtiCounterStall,
        Immediate_bit_from_fetch => Fetch_Decode_Out(15),
        Branch => BranchOut,
        -- Branched_from_decode => BranchedInDecode,
        -- Reset_previous_latch => open,
        Latched_interrupt => LatchedInterrupt
    );

    -- FD_D <= INT & PC_Address & Instruction;

    -- Fetch_Decode_In <= rst & Int & PC_To_Store & Fetch_Instruction;
    Fetch_Decode_In <= rst & LatchedInterrupt & PC_To_Store & Fetch_Instruction;
    Fetch_Decode_Reset <= Fetch_Decode_Out(49) OR Fetch_Decode_Out(15) OR RetRtiCounterStall OR BranchOut;
    Fetch_Decode_Enable <= NOT (IntrerruptFSM_Stall);

    FETCH_DECODE : MyRegister GENERIC MAP(50) PORT MAP(CLK, Fetch_Decode_Reset, Fetch_Decode_Enable, Fetch_Decode_In, Fetch_Decode_Out);

    -- The concatenation of the bits is as follows:
    -- bits 15 to 0 -> Instruction
    -- bits 47 to 16 -> PC
    -- bit 48 -> Interrupt
    -- bits 49 -> Rst
    Decode1 : Decode PORT MAP(clk, rst, Fetch_Decode_Out(15 DOWNTO 0), Fetch_Decode_Out(47 DOWNTO 16), Fetch_Decode_Out(48), Memory_WB_Out(105), Memory_WB_Out(104), Memory_WB_Out(69 DOWNTO 67), Memory_WB_Out(66 DOWNTO 64), WB_DATA1_TO_DECODE, Memory_WB_Out(31 DOWNTO 0), Fetch_Instruction, Fetch_Decode_Out(49), Decode_RS1_Data, Decode_RS2_Data, Decode_Immediate_value, Decode_Controls);

    BranchingController1 : myBranchingController PORT MAP(Decode_Controls(6), Decode_Execute_Out(117), Decode_Controls(5), Decode_Execute_Out(116), Decode_Execute_Out(160), '1', Execute_Flags(0), PredictionOut, TwoBitPCSelector, BranchedInDecode, BranchOut);

    -- DE_D <= RS1_DATA & RS2_DATA & RS1 & RS2 & RDEST & Immediate_value & OPCODE & CONTROLS & INT & PC & IMM;

    Decode_Execute_In <= BranchedInDecode & Fetch_Decode_Out(15) & Fetch_Decode_Out(47 DOWNTO 16) & Fetch_Decode_Out(48) & Decode_Controls & Fetch_Decode_Out(14 DOWNTO 9) & Decode_Immediate_Value & Fetch_Decode_Out(2 DOWNTO 0) & Fetch_Decode_Out(5 DOWNTO 3) & Fetch_Decode_Out(8 DOWNTO 6) & Decode_RS2_Data & Decode_RS1_Data;
    Decode_Execute_Reset <= RST OR (BranchOut AND Decode_Execute_Out(117));
    Decode_Execute_Enable <= NOT (IntrerruptFSM_Stall);

    DECODE_EXECUTE : MyRegister GENERIC MAP(161) PORT MAP(CLK, Decode_Execute_Reset, Decode_Execute_Enable, Decode_Execute_In, Decode_Execute_Out);

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
    -- Branched in decode 160

    Execute_Controls <= Decode_Execute_Out(125) & Decode_Execute_Out(115 DOWNTO 114);

    Execution1 : Execution PORT MAP(Decode_Execute_Out(31 DOWNTO 0), Decode_Execute_Out(63 DOWNTO 32), Decode_Execute_Out(104 DOWNTO 73), Decode_Execute_Out(110 DOWNTO 105), Execute_Controls, Execute_Memory_Out(63 DOWNTO 32), Execute_Memory_Out(31 DOWNTO 0), Memory_WB_Out(63 DOWNTO 32), Memory_WB_Out(31 DOWNTO 0), Input_Port, clk, rst, Memory_WB_Out(102), Memory_WB_Out(73 DOWNTO 70), Decode_Execute_Out(159), Execute_RS1_Data, Execute_RS2_Data, Execute_Alu_Result, Execute_Flags, Execute_Output_Port);

    -- EM_D <= RS2_DATA & ALU_RESULT & FLAGS & RS1 & RS2 & RDEST & CONTROLS & PC & INT & SP;

    StackPointerCircuit : SP PORT MAP(clk, rst, Decode_Execute_Out(107 DOWNTO 105), Decode_Execute_Out(126), Decode_Execute_Out(124), '0', Decode_Execute_Out(113), StackPointer);

    InterruptFSM1 : InterruptFSM PORT MAP(clk, Decode_Execute_Out(126), Decode_Execute_Out(111), IntrerruptFSM_Stall, IntrerruptFSM_FlagsOrPC);

    Execute_Memory_In <= StackPointer & Decode_Execute_Out(126) & Decode_Execute_Out(158 DOWNTO 127) & Decode_Execute_Out(124 DOWNTO 118) & Decode_Execute_Out(113 DOWNTO 111) & Decode_Execute_Out(72 DOWNTO 70) & Decode_Execute_Out(66 DOWNTO 64) & Execute_Flags & Execute_Alu_Result & Execute_RS2_Data;

    EXECUTE_MEMORY : MyRegister GENERIC MAP(149) PORT MAP(CLK, RST, '1', Execute_Memory_In, Execute_Memory_Out);

    -- The concatenation of the bits is as follows:
    -- RS2 Data 31-0
    -- ALU Result 63-32
    -- Flags 67-64
    -- RS1 70-68
    -- RDest 73-71
    -- Controls 83-74
    -- PC 115-84
    -- Int 116
    -- SP 148-117
    Memory1 : Memory PORT MAP(clk, rst, Execute_Memory_Out(31 DOWNTO 0), Execute_Memory_Out(63 DOWNTO 32), Execute_Memory_Out(67 DOWNTO 64), Execute_Memory_Out(83 DOWNTO 74), Execute_Memory_Out(115 DOWNTO 84), Execute_Memory_Out(116), Execute_Memory_Out(148 DOWNTO 117), IntrerruptFSM_FlagsOrPC, Exception, Memory_Mem_Out);

    Memory_WB_In <= IntrerruptFSM_FlagsOrPC & Execute_Memory_Out(83) & Execute_Memory_Out(78 DOWNTO 77) & Execute_Memory_Out(75 DOWNTO 74) & Memory_Mem_Out & Execute_Memory_Out(73 DOWNTO 71) & Execute_Memory_Out(70 DOWNTO 68) & Execute_Memory_Out(63 DOWNTO 32) & Execute_Memory_Out(31 DOWNTO 0);

    MEMORY_WRITEBACK : MyRegister GENERIC MAP(108) PORT MAP(CLK, RST, '1', Memory_WB_In, Memory_WB_Out);

    -- The concatenation of the bits is as follows:
    -- RS2 Data 31-0
    -- ALU Result 63-32
    -- RS1 66-64
    -- RDest 69-67
    -- Mem out 101-70
    -- Controls 106-102
    -- Int FSM 107
    -- Output of this register - not handled yet.
    WriteBack1 : WriteBack PORT MAP(Memory_WB_Out(101 DOWNTO 70), Memory_WB_Out(63 DOWNTO 32), Memory_WB_Out(106 DOWNTO 102), Memory_WB_Out(107), WB_DATA1_TO_DECODE, WB_Rti, WB_Ret_rti);
END ARCHITECTURE Integration_arch;