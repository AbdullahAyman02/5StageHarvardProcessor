LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Branched in Decode -> Currently in execute checking if I branched in decode or not
-- Decode_Branch -> Currently in decode checking if I should branch or not
-- Decode_Conditional -> Currently in decode checking if my jump is conditional or not
-- Can_Branch -> Data hazard check from forwarding unit to see if i can branch in decode or not
-- Branching_In_Decode -> Currently in decode, decide if I will branch or not
-- Execute_Branch -> Currently in execute, checking if I should branch or not
-- Execute_Conditional -> Currently in execute, checking if my jump is conditional or not

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
-- 2- Next cycle, JZ in execute and JZ in deocde (hnafez code el decode tany 34an el address el sa7 yrga3)

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

ARCHITECTURE OF BranchingController_arch IS
    SIGNAL Prediction_Bit : STD_LOGIC := '0';
    SIGNAL Branching_In_Execute : STD_LOGIC := '0';
    SIGNAL Branched_In_Decode_And_Should_Not_Have_Branched : STD_LOGIC := '0';
BEGIN
    PROCESS (Decode_Branch, Decode_Conditional, Execute_Branch, Execute_Conditional, Can_Branch, Zero_Flag, Branched_In_Decode)
    BEGIN
        IF Branched_In_Decode = '1' THEN
        -- Branching happened in decode -> Currently in execute after branching from decode
            IF Execute_Branch = '1' THEN           -- Jumped in decode, currently in execute
                IF Execute_Conditional = '1' THEN       -- Check if the prediction was correct
                    IF Predicition_Bit /= Zero_Flag THEN    -- Prediction was incorrect
                        Branch <= '1';
                        Selectors <= "10";              -- Execute Branch Update
                        Prediction_Bit <= '0';          -- Update prediction bit (since i branched in decode, my prediction was taken -> update it to not taken)
                        Branched_In_Decode_And_Should_Not_Have_Branched <= '1';
                    ELSE
                        Branched_In_Decode_And_Should_Not_Have_Branched <= '0';
                    END IF;
                END IF;
            END IF;    
            IF Decode_Branch = '1' AND Branched_In_Decode_And_Should_Not_Have_Branched = '0' THEN     -- Next instruction which is currently in decode is a branching instruction
                IF Decode_Conditional = '1' THEN        -- Branching instruction in decode is conditional
                    IF Prediction_Bit = '1' AND Can_Branch = '1' THEN       -- Prediction is taken (jump) and there are no data hazards
                        Branch <= '1';                  -- Set control signals for branching
                        Selectors <= "00";              -- Decode Branch Update
                        Branching_In_Decode <= '1';
                    ELSE                    -- Either the prediction is not taken or there are data hazards; either way, do not jump from decode
                        Branch <= '0';
                        Branching_In_Decode <= '0';
                    END IF;
                ELSE IF Can_Branch = '1' THEN       -- Branching instruction in decode is unconditional, and there are no data hazards, so jump from decode
                    Branch <= '1';
                    Selectors <= "00";
                    Branching_In_Decode <= '1';
                ELSE                -- Branching instruction in decode is unconditional, but there are data hazards, so do not jump from decode
                    Branch <= '0';
                    Branching_In_Decode <= '0';
                END IF;
            ELSE IF Branched_In_Decode_And_Should_Not_Have_Branched = '0' THEN
                Branch <= '0';
            END IF;
        ELSE        -- No branching happened in decode, either due to data hazards, or the prediction was not taken
            IF Execute_Branch = '1' THEN                -- Currently in execute, check if this is a branching instruction
                IF Execute_Conditional = '1' THEN       -- If it is a conditional branch, check if you the decision is taken, so jump
                    IF Zero_Flag = '1' THEN             -- Correct decision should be taken
                        Branch <= '1';
                        Selectors <= "01";              -- Correct PC in case of wrong prediction
                        Prediction_Bit <= '1';
                        Branching_In_Execute <= '1';
                    END IF;
                ELSE
                    Branch <= '1';
                    Selectors <= "01";  
                    Branching_In_Execute <= '1';
                END IF;
            ELSE
                Branching_In_Execute <= '0';  
            END IF;
            IF Decode_Branch = '1' AND Branching_In_Execute = '0' THEN  
                IF Decode_Conditional = '1' THEN        -- Branching instruction in decode is conditional
                    IF Prediction_Bit = '1' AND Can_Branch = '1' THEN       -- Prediction is taken (jump) and there are no data hazards
                        Branch <= '1';                  -- Set control signals for branching
                        Selectors <= "00";              -- Decode Branch Update
                        Branching_In_Decode <= '1';
                    ELSE                    -- Either the prediction is not taken or there are data hazards; either way, do not jump from decode
                        Branch <= '0';
                        Branching_In_Decode <= '0';
                    END IF;
                ELSE IF Can_Branch = '1' THEN       -- Branching instruction in decode is unconditional, and there are no data hazards, so jump from decode
                    Branch <= '1';
                    Selectors <= "00";
                    Branching_In_Decode <= '1';
                ELSE                -- Branching instruction in decode is unconditional, but there are data hazards, so do not jump from decode
                    Branch <= '0';
                    Branching_In_Decode <= '0';
                END IF;
            ELSE IF Branching_In_Execute = '0' THEN
                Branch <= '0';
            END IF;
        END IF;
        Prediction <= Prediction_Bit;
    END PROCESS;
END BranchingController_arch;