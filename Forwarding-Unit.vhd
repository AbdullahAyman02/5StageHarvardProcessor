LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY FU IS
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
END ENTITY;

ARCHITECTURE FU_ARCH OF FU IS
    SIGNAL FORWARD_PREV_ALU_DEST_TO_MUX_1 : STD_LOGIC;
    SIGNAL FORWARD_PREV_ALU_DEST_TO_MUX_2 : STD_LOGIC;

    SIGNAL FORWARD_PREV_MEM_DEST_TO_MUX_1 : STD_LOGIC;
    SIGNAL FORWARD_PREV_MEM_DEST_TO_MUX_2 : STD_LOGIC;

    SIGNAL FORWARD_PREV_ALU_SRC_2_TO_MUX_1 : STD_LOGIC;
    SIGNAL FORWARD_PREV_ALU_SRC_2_TO_MUX_2 : STD_LOGIC;

    SIGNAL FORWARD_PREV_MEM_SRC_2_TO_MUX_1 : STD_LOGIC;
    SIGNAL FORWARD_PREV_MEM_SRC_2_TO_MUX_2 : STD_LOGIC;
    
BEGIN
    FORWARD_PREV_ALU_DEST_TO_MUX_1 <= '1' WHEN (IMMEDIATE_VALUE_NOT_INSTRUCTION = '0' AND CURR_ALU_NEEDS_SRC_1 = '1' AND PREV_ALU_USES_DEST = '1' AND CURR_ALU_SRC_1 = PREV_ALU_DEST) ELSE
                                      '0';
    
    FORWARD_PREV_ALU_DEST_TO_MUX_2 <= '1' WHEN (IMMEDIATE_VALUE_NOT_INSTRUCTION = '0' AND CURR_ALU_NEEDS_SRC_2 = '1' AND PREV_ALU_USES_DEST = '1' AND CURR_ALU_SRC_2 = PREV_ALU_DEST) ELSE
                                      '0';



    FORWARD_PREV_MEM_DEST_TO_MUX_1 <= '1' WHEN (IMMEDIATE_VALUE_NOT_INSTRUCTION = '0' AND CURR_ALU_NEEDS_SRC_1 = '1' AND PREV_MEM_USES_DEST = '1' AND CURR_ALU_SRC_1 = PREV_MEM_DEST) ELSE
                                      '0';
    
    FORWARD_PREV_MEM_DEST_TO_MUX_2 <= '1' WHEN (IMMEDIATE_VALUE_NOT_INSTRUCTION = '0' AND CURR_ALU_NEEDS_SRC_2 = '1' AND PREV_MEM_USES_DEST = '1' AND CURR_ALU_SRC_2 = PREV_MEM_DEST) ELSE
                                      '0';
    


    FORWARD_PREV_ALU_SRC_2_TO_MUX_1 <= '1' WHEN (IMMEDIATE_VALUE_NOT_INSTRUCTION = '0' AND CURR_ALU_NEEDS_SRC_1 = '1' AND PREV_ALU_IS_SWAP = '1' AND CURR_ALU_SRC_1 = PREV_ALU_SRC_2) ELSE
                                       '0';
    
    FORWARD_PREV_ALU_SRC_2_TO_MUX_2 <= '1' WHEN (IMMEDIATE_VALUE_NOT_INSTRUCTION = '0' AND CURR_ALU_NEEDS_SRC_2 = '1' AND PREV_ALU_IS_SWAP = '1' AND CURR_ALU_SRC_2 = PREV_ALU_SRC_2) ELSE
                                       '0';



    FORWARD_PREV_ALU_SRC_2_TO_MUX_1 <= '1' WHEN (IMMEDIATE_VALUE_NOT_INSTRUCTION = '0' AND CURR_ALU_NEEDS_SRC_1 = '1' AND PREV_ALU_IS_SWAP = '1' AND CURR_ALU_SRC_1 = PREV_ALU_SRC_2) ELSE
                                       '0';
    FORWARD_PREV_ALU_SRC_2_TO_MUX_1 <= '1' WHEN (IMMEDIATE_VALUE_NOT_INSTRUCTION = '0' AND CURR_ALU_NEEDS_SRC_2 = '1' AND PREV_ALU_IS_SWAP = '1' AND CURR_ALU_SRC_2 = PREV_ALU_SRC_2) ELSE
                                       '0';
                              


    FORWARD_PREV_MEM_SRC_2_TO_MUX_1 <= '1' WHEN (IMMEDIATE_VALUE_NOT_INSTRUCTION = '0' AND CURR_ALU_NEEDS_SRC_1 = '1' AND PREV_MEM_IS_SWAP = '1' AND CURR_ALU_SRC_1 = PREV_MEM_SRC_2) ELSE
                                       '0';
    FORWARD_PREV_MEM_SRC_2_TO_MUX_1 <= '1' WHEN (IMMEDIATE_VALUE_NOT_INSTRUCTION = '0' AND CURR_ALU_NEEDS_SRC_2 = '1' AND PREV_MEM_IS_SWAP = '1' AND CURR_ALU_SRC_2 = PREV_MEM_SRC_2) ELSE
                                       '0';


                                       
    -- MUX SELECTORS                                  
    -- 000  PREV ALU DEST
    -- 001  PREV ALU SRC 2
    -- 010  PREV MEM DEST
    -- 011  PREV MEM SRC 2
    -- 100  NORMAL SRC 1 FROM DECODE-EXECUTE PIPELINE REGISTER
    -- 101  NORMAL SRC 2 FROM DECODE-EXECUTE PIPELINE REGISTER
    -- 110  IMMEDIATE VALUE FROM DECODE-EXECUTE PIPELINE REGISTER
    -- 111

    MUX_1_SELECTOR <=   "000" WHEN (FORWARD_PREV_ALU_DEST_TO_MUX_1 = '1') ELSE
                        "001" WHEN (FORWARD_PREV_ALU_SRC_2_TO_MUX_1 = '1') ELSE
                        "010" WHEN (FORWARD_PREV_MEM_DEST_TO_MUX_1 = '1') ELSE
                        "011" WHEN (FORWARD_PREV_MEM_SRC_2_TO_MUX_1 = '1') ELSE
                        "100";

    MUX_2_SELECTOR <=   "000" WHEN (FORWARD_PREV_ALU_DEST_TO_MUX_2 = '1') ELSE
                        "001" WHEN (FORWARD_PREV_ALU_SRC_2_TO_MUX_2 = '1') ELSE
                        "010" WHEN (FORWARD_PREV_MEM_DEST_TO_MUX_2 = '1') ELSE
                        "011" WHEN (FORWARD_PREV_MEM_SRC_2_TO_MUX_2 = '1') ELSE
                        "110" WHEN (IMMEDIATE_VALUE_NOT_INSTRUCTION = '1') ELSE
                        "101";
    
    MUX_3_SELECTOR <=   "000" WHEN (FORWARD_PREV_ALU_DEST_TO_MUX_2 = '1') ELSE
                        "001" WHEN (FORWARD_PREV_ALU_SRC_2_TO_MUX_2 = '1') ELSE
                        "010" WHEN (FORWARD_PREV_MEM_DEST_TO_MUX_2 = '1') ELSE
                        "011" WHEN (FORWARD_PREV_MEM_SRC_2_TO_MUX_2 = '1') ELSE
                        "101";



    CAN_BRANCH  <=  '0' WHEN (PREV_ALU_USES_DEST = '1' AND ADDRESS_TO_BRANCH_TO = PREV_ALU_DEST)  ELSE          
                    '0' WHEN (PREV_MEM_USES_DEST = '1' AND ADDRESS_TO_BRANCH_TO = PREV_MEM_DEST)  ELSE
                    '0' WHEN (PREV_ALU_IS_SWAP = '1'   AND ADDRESS_TO_BRANCH_TO = PREV_ALU_SRC_2) ELSE
                    '0' WHEN (PREV_MEM_IS_SWAP = '1'   AND ADDRESS_TO_BRANCH_TO = PREV_MEM_SRC_2) ELSE
                    '1';    
END ARCHITECTURE;