LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY myBranchingController IS
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
        branch_out: OUT STD_LOGIC
    );
END myBranchingController;

-- remaining: line 49 vs 123 should it be execute branch update or wrong prediction
           -- line 93 in other file, there is a decode case inside the branched_in_decode condition, why?, it is written that its for interrupts

ARCHITECTURE branching_controller_arch OF myBranchingController IS
    SIGNAL prediction_bit : STD_LOGIC := '0';
    SIGNAL will_branch_in_execute : STD_LOGIC := '0';
    SIGNAL PC_selector : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
BEGIN
    PROCESS (a_branch_instruction_is_in_decode, a_branch_instruction_is_in_execute, decode_branch_unconditional, execute_branch_unconditional, can_branch, zero_flag, branched_in_decode)
    BEGIN
        IF (branched_in_decode = '1') THEN
            IF (a_branch_instruction_is_in_execute = '1') THEN
                IF (execute_branch_unconditional = '0') THEN
                    IF (prediction_bit /= zero_flag) THEN
                        will_branch_in_execute <= '1';
                        PC_selector <= "10";
                    ELSE
                        prediction_bit <= '0';
                        will_branch_in_execute <= '0';
                        PC_selector <= "11";
                    END IF;
                ELSE
                    will_branch_in_execute <= '0';
                    PC_selector <= "11";
                END IF;
            END IF;
        ELSE
            IF (a_branch_instruction_is_in_execute = '1') THEN
                IF (execute_branch_unconditional = '0') THEN
                    IF (zero_flag = '1') THEN
                        prediction_bit <= '1';
                        will_branch_in_execute <= '1';
                        PC_selector <= "10";  --should this be 01 = execute branch update or 10 = wrong prediction
                    ELSE
                        will_branch_in_execute <= '0';
                        PC_selector <= "11";
                    END IF;
                ELSE
                    will_branch_in_execute <= '1';
                    PC_selector <= "01";
                END IF;
            ELSE
                will_branch_in_execute <= '0';
            END IF;

            IF (a_branch_instruction_is_in_decode = '1' AND will_branch_in_execute = '0') THEN
                IF (decode_branch_unconditional = '0') THEN
                    IF (prediction_bit = '1' AND can_branch = '1') THEN
                        will_branch_in_decode <= '1';
                        PC_selector <= "00";
                    ELSE
                        will_branch_in_decode <= '0';
                        PC_selector <= "11";
                    END IF;
                ELSE
                    IF (can_branch = '1') THEN
                        will_branch_in_decode <= '1';
                        PC_selector <= "00";
                    ELSE
                        will_branch_in_decode <= '0';
                    END IF;
                END IF;
            ELSIF will_branch_in_execute = '0' THEN
                PC_selector <= "11";
            END IF;
        END IF;
        prediction_out <= prediction_bit;
    END PROCESS;
    branch_out <= PC_selector(0) NAND PC_selector(1);
    two_bit_PC_selector <= PC_selector;
END branching_controller_arch;