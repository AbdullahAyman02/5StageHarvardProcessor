Library ieee;
use ieee.std_logic_1164.all;

ENTITY CONTROLLER_TB IS
END ENTITY;

ARCHITECTURE CONTROLLER_TB_ARCH OF CONTROLLER_TB IS

COMPONENT CONTROLLER IS
    PORT(
            OPCODE: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            FUNCTION_BITS: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            
            CONTROL_SIGNALS: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );         
END COMPONENT;

SIGNAL OPCODE: STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL FUNCTION_BITS: STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL CONTROL_SIGNALS: STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN
    UUT_CONTROLLER: CONTROLLER PORT MAP(
        OPCODE => OPCODE,
        FUNCTION_BITS => FUNCTION_BITS,
        CONTROL_SIGNALS => CONTROL_SIGNALS
    );

    PROCESS BEGIN
        -- GROUP 0
        OPCODE <= "000";
        
        FUNCTION_BITS <= "000";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "0000000000000000" REPORT "NOP TEST FAILED" SEVERITY ERROR;

        -- GROUP 1
        OPCODE <= "001";

        FUNCTION_BITS <= "000";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "1000001000000000" REPORT "ADD & ADDI TEST FAILED" SEVERITY ERROR;

        FUNCTION_BITS <= "001";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "1000001000000000" REPORT "SUB & SUBI TEST FAILED" SEVERITY ERROR;

        FUNCTION_BITS <= "010";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "1000000000000000" REPORT "CMP TEST FAILED" SEVERITY ERROR;

        FUNCTION_BITS <= "011";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "1000001000000000" REPORT "AND TEST FAILED" SEVERITY ERROR;

        FUNCTION_BITS <= "100";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "1000001000000000" REPORT "OR TEST FAILED" SEVERITY ERROR;

        FUNCTION_BITS <= "101";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "1000001000000000" REPORT "XOR TEST FAILED" SEVERITY ERROR;

        FUNCTION_BITS <= "110";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "1000001100000000" REPORT "SWAP TEST FAILED" SEVERITY ERROR;

        FUNCTION_BITS <= "111";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "1000001000000000" REPORT "MOV & LDM TEST FAILED" SEVERITY ERROR;

        -- GROUP 2
        OPCODE <= "010";
        
        FUNCTION_BITS <= "000";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "1000001000000000" REPORT "NOT TEST FAILED" SEVERITY ERROR;

        FUNCTION_BITS <= "001";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "1000001000000000" REPORT "NEG TEST FAILED" SEVERITY ERROR;

        FUNCTION_BITS <= "010";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "1000001000000000" REPORT "INC TEST FAILED" SEVERITY ERROR;

        FUNCTION_BITS <= "011";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "1000001000000000" REPORT "DEC TEST FAILED" SEVERITY ERROR;

        -- GROUP 3
        OPCODE <= "011";
    
        FUNCTION_BITS <= "000";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "0000000000001000" REPORT "OUT TEST FAILED" SEVERITY ERROR;

        FUNCTION_BITS <= "001";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "0000001000010000" REPORT "IN TEST FAILED" SEVERITY ERROR;

        -- GROUP 4
        OPCODE <= "100";
        
        FUNCTION_BITS <= "000";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "0100001010000000" REPORT "LDD TEST FAILED" SEVERITY ERROR;

        FUNCTION_BITS <= "010";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "0010000000000000" REPORT "STD TEST FAILED" SEVERITY ERROR;

        FUNCTION_BITS <= "100";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "0100001010000100" REPORT "POP TEST FAILED" SEVERITY ERROR;

        FUNCTION_BITS <= "110";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "0010000000000100" REPORT "PUSH TEST FAILED" SEVERITY ERROR;

        -- GROUP 5
        OPCODE <= "101";
        
        FUNCTION_BITS <= "000";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "0000100000000000" REPORT "PROTECT TEST FAILED" SEVERITY ERROR;

        FUNCTION_BITS <= "001";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "0000010000000000" REPORT "FREE TEST FAILED" SEVERITY ERROR;

        -- GROUP 6
        OPCODE <= "110";
            
        FUNCTION_BITS <= "000";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "0011000001100100" REPORT "CALL TEST FAILED" SEVERITY ERROR;

        FUNCTION_BITS <= "100";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "0100000001100110" REPORT "RET TEST FAILED" SEVERITY ERROR;

        FUNCTION_BITS <= "101";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "0100000001100111" REPORT "RETI TEST FAILED" SEVERITY ERROR;
    
        -- GROUP 7
        OPCODE <= "111";
        
        FUNCTION_BITS <= "000";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "0000000001000000" REPORT "JZ TEST FAILED" SEVERITY ERROR;

        FUNCTION_BITS <= "001";
        WAIT FOR 10 ns;
        ASSERT CONTROL_SIGNALS = "0000000001100000" REPORT "JMP TEST FAILED" SEVERITY ERROR;

        WAIT;
        
    END PROCESS;
END CONTROLLER_TB_ARCH;