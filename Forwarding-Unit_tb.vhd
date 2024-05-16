LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY FU_TB IS
END ENTITY;

ARCHITECTURE FU_TB_ARCH OF FU_TB IS 

     COMPONENT FU
     PORT(
            -- Inputs
            CURR_ALU_SRC_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            CURR_ALU_SRC_2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

            PREV_ALU_DEST : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            PREV_MEM_DEST : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            
            PREV_ALU_SRC_2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            PREV_MEM_SRC_2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

            CURR_ALU_NEEDS_SRC_1 : IN STD_LOGIC;
            CURR_ALU_NEEDS_SRC_2 : IN STD_LOGIC;

            PREV_ALU_USES_DEST : IN STD_LOGIC;
            PREV_MEM_USES_DEST : IN STD_LOGIC;

            PREV_ALU_IS_SWAP : IN STD_LOGIC;
            PREV_MEM_IS_SWAP : IN STD_LOGIC;

            IMMEDIATE_VALUE_NOT_INSTRUCTION : IN STD_LOGIC;

            ADDRESS_TO_BRANCH_TO : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

            -- Outputs
            MUX_1_SELECTOR : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            MUX_2_SELECTOR : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            MUX_3_SELECTOR : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);

            CAN_BRANCH : OUT STD_LOGIC
     );
    END COMPONENT;

    -- Inputs
    SIGNAL CURR_ALU_SRC_1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL CURR_ALU_SRC_2 : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL PREV_ALU_DEST : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL PREV_MEM_DEST : STD_LOGIC_VECTOR(31 DOWNTO 0);
    
    SIGNAL PREV_ALU_SRC_2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL PREV_MEM_SRC_2 : STD_LOGIC_VECTOR(31 DOWNTO 0);

    SIGNAL CURR_ALU_NEEDS_SRC_1 : STD_LOGIC;
    SIGNAL CURR_ALU_NEEDS_SRC_2 : STD_LOGIC;

    SIGNAL PREV_ALU_USES_DEST : STD_LOGIC;
    SIGNAL PREV_MEM_USES_DEST : STD_LOGIC;

    SIGNAL PREV_ALU_IS_SWAP : STD_LOGIC;
    SIGNAL PREV_MEM_IS_SWAP : STD_LOGIC;

    SIGNAL IMMEDIATE_VALUE_NOT_INSTRUCTION : STD_LOGIC;

    SIGNAL ADDRESS_TO_BRANCH_TO : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- Outputs
    SIGNAL MUX_1_SELECTOR : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL MUX_2_SELECTOR : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL MUX_3_SELECTOR : STD_LOGIC_VECTOR(2 DOWNTO 0);

    SIGNAL CAN_BRANCH : STD_LOGIC;

