Library ieee;
Use ieee.std_logic_1164.all;

Entity ALU is 
    Port (
        A, B : in std_logic_vector(31 downto 0);
        opcode, func : in std_logic_vector(2 downto 0);
        flags_in : in std_logic_vector(3 downto 0);
        alu_operation: in std_logic;
        result : out std_logic_vector(31 downto 0);
        flags_out : out std_logic_vector(3 downto 0)
        -- 3: overflow, 2: carry, 1: negative, 0: zero
    );
End ALU;

Architecture ALU_Arch of ALU is
    COMPONENT my_nadder is
        generic (n : integer := 32);
		PORT (
        a, b : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        cin : IN STD_LOGIC;
        s : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        cout, overflow : OUT STD_LOGIC);
	END COMPONENT;
    signal B_bar, first_input, second_input, adder_result, alu_result: std_logic_vector (31 DOWNTO 0);
	signal alu_and, alu_or, alu_xor, alu_not: std_logic_vector (31 DOWNTO 0);
    signal Cin_input, Cout, no_flag_change, negative_flag, zero_flag, overflow_flag, carry_overflow_change: std_logic;
begin
    U1: my_nadder generic map(32) port map (first_input, second_input, Cin_input, adder_result, Cout, overflow_flag);
    B_bar <= not B;

    alu_and <= A and B;
    alu_or <= A or B;
    alu_xor <= A xor B;
    alu_not <= not A;

    first_input <=  x"00000000" when opcode = "010" and func = "010"
                    else A;

    second_input <= x"00000001" when opcode = "010" and func = "000"
                    else x"fffffffe" when opcode = "010" and func = "001"
                    else alu_not when opcode = "010" and func = "010"
                    else B when opcode = "100"
                    else B_bar when func = "001" or func = "010"
                    else B;

    Cin_input <= '1' when (func = "001" or func = "010") and opcode /= "100"
                else '0';

    alu_result <= A when (opcode = "001" and func = "110") or opcode = "101"
                else adder_result when opcode = "100" or func = "000" or func = "001" or func = "010"
                else alu_and when opcode = "001" and func = "011"
                else alu_not when opcode = "010" and func = "011"
                else alu_or when func = "100"
                else alu_xor when func = "101"
                else B;

    result <= alu_result;

    no_flag_change <= (func(2) and func(1)) or (not alu_operation);

    -- with alu_result(31) select
    --     negative_flag <= '1' when '1',
    --                     '0' when others;
    negative_flag <= alu_result(31);

    with alu_result select
        zero_flag <= '1' when x"00000000",
                        '0' when others;

    zero_flag <=    '1' when alu_result = x"00000000" else
                    '0' when opcode = "111" and func = "000" else
                    '0';

    flags_out(0) <= zero_flag when no_flag_change = '0' or (opcode = "111" and func = "000")
                    else flags_in(0);

    with no_flag_change select
        flags_out(1) <= flags_in(1) when '1',
                                negative_flag when others;

    -- carry_overflow_change <= '1' when (not no_flag_change) and (func = "000" or func = "001")
    --                         else '0';

    carry_overflow_change <= (not func(2) and not func(1)) and (not no_flag_change);
    
    with carry_overflow_change select
        flags_out(3 downto 2) <= overflow_flag & Cout when '1',
                                flags_in(3 downto 2) when others;

END ALU_Arch;