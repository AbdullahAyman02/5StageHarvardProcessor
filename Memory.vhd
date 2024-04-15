Library ieee;
Use ieee.std_logic_1164.all;

Entity Memory is
    Port ( clk : in  STD_LOGIC;
            reset : in  STD_LOGIC;
           RS2 : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_result : in  STD_LOGIC_VECTOR (31 downto 0);
           Flags : in  STD_LOGIC_VECTOR (3 downto 0);
        --    RS1, RS2 : in STD_LOGIC_VECTOR (2 downto 0);
        --    RDest : in STD_LOGIC_VECTOR (2 downto 0);
           Controls : in STD_LOGIC_VECTOR (9 downto 0);
           PC : in STD_LOGIC_VECTOR (31 downto 0);
           -- Int , stack pointer

        Mem_out : out  STD_LOGIC_VECTOR (31 downto 0)
    );
End Memory;

Architecture Memory_arch of Memory is
    Component data_memory is 
    PORT (
        write_enable, read_enable, rst : IN STD_LOGIC;
        address : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
    End Component;

Begin
    Memory1: data_memory PORT MAP (Controls(8), Controls(9), reset, ALU_result(11 downto 0), RS2, Mem_out);
End Memory_arch;