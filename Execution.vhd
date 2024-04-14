Library ieee;
Use ieee.std_logic_1164.all;

Entity Execution is
    Port (  
        RS1_data : in std_logic_vector(31 downto 0);
        RS2_data : in std_logic_vector(31 downto 0);
        Immediate_value : in std_logic_vector(31 downto 0);
        Opcode : in std_logic_vector(5 downto 0);
        Controls : in std_logic_vector(2 downto 0);
        mem_data_1, mem_data_2, wb_data_1, wb_data_2 : in std_logic_vector(31 downto 0);
        Input_port : in std_logic_vector(31 downto 0);
        Clock : in std_logic;
        Reset : in std_logic;
        Rti : in std_logic;
        Rti_flag : in std_logic_vector(3 downto 0);
        Imm : in std_logic; -- will be removed after phase 1

        RS2_data_out : out std_logic_vector(31 downto 0);
        ALU_result : out std_logic_vector(31 downto 0);
        Flags: out std_logic_vector(3 downto 0);
        Output_port : out std_logic_vector(31 downto 0)
    );
End Execution;

Architecture execution_arch of Execution is 
    COMPONENT ALU IS
    Port (
        A, B : in std_logic_vector(31 downto 0);
        opcode, func : in std_logic_vector(2 downto 0);
        flags_in : in std_logic_vector(3 downto 0);
        alu_operation: in std_logic;
        result : out std_logic_vector(31 downto 0);
        flags_out : out std_logic_vector(3 downto 0)
        -- 3: overflow, 2: carry, 1: negative, 0: zero
    );
    END COMPONENT;

    COMPONENT FlagRegister IS
    Port (clk, reset, rti: in std_logic;
          alu_flag_in, rti_flag_in: in std_logic_vector(3 downto 0);
          flag_out: out std_logic_vector(3 downto 0)
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

    COMPONENT Mux8 IS
    GENERIC (n : INTEGER := 32);
    PORT (
		selectors : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		input1, input2, input3, input4, input5, input6, input7, input8 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		output : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
	);
    END COMPONENT;

    signal operand1_out, operand2_out, store_swap_out, alu_out_result, alu_or_input: std_logic_vector(31 downto 0); 
    signal alu_flags, flag_register_flags : std_logic_vector(3 downto 0);
    signal temp_selector : std_logic_vector(2 downto 0); -- should be removed after phase 1

begin

temp_selector <= "00" & Imm; -- should be removed after phase 1

Mux8_1: Mux8 generic map(32) port map ("000", RS1_data, mem_data_1, mem_data_2, wb_data_1, wb_data_2, x"00000000", x"00000000", x"00000000", operand1_out);
Mux8_2: Mux8 generic map(32) port map (temp_selector, RS2_data, Immediate_value, mem_data_1, mem_data_2, wb_data_1, wb_data_2, x"00000000", x"00000000", operand2_out);
Mux8_3: Mux8 generic map(32) port map ("000", RS2_data, mem_data_1, mem_data_2, wb_data_1, wb_data_2, x"00000000", x"00000000", x"00000000", store_swap_out);

Mux2_1: Mux2 generic map(32) port map (Controls(1), alu_out_result, Input_port, alu_or_input);

FlagRegister_1: FlagRegister port map (Clock, Reset, Rti, alu_flags, Rti_flag, flag_register_flags);

ALU_1: ALU port map (operand1_out, operand2_out, Opcode(5 downto 3), Opcode(2 downto 0), flag_register_flags, Controls(2), alu_out_result, alu_flags);

RS2_data_out <= store_swap_out;
ALU_result <= alu_or_input;
Flags <= alu_flags;
Output_port <= operand1_out when Controls(0) = '1';

End execution_arch;