BEGIN
     -- Instantiate the Unit Under Test (UUT)
    UUT_FU: FU PORT MAP (
            -- Inputs
            CURR_ALU_SRC_1 => CURR_ALU_SRC_1,
            CURR_ALU_SRC_2 => CURR_ALU_SRC_2,

            PREV_ALU_DEST => PREV_ALU_DEST,
            PREV_MEM_DEST => PREV_MEM_DEST,

            PREV_ALU_SRC_2 => PREV_ALU_SRC_2,
            PREV_MEM_SRC_2 => PREV_MEM_SRC_2,

            CURR_ALU_NEEDS_SRC_1 => CURR_ALU_NEEDS_SRC_1,
            CURR_ALU_NEEDS_SRC_2 => CURR_ALU_NEEDS_SRC_2,

            PREV_ALU_USES_DEST => PREV_ALU_USES_DEST,
            PREV_MEM_USES_DEST => PREV_MEM_USES_DEST,

            PREV_ALU_IS_SWAP => PREV_ALU_IS_SWAP,
            PREV_MEM_IS_SWAP => PREV_MEM_IS_SWAP,

            IMMEDIATE_VALUE_NOT_INSTRUCTION => IMMEDIATE_VALUE_NOT_INSTRUCTION,

            ADDRESS_TO_BRANCH_TO => ADDRESS_TO_BRANCH_TO,

            -- Outputs
            MUX_1_SELECTOR => MUX_1_SELECTOR,
            MUX_2_SELECTOR => MUX_2_SELECTOR,
            MUX_3_SELECTOR => MUX_3_SELECTOR,

            CAN_BRANCH => CAN_BRANCH
          );

    PROCESS BEGIN
        -- MUX SELECTORS                                  
        -- 000  PREV ALU DEST
        -- 001  PREV ALU SRC 2
        -- 010  PREV MEM DEST
        -- 011  PREV MEM SRC 2
        -- 100  NORMAL SRC 1 FROM DECODE-EXECUTE PIPELINE REGISTER
        -- 101  NORMAL SRC 2 FROM DECODE-EXECUTE PIPELINE REGISTER
        -- 110  IMMEDIATE VALUE FROM DECODE-EXECUTE PIPELINE REGISTER
        -- 111

        --TEST CASE 0: All inputs 0, addresses X
        CURR_ALU_SRC_1 <= (others => 'X');
        CURR_ALU_SRC_2 <= (others => 'X');
        
        PREV_ALU_DEST <= (others => 'X');
        PREV_MEM_DEST <= (others => 'X');
        
        PREV_ALU_SRC_2 <= (others => 'X');
        PREV_MEM_SRC_2 <= (others => 'X');
        
        CURR_ALU_NEEDS_SRC_1 <= '0';
        CURR_ALU_NEEDS_SRC_2 <= '0';
        
        PREV_ALU_USES_DEST <= '0';
        PREV_MEM_USES_DEST <= '0';
        
        PREV_ALU_IS_SWAP <= '0';
        PREV_MEM_IS_SWAP <= '0';
        
        IMMEDIATE_VALUE_NOT_INSTRUCTION <= '0';
        
        ADDRESS_TO_BRANCH_TO <= (others => 'X');
        
        WAIT FOR 10 ns;
        ASSERT MUX_1_SELECTOR = "100" AND MUX_2_SELECTOR = "101" AND MUX_3_SELECTOR = "101"
        REPORT "TEST CASE 0: All inputs 0, addresses X" SEVERITY ERROR;

        --TEST CASE 1
        -- MUX 1: PREV ALU DEST
        -- MUX 2: PREV ALU SRC 2
        -- MUX 3: PREV ALU SRC 2 (Eventhough the memory will also write to this location, the value from the ALU will be the one taken)
        CURR_ALU_SRC_1 <= X"00000005";        
        CURR_ALU_SRC_2 <= X"00000A00";
        
        PREV_ALU_DEST <= X"00000005";
        PREV_MEM_DEST <= (others => 'X');
        
        PREV_ALU_SRC_2 <= X"00000A00";
        PREV_MEM_SRC_2 <= X"00000A00";
        
        CURR_ALU_NEEDS_SRC_1 <= '1';
        CURR_ALU_NEEDS_SRC_2 <= '1';
        
        PREV_ALU_USES_DEST <= '1';
        PREV_MEM_USES_DEST <= '0';
        
        PREV_ALU_IS_SWAP <= '1';
        PREV_MEM_IS_SWAP <= '1';
        
        IMMEDIATE_VALUE_NOT_INSTRUCTION <= '0';
        
        ADDRESS_TO_BRANCH_TO <= (others => 'X');
        
        WAIT FOR 10 ns;
        ASSERT MUX_1_SELECTOR = "000" AND MUX_2_SELECTOR = "001" AND MUX_3_SELECTOR = "001"
        REPORT "TEST CASE 1: MUX 1: PREV ALU DEST, MUX 2: PREV ALU SRC 2, MUX 3: PREV MEM SRC 2" SEVERITY ERROR;

        --TEST CASE 2
        -- Branching instruction and the branch matches the AU destination
        CURR_ALU_SRC_1 <= (others => 'X');
        CURR_ALU_SRC_2 <= (others => 'X');
        
        PREV_ALU_DEST <= X"00000A00";
        PREV_MEM_DEST <= (others => 'X');
        
        PREV_ALU_SRC_2 <= (others => 'X');
        PREV_MEM_SRC_2 <= (others => 'X');
        
        CURR_ALU_NEEDS_SRC_1 <= '0';
        CURR_ALU_NEEDS_SRC_2 <= '0';
        
        PREV_ALU_USES_DEST <= '1';
        PREV_MEM_USES_DEST <= '0';
        
        PREV_ALU_IS_SWAP <= '0';
        PREV_MEM_IS_SWAP <= '0';
        
        IMMEDIATE_VALUE_NOT_INSTRUCTION <= '0';
        
        ADDRESS_TO_BRANCH_TO <= X"00000A00";
        
        WAIT FOR 10 ns;
        ASSERT MUX_1_SELECTOR = "100" AND MUX_2_SELECTOR = "101" AND MUX_3_SELECTOR = "101" AND CAN_BRANCH = '0'
        REPORT "TEST CASE 2: Can not branch" SEVERITY ERROR;

        --TEST CASE 3
        -- This is an immediate value so all selectors should be default and can branch = 1
        CURR_ALU_SRC_1 <= X"00000A00";
        CURR_ALU_SRC_2 <= (others => 'X');
        
        PREV_ALU_DEST <= (others => 'X');
        PREV_MEM_DEST <= (others => 'X');
        
        PREV_ALU_SRC_2 <= (others => 'X');
        PREV_MEM_SRC_2 <= X"00000A00";
        
        CURR_ALU_NEEDS_SRC_1 <= '0';
        CURR_ALU_NEEDS_SRC_2 <= '0';
        
        PREV_ALU_USES_DEST <= '0';
        PREV_MEM_USES_DEST <= '0';
        
        PREV_ALU_IS_SWAP <= '0';
        PREV_MEM_IS_SWAP <= '1';
        
        IMMEDIATE_VALUE_NOT_INSTRUCTION <= '1';
        
        ADDRESS_TO_BRANCH_TO <= (others => 'X');
        
        WAIT FOR 10 ns;
        ASSERT MUX_1_SELECTOR = "100" AND MUX_2_SELECTOR = "110" AND MUX_3_SELECTOR = "101"
        REPORT "TEST CASE 0: All inputs 0, addresses X" SEVERITY ERROR;

    WAIT;
    END PROCESS;
   
END;