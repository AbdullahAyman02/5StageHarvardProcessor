LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Branch -> Selector signal to indicate that the instruction is a branch instruction (lel PC el 2x1 elly bya5od ya sequential ya branch)
-- Branched in Decode -> Currently in execute checking if I branched in decode or not
-- Decode_Branch -> Currently in decode checking if I should branch or not
-- Decode_Conditional -> Currently in decode checking if my jump is conditional or not
-- Can_Branch -> Data hazard check from forwarding unit to see if i can branch in decode or not
-- Branching_In_Decode -> Currently in decode, decide if I will branch or not
-- Execute_Branch -> Currently in execute, checking if I should branch or not
-- Execute_Conditional -> Currently in execute, checking if my jump is conditional or not
-- Branched_In_Decode_And_Should_Not_Have_Branched -> Currently in execute, checking if prediction was taken but decision is not taken

ENTITY BranchingController IS
    PORT (
        Decode_Branch : IN STD_LOGIC;
        Decode_Conditional : IN STD_LOGIC;
        Execute_Branch : IN STD_LOGIC;
        Execute_Conditional : IN STD_LOGIC;
        Can_Branch : IN STD_LOGIC;
        Zero_Flag : IN STD_LOGIC;
        Branched_In_Decode : IN STD_LOGIC;

        Prediction : OUT STD_LOGIC;
        Branch : OUT STD_LOGIC;
        Selectors : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        Branching_In_Decode : OUT STD_LOGIC
    );
END BranchingController;

-- No interrupt,
-- 1- Branch in decode
-- 2- Next cycle, JZ in execute and flushed in decode (m4 h3mel 7aga 34an already jumped in decode)

-- 1- Did not branch in decode
-- 2- Next cycle, JZ in execute and JZ in decode (jump in execute)

-- Interrupt
-- 1- Branch in decode
-- 2- Next cycle, JZ in execute and JZ in decode (hnafez code el decode tany 34an el address el sa7 yrga3) -> el address el sa7 beta3 el jz elly fel execute? law kan ma3mollo stall 34an interrupt fa el etnein homa homa aslan sa7?

-- 1- Did not branch in decode
-- 2- Next cycle, JZ in execute and JZ in decode (jump in execute)

-- Conditional
-- No interrupt
-- 1- Branch in decode

-- Two cases
-- prediction is correct
-- No interrupt
-- 2- Next cycle, prediction is correct, do not branch in execute (flushed in decode)

-- 1- Did not branch in decode
-- 2- Next cycle, prediction is correct, 
-- if branch_decode
-- 	if decode_jump
-- 		branch <= 1
-- 		selector choose address from decode
-- else
-- 	if execute_jump
-- 		branh <= 1
-- 		selector choose address from execute
-- 	else if decode_jump
-- 		branch <= 1
-- 		selector choose address from decode
-- CanBranch

ARCHITECTURE BranchingController_arch OF BranchingController IS
    SIGNAL Prediction_Bit : STD_LOGIC := '0';
    SIGNAL Branching_In_Execute : STD_LOGIC := '0';
    SIGNAL Branched_In_Decode_And_Should_Not_Have_Branched : STD_LOGIC := '0';
