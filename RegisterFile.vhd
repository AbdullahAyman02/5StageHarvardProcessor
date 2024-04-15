LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY RegisterFile IS
    PORT (
        clk, rst : IN STD_LOGIC;
        addr_read1, addr_read2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- 8 registers -> 3 bits 
        data_read1, data_read2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- Registers are 32 bits wide
        en_write1, en_write2 : IN STD_LOGIC;
        addr_write1, addr_write2 : IN STD_LOGIC_VECTOR(2 DOWNTO 0); -- 8 registers -> 3 bits
        data_write1, data_write2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0) -- Registers are 32 bits wide
    );
END ENTITY RegisterFile;

ARCHITECTURE struct_RegisterFile OF RegisterFile IS
    COMPONENT MyRegister IS
        GENERIC (n : INTEGER := 32);
        PORT (
            clk, rst, en : IN STD_LOGIC;
            d : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            q : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
        );
    END COMPONENT MyRegister;

    COMPONENT Mux8 IS
        GENERIC (n : INTEGER := 32);
        PORT (
            selectors : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            input1, input2, input3, input4, input5, input6, input7, input8 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
            output : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
        );
    END COMPONENT Mux8;

    SIGNAL en_write : STD_LOGIC_VECTOR(7 DOWNTO 0); -- 8 registers -> 8 enables
    SIGNAL input1, input2, input3, input4, input5, input6, input7, input8 : STD_LOGIC_VECTOR(31 DOWNTO 0) := (31 DOWNTO 0 => '0'); -- 8 registers -> 8 inputs
    SIGNAL output1, output2, output3, output4, output5, output6, output7, output8 : STD_LOGIC_VECTOR(31 DOWNTO 0); -- 8 registers -> 8 outputs
    SIGNAL clk_flipped : STD_LOGIC;
BEGIN
    -- Delwa2ty, el pipeline registers el values hatetketeb feehom fel rising edge
    -- Fa ana ka register file, 3awez a5od el data mehom fel falling edge
    -- Fa 34an keda ha3mel not lel clk
    -- W ba3d keda fel falling edge hasarraf el data fel register file (akenny ba write)
    -- be 7eis en el data ely 3ayez a2raha men el register file teb2a gahza 3ala el rising lel pipeline register
    clk_flipped <= not clk;
    Register1 : MyRegister GENERIC MAP(32) PORT MAP(clk_flipped, rst, en_write(0), input1, output1);
    Register2 : MyRegister GENERIC MAP(32) PORT MAP(clk_flipped, rst, en_write(1), input2, output2);
    Register3 : MyRegister GENERIC MAP(32) PORT MAP(clk_flipped, rst, en_write(2), input3, output3);
    Register4 : MyRegister GENERIC MAP(32) PORT MAP(clk_flipped, rst, en_write(3), input4, output4);
    Register5 : MyRegister GENERIC MAP(32) PORT MAP(clk_flipped, rst, en_write(4), input5, output5);
    Register6 : MyRegister GENERIC MAP(32) PORT MAP(clk_flipped, rst, en_write(5), input6, output6);
    Register7 : MyRegister GENERIC MAP(32) PORT MAP(clk_flipped, rst, en_write(6), input7, output7);
    Register8 : MyRegister GENERIC MAP(32) PORT MAP(clk_flipped, rst, en_write(7), input8, output8);

    Mux_Read1 : Mux8 GENERIC MAP(32) PORT MAP(addr_read1, output1, output2, output3, output4, output5, output6, output7, output8, data_read1);
    Mux_Read2 : Mux8 GENERIC MAP(32) PORT MAP(addr_read2, output1, output2, output3, output4, output5, output6, output7, output8, data_read2);

    loop_registers : FOR i IN 0 TO 7 GENERATE
        en_write(i) <= '1' WHEN (((to_integer(unsigned(addr_write1)) = i) AND en_write1 = '1') OR ((to_integer(unsigned(addr_write2)) = i) AND en_write2 = '1')) ELSE
        '0';
    END GENERATE;
    input1 <= data_write1 WHEN (addr_write1 = "000" AND en_write1 = '1') ELSE
        data_write2 WHEN (addr_write2 = "000" AND en_write2 = '1') ELSE
        input1;
    input2 <= data_write1 WHEN (addr_write1 = "001" AND en_write1 = '1') ELSE
        data_write2 WHEN (addr_write2 = "001" AND en_write2 = '1') ELSE
        input2;
    input3 <= data_write1 WHEN (addr_write1 = "010" AND en_write1 = '1') ELSE
        data_write2 WHEN (addr_write2 = "010" AND en_write2 = '1') ELSE
        input3;
    input4 <= data_write1 WHEN (addr_write1 = "011" AND en_write1 = '1') ELSE
        data_write2 WHEN (addr_write2 = "011" AND en_write2 = '1') ELSE
        input4;
    input5 <= data_write1 WHEN (addr_write1 = "100" AND en_write1 = '1') ELSE
        data_write2 WHEN (addr_write2 = "100" AND en_write2 = '1') ELSE
        input5;
    input6 <= data_write1 WHEN (addr_write1 = "101" AND en_write1 = '1') ELSE
        data_write2 WHEN (addr_write2 = "101" AND en_write2 = '1') ELSE
        input6;
    input7 <= data_write1 WHEN (addr_write1 = "110" AND en_write1 = '1') ELSE
        data_write2 WHEN (addr_write2 = "110" AND en_write2 = '1') ELSE
        input7;
    input8 <= data_write1 WHEN (addr_write1 = "111" AND en_write1 = '1') ELSE
        data_write2 WHEN (addr_write2 = "111" AND en_write2 = '1') ELSE
        input8;

END ARCHITECTURE struct_RegisterFile;