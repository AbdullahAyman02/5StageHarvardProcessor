LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY myBranchingController IS
    PORT (
        clk : IN STD_LOGIC;
        a_branch_instruction_is_in_decode : IN STD_LOGIC; -- 1 if a branch instruction is in decode stage, 0 otherwise
        a_branch_instruction_is_in_execute : IN STD_LOGIC; -- 1 if a branch instruction is in execute stage, 0 otherwise
        decode_branch_unconditional : IN STD_LOGIC; -- 1 if the instruction in decode stage is a conditional branch, 0 otherwise
        execute_branch_unconditional : IN STD_LOGIC; -- 1 if the instruction in execute stage is a conditional branch, 0 otherwise
        branched_in_decode : IN STD_LOGIC; -- 1 if i already have branched in decode stage, 0 otherwise
        can_branch : IN STD_LOGIC; -- 1 if the branch can be taken in decode stage, 0 otherwise
        zero_flag : IN STD_LOGIC; -- 1 if the zero flag is set after execute stage, 0 otherwise
        any_stall : IN STD_LOGIC; -- 1 if there is a stall in the pipeline, 0 otherwise
        prediction_out : OUT STD_LOGIC; -- 1 bit prediction of the branch instruction in decode stage, can be 0 or 1 and it toggles
        two_bit_PC_selector : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- 2 bit selector for the PC, 00 for decode branch update, 01 for execute branch update, 10 for register address, 11 for normal PC update +2
        will_branch_in_decode : OUT STD_LOGIC; -- 1 if the branch will be taken in decode stage, 0 otherwise
        branch_out : OUT STD_LOGIC
    );
END myBranchingController;

ARCHITECTURE branching_controller_arch OF myBranchingController IS
    SIGNAL prediction_bit : STD_LOGIC := '0';
    SIGNAL two_bit_PC_selector_signal : STD_LOGIC_VECTOR(1 DOWNTO 0) := "11";
    SIGNAL was_there_a_data_hazard_in_decode : STD_LOGIC := '0';
BEGIN
    PROCESS (clk)
        VARIABLE will_branch_in_execute : STD_LOGIC := '0';
    BEGIN
        IF (any_stall = '0' AND falling_edge(clk)) THEN
            IF (branched_in_decode = '1') THEN
                will_branch_in_decode <= '0';
                IF (a_branch_instruction_is_in_execute = '1') THEN
                    IF (execute_branch_unconditional = '0') THEN
                        IF (prediction_bit /= zero_flag) THEN
                            will_branch_in_execute := '1';
                            two_bit_PC_selector_signal <= "10";
                            prediction_bit <= '0';
                        ELSE
                            will_branch_in_execute := '0';
                            two_bit_PC_selector_signal <= "11";
                        END IF;
                    ELSE
                        will_branch_in_execute := '0';
                        two_bit_PC_selector_signal <= "11";
                    END IF;
                END IF;
            ELSE
                IF (a_branch_instruction_is_in_execute = '1') THEN
                    IF (execute_branch_unconditional = '0') THEN
                        IF (zero_flag = '1') THEN
                            IF (was_there_a_data_hazard_in_decode = '1') THEN
                                two_bit_PC_selector_signal <= "01"; -- Execute branch update
                            ELSE
                                prediction_bit <= '1';
                                two_bit_PC_selector_signal <= "10"; -- Wrong prediction
                            END IF;
                            will_branch_in_execute := '1';
                        ELSE
                            will_branch_in_execute := '0';
                            two_bit_PC_selector_signal <= "11";
                        END IF;
                    ELSE
                        will_branch_in_execute := '1';
                        two_bit_PC_selector_signal <= "01";
                    END IF;
                ELSE
                    will_branch_in_execute := '0';
                END IF;

                IF (a_branch_instruction_is_in_decode = '1' AND will_branch_in_execute = '0') THEN
                    IF (decode_branch_unconditional = '0') THEN
                        IF (prediction_bit = '1' AND can_branch = '1') THEN
                            will_branch_in_decode <= '1';
                            two_bit_PC_selector_signal <= "00";
                        ELSE
                            IF (can_branch = '0') THEN
                                was_there_a_data_hazard_in_decode <= '1';
                            END IF;
                            will_branch_in_decode <= '0';
                            two_bit_PC_selector_signal <= "11";
                        END IF;
                    ELSE
                        IF (can_branch = '1') THEN
                            will_branch_in_decode <= '1';
                            two_bit_PC_selector_signal <= "00";
                        ELSE
                            will_branch_in_decode <= '0';
                        END IF;
                    END IF;
                ELSIF will_branch_in_execute = '0' THEN
                    two_bit_PC_selector_signal <= "11";
                END IF;
            END IF;
        END IF;
    END PROCESS;
    prediction_out <= prediction_bit;
    branch_out <= two_bit_PC_selector_signal(0) NAND two_bit_PC_selector_signal(1);
    two_bit_PC_selector <= two_bit_PC_selector_signal;
END branching_controller_arch;