BEGIN
    PROCESS (Decode_Branch, Decode_Conditional, Execute_Branch, Execute_Conditional, Can_Branch, Zero_Flag, Branched_In_Decode)
    BEGIN
        -- In case of a normal jump after the decode stage, currently in the execute stage
        IF Branched_In_Decode = '1' THEN
            -- Branching happened in decode -> Currently in execute after branching from decode
            -- Check if the prediction was correct
            IF Execute_Branch = '1' THEN -- Jumped in decode, currently in execute
                IF Execute_Conditional = '1' THEN -- Check if the prediction was correct
                    IF Prediction_Bit /= Zero_Flag THEN -- Prediction was incorrect      -> Should I flush this pipeline register in case it is wrong?
                        Branch <= '1';
                        Selectors <= "10"; -- Correct PC in case of wrong prediction
                        Prediction_Bit <= '0'; -- Update prediction bit (since i branched in decode, my prediction was taken -> update it to not taken)
                        Branched_In_Decode_And_Should_Not_Have_Branched <= '1'; -- Prediction was taken in decode, decision is not taken in execute
                    ELSE
                        Branched_In_Decode_And_Should_Not_Have_Branched <= '0'; -- Prediction was correct, so reset the signal
                    END IF;
                END IF;
            END IF;
            -- Law No interrupt, el instruction elly fel decode hateb2a flushed (NOOP), fa nothing will happen
            -- Law Interrupt, el instruction elly fel execution now hateb2a heyya heyya elly fel decode (34an law interrupt fa el pipeline register hayeb2a stalled)
            -- Fa e3melha tany 34an law natteit fel decode, w fel execute tel3et el natta sa77 (ayyan kan conditional walla unconditional), me7tageen neragga3 el PC wara tany 34an el interrupt
            IF Decode_Branch = '1' AND Branched_In_Decode_And_Should_Not_Have_Branched = '0' THEN -- Check ennak fel decode branch (stalled me4 NOOP), wel natta kanet sa7
                IF Decode_Conditional = '1' THEN -- Branching instruction in decode is conditional
                    IF Prediction_Bit = '1' AND Can_Branch = '1' THEN -- Prediction is taken (jump) and there are no data hazards
                        Branch <= '1'; -- Set control signals for branching
                        Selectors <= "00"; -- Decode Branch Update
                        Branching_In_Decode <= '1';
                    ELSE -- Dol me4 mohemmeen 34an enta keda keda natteit 5alas, fa mota2akked en el case de mat7a22a2et4
                        Branch <= '0';
                        Branching_In_Decode <= '0';
                    END IF;
                ELSIF Can_Branch = '1' THEN
                    Branch <= '1';
                    Selectors <= "00";
                    Branching_In_Decode <= '1';
                ELSE
                    Branch <= '0';
                    Branching_In_Decode <= '0';
                END IF;
                -- The prediction was correct, so reset the signals
            ELSIF Branched_In_Decode_And_Should_Not_Have_Branched = '0' THEN
                Branch <= '0'; -- Do not jump from execute.
            END IF;
        ELSE -- No branching happened in decode, either due to data hazards, or the prediction was not taken
            -- The priority is first to the instruction currently in the execute stage, so check if it can jump first
            IF Execute_Branch = '1' THEN -- Currently in execute, check if this is a branching instruction
                IF Execute_Conditional = '1' THEN -- If it is a conditional branch, check if the decision is taken or not
                    IF Zero_Flag = '1' THEN -- Decision is taken, so jump
                        Branch <= '1';
                        Selectors <= "01"; -- Execute Branch Update
                        Prediction_Bit <= '1'; -- Update the prediction bit
                        Branching_In_Execute <= '1'; -- Set the signal to indicate that I branched in execute, in case if next instruction is also branching (priority to execute stage)
                    -- If the decision is not taken, reset the signal to check if the next instruction is branching or not
                    ELSE
                        Branching_In_Execute <= '0';
                    END IF;
                ELSE -- Unconditional branch, did not jump in decode due to data hazards, so jump in execute
                    Branch <= '1';
                    Selectors <= "01"; -- Execute Branch Update
                    Branching_In_Execute <= '1'; -- Set the signal to indicate that I branched in execute, in case if next instruction is also branching (priority to execute stage)
                END IF;
            ELSE -- Currently in execute, but this is not a branching instruction
                Branching_In_Execute <= '0'; -- Reset the signal
            END IF;
            -- Since you are here, the instruction in execute currently is not a branching/jumping instruction or conditional jump not taken, so check if the next instruction (the one in the decode currently) is a branching instruction
            IF Decode_Branch = '1' AND Branching_In_Execute = '0' THEN -- Next instruction which is currently in decode is a branching instruction
                IF Decode_Conditional = '1' THEN -- Branching instruction in decode is conditional
                    IF Prediction_Bit = '1' AND Can_Branch = '1' THEN -- Prediction is taken (jump) and there are no data hazards
                        Branch <= '1'; -- Set control signals for branching
                        Selectors <= "00"; -- Decode Branch Update
                        Branching_In_Decode <= '1';
                    ELSE -- Either the prediction is not taken or there are data hazards; either way, do not jump from decode
                        Branch <= '0';
                        Branching_In_Decode <= '0';
                    END IF;
                ELSIF Can_Branch = '1' THEN -- Branching instruction in decode is unconditional, and there are no data hazards, so jump from decode
                    Branch <= '1';
                    Selectors <= "00"; -- Decode Branch Update
                    Branching_In_Decode <= '1';
                ELSE -- Branching instruction in decode is unconditional, but there are data hazards, so do not jump from decode
                    Branch <= '0';
                    Branching_In_Decode <= '0';
                END IF;
            ELSIF Branching_In_Execute = '0' THEN -- If you already jumped from execute, do nothing. Else it wasn't a branching instruction in decode, so do not jump from decode
                Branch <= '0';
            END IF;
        END IF;
        Prediction <= Prediction_Bit;
    END PROCESS;
END BranchingController_arch;