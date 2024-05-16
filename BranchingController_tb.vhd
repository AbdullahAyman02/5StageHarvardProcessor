LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY branching_controller_tb IS
END branching_controller_tb;

ARCHITECTURE behavior OF branching_controller_tb IS

   COMPONENT myBranchingController
      PORT (
         clk : IN STD_LOGIC;
         a_branch_instruction_is_in_decode : IN STD_LOGIC;
         a_branch_instruction_is_in_execute : IN STD_LOGIC;
         decode_branch_conditional : IN STD_LOGIC;
         execute_branch_conditional : IN STD_LOGIC;
         branched_in_decode : IN STD_LOGIC;
         can_branch : IN STD_LOGIC;
         zero_flag : IN STD_LOGIC;
         any_stall : IN STD_LOGIC;

         prediction_out : OUT STD_LOGIC;
         two_bit_PC_selector : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
         will_branch_in_decode : OUT STD_LOGIC;
         branch_out : OUT STD_LOGIC
      );
   END COMPONENT;

   --Inputs
   SIGNAL a_branch_instruction_is_in_decode : STD_LOGIC := '0';
   SIGNAL a_branch_instruction_is_in_execute : STD_LOGIC := '0';
   SIGNAL decode_branch_conditional : STD_LOGIC := '0';
   SIGNAL execute_branch_conditional : STD_LOGIC := '0';
   SIGNAL branched_in_decode : STD_LOGIC := '0';
   SIGNAL can_branch : STD_LOGIC := '0';
   SIGNAL zero_flag : STD_LOGIC := '0';
   SIGNAL any_stall : STD_LOGIC := '0';
   SIGNAL clk : STD_LOGIC := '0';

   --Outputs
   SIGNAL prediction_out : STD_LOGIC;
   SIGNAL two_bit_PC_selector : STD_LOGIC_VECTOR(1 DOWNTO 0);
   SIGNAL will_branch_in_decode : STD_LOGIC;
   SIGNAL branch_out : STD_LOGIC;
   SIGNAL clk_period : TIME := 100 ns;

BEGIN

   uut : myBranchingController PORT MAP(
      clk => clk,
      a_branch_instruction_is_in_decode => a_branch_instruction_is_in_decode,
      a_branch_instruction_is_in_execute => a_branch_instruction_is_in_execute,
      decode_branch_conditional => decode_branch_conditional,
      execute_branch_conditional => execute_branch_conditional,
      branched_in_decode => branched_in_decode,
      can_branch => can_branch,
      zero_flag => zero_flag,
      prediction_out => prediction_out,
      two_bit_PC_selector => two_bit_PC_selector,
      will_branch_in_decode => will_branch_in_decode,
      any_stall => any_stall,
      branch_out => branch_out
   );
   clk_process : PROCESS
   BEGIN
      clk <= '0';
      WAIT FOR clk_period / 2;
      clk <= '1';
      WAIT FOR clk_period / 2;
   END PROCESS;

   stim_proc : PROCESS
   BEGIN

      WAIT FOR clk_period;


      -- Test Case - 1 ************************************************************************************************

      -- This is the case where i am in decode and predicting not taken while there is no data hazard with a conditional branch
      --prediction bit here is zero by default
      branched_in_decode <= '0';
      a_branch_instruction_is_in_decode <= '1';
      a_branch_instruction_is_in_execute <= '0';
      decode_branch_conditional <= '1';
      any_stall <= '0';
      can_branch <= '1';

      WAIT FOR clk_period;

      ASSERT will_branch_in_decode = '0' REPORT "Test case 1 decode, will_branch_in_decode is not '0'" SEVERITY error;
      ASSERT two_bit_PC_selector = "11" REPORT "Test case 1 decode, two_bit_PC_selector_signal is not '11'" SEVERITY error;
      ASSERT prediction_out = '0' REPORT "Test case 1 decode, prediction_out is not '0'" SEVERITY error;
      -- Now the branch instruction will be in the execute, and i predicted correct (not taken)
      --prediction bit here is zero by default
      branched_in_decode <= '0';
      a_branch_instruction_is_in_execute <= '1';
      a_branch_instruction_is_in_decode <= '0';
      execute_branch_conditional <= '1';
      any_stall <= '0';
      zero_flag <= '0';

      WAIT FOR clk_period;

      ASSERT two_bit_PC_selector = "11" REPORT "Test case 1 exec, two_bit_PC_selector_signal is not '11'" SEVERITY error;
      ASSERT prediction_out = '0' REPORT "Test case 1 exec, prediction_out is not '0'" SEVERITY error;

      --******************************************************************************************************************



      -- Test Case - 2 ****************************************************************************************************

      -- This is the case where i am in decode and predicting not taken while there is no data hazard with a conditional branch
      --prediction bit here is zero by default
      branched_in_decode <= '0';
      a_branch_instruction_is_in_decode <= '1';
      a_branch_instruction_is_in_execute <= '0';
      decode_branch_conditional <= '1';
      any_stall <= '0';
      can_branch <= '1';

      WAIT FOR clk_period;

      ASSERT will_branch_in_decode = '0' REPORT "Test case 2 decode, will_branch_in_decode is not '0'" SEVERITY error;
      ASSERT two_bit_PC_selector = "11" REPORT "Test case 2 decode, two_bit_PC_selector_signal is not '11'" SEVERITY error;
      ASSERT prediction_out = '0' REPORT "Test case 2 decode, prediction_out is not '0'" SEVERITY error;
      -- Now the branch instruction will be in the execute, and i predicted wrong (taken)
      --prediction bit here is zero by default
      branched_in_decode <= '0';
      a_branch_instruction_is_in_execute <= '1';
      a_branch_instruction_is_in_decode <= '0';
      execute_branch_conditional <= '1';
      any_stall <= '0';
      zero_flag <= '1';

      WAIT FOR clk_period;

      ASSERT two_bit_PC_selector = "10" REPORT "Test case 2 exec, two_bit_PC_selector_signal is not '10'" SEVERITY error;
      ASSERT prediction_out = '1' REPORT "Test case 2 exec, prediction_out is not '1'" SEVERITY error;

      --*******************************************************************************************************************




      -- Test Case - 3 ****************************************************************************************************

      -- This is the case where i am in decode and predicting taken while there is no data hazard with a conditional branch
      --prediction bit here is 1
      branched_in_decode <= '0';
      a_branch_instruction_is_in_decode <= '1';
      a_branch_instruction_is_in_execute <= '0';
      decode_branch_conditional <= '1';
      any_stall <= '0';
      can_branch <= '1';

      WAIT FOR clk_period;

      ASSERT will_branch_in_decode = '1' REPORT "Test case 3 decode, will_branch_in_decode is not '1'" SEVERITY error;
      ASSERT two_bit_PC_selector = "00" REPORT "Test case 3 decode, two_bit_PC_selector_signal is not '00'" SEVERITY error;
      ASSERT prediction_out = '1' REPORT "Test case 3 decode, prediction_out is not '1'" SEVERITY error;
      -- Now the branch instruction will be in the execute, and i predicted correct (taken)
      --prediction bit here is 1
      branched_in_decode <= '1';
      a_branch_instruction_is_in_execute <= '1';
      a_branch_instruction_is_in_decode <= '0';
      execute_branch_conditional <= '1';
      any_stall <= '0';
      zero_flag <= '1';

      WAIT FOR clk_period;

      ASSERT two_bit_PC_selector = "11" REPORT "Test case 3 exec, two_bit_PC_selector_signal is not '11'" SEVERITY error;
      ASSERT prediction_out = '1' REPORT "Test case 3 exec, prediction_out is not '1'" SEVERITY error;

      --*******************************************************************************************************************



      --*******************************************************************************************************************
      -- Test Case - 9 ****************************************************************************************************

      -- This is the case where there is a conditional branch in decode and prediction bit is taken, but there is a data hazard
      --prediction bit here is 1
      branched_in_decode <= '0';
      a_branch_instruction_is_in_decode <= '1';
      a_branch_instruction_is_in_execute <= '0';
      decode_branch_conditional <= '1';
      any_stall <= '0';
      can_branch <= '0';

      WAIT FOR clk_period;

      ASSERT will_branch_in_decode = '0' REPORT "Test case 9 decode, will_branch_in_decode is not '0'" SEVERITY error;
      ASSERT two_bit_PC_selector = "11" REPORT "Test case 9 decode, two_bit_PC_selector_signal is not '11'" SEVERITY error;
      ASSERT prediction_out = '1' REPORT "Test case 9 decode, prediction_out is not '1'" SEVERITY error;

      branched_in_decode <= '0';
      a_branch_instruction_is_in_execute <= '1';
      a_branch_instruction_is_in_decode <= '0';
      execute_branch_conditional <= '1';
      any_stall <= '0';
      zero_flag <= '0';

      WAIT FOR clk_period;

      ASSERT two_bit_PC_selector = "11" REPORT "Test case 9 exec, two_bit_PC_selector_signal is not '11'" SEVERITY error;
      ASSERT prediction_out = '1' REPORT "Test case 9 exec, prediction_out is not '1'" SEVERITY error;
      --******************************************************************************************************************




      --*******************************************************************************************************************
      -- Test Case - 10 ****************************************************************************************************

      -- This is the case where there is a conditional branch in decode and prediction bit is taken, but there is a data hazard
      --prediction bit here is 1
      branched_in_decode <= '0';
      a_branch_instruction_is_in_decode <= '1';
      a_branch_instruction_is_in_execute <= '0';
      decode_branch_conditional <= '1';
      any_stall <= '0';
      can_branch <= '0';

      WAIT FOR clk_period;

      ASSERT will_branch_in_decode = '0' REPORT "Test case 10 decode, will_branch_in_decode is not '0'" SEVERITY error;
      ASSERT two_bit_PC_selector = "11" REPORT "Test case 10 decode, two_bit_PC_selector_signal is not '11'" SEVERITY error;
      ASSERT prediction_out = '1' REPORT "Test case 10 decode, prediction_out is not '1'" SEVERITY error;

      branched_in_decode <= '0';
      a_branch_instruction_is_in_execute <= '1';
      a_branch_instruction_is_in_decode <= '0';
      execute_branch_conditional <= '1';
      any_stall <= '0';
      zero_flag <= '1';

      WAIT FOR clk_period;


      ASSERT two_bit_PC_selector = "01" REPORT "Test case 10 exec, two_bit_PC_selector_signal is not '10'" SEVERITY error;
      ASSERT prediction_out = '1' REPORT "Test case 10 exec, prediction_out is not '1'" SEVERITY error;
      --******************************************************************************************************************




      --*******************************************************************************************************************
      -- Test Case - 4 ****************************************************************************************************

      -- This is the case where i am in decode and predicting taken while there is no data hazard with a conditional branch
      --prediction bit here is 1
      branched_in_decode <= '0';
      a_branch_instruction_is_in_decode <= '1';
      a_branch_instruction_is_in_execute <= '0';
      decode_branch_conditional <= '1';
      any_stall <= '0';
      can_branch <= '1';

      WAIT FOR clk_period;

      ASSERT will_branch_in_decode = '1' REPORT "Test case 4 decode, will_branch_in_decode is not '1'" SEVERITY error;
      ASSERT two_bit_PC_selector = "00" REPORT "Test case 4 decode, two_bit_PC_selector_signal is not '00'" SEVERITY error;
      ASSERT prediction_out = '1' REPORT "Test case 4 decode, prediction_out is not '1'" SEVERITY error;
      -- Now the branch instruction will be in the execute, and i predicted wrong (not taken)
      --prediction bit here is 1
      branched_in_decode <= '1';
      a_branch_instruction_is_in_execute <= '1';
      a_branch_instruction_is_in_decode <= '0';
      execute_branch_conditional <= '1';
      any_stall <= '0';
      zero_flag <= '0';

      WAIT FOR clk_period;

      ASSERT two_bit_PC_selector = "10" REPORT "Test case 4 exec, two_bit_PC_selector_signal is not '10'" SEVERITY error;
      ASSERT prediction_out = '0' REPORT "Test case 4 exec, prediction_out is not '0'" SEVERITY error;

      --*******************************************************************************************************************




      --*******************************************************************************************************************
      -- Test Case - 5 ****************************************************************************************************

      -- This is the case where there is a branch instruction in decode and a branch instruction in execute (two not taken branches)
      -- I am predicting not taken and i am correct, so after execute i will have to look into the decode (selectors always 11)
      --prediction bit here is 0
      branched_in_decode <= '0';
      a_branch_instruction_is_in_decode <= '1';
      a_branch_instruction_is_in_execute <= '1';
      zero_flag <= '0';
      decode_branch_conditional <= '1';
      execute_branch_conditional <= '1';
      any_stall <= '0';
      can_branch <= '1';

      WAIT FOR clk_period;

      ASSERT will_branch_in_decode = '0' REPORT "Test case 5 decode, will_branch_in_decode is not '0'" SEVERITY error;
      ASSERT two_bit_PC_selector = "11" REPORT "Test case 5 decode, two_bit_PC_selector_signal is not '11'" SEVERITY error;
      ASSERT prediction_out = '0' REPORT "Test case 5 decode, prediction_out is not '0'" SEVERITY error;

      --*******************************************************************************************************************




      --*******************************************************************************************************************
      -- Test Case - 6 ****************************************************************************************************

      -- This is the case where there is a branch instruction in decode and a branch instruction in execute
      -- I am predicted not taken and i am correct in execute, so after execute i will have to look into the decode and i will have an unconditional branch there
      --prediction bit here is 0
      branched_in_decode <= '0';
      a_branch_instruction_is_in_decode <= '1';
      a_branch_instruction_is_in_execute <= '1';
      zero_flag <= '0';
      decode_branch_conditional <= '0';
      execute_branch_conditional <= '1';
      any_stall <= '0';
      can_branch <= '1';

      WAIT FOR clk_period;


      ASSERT will_branch_in_decode = '1' REPORT "Test case 6 decode, will_branch_in_decode is not '1'" SEVERITY error;
      ASSERT two_bit_PC_selector = "00" REPORT "Test case 6 decode, two_bit_PC_selector_signal is not '00'" SEVERITY error;
      ASSERT prediction_out = '0' REPORT "Test case 6 decode, prediction_out is not '0'" SEVERITY error;

      --*******************************************************************************************************************




      --*******************************************************************************************************************
      -- Test Case - 7 ****************************************************************************************************

      -- This is the case where there is an unconditional branch in decode and there is no data hazard
      --prediction bit here is 0
      branched_in_decode <= '0';
      a_branch_instruction_is_in_decode <= '1';
      a_branch_instruction_is_in_execute <= '0';
      decode_branch_conditional <= '0';
      any_stall <= '0';
      can_branch <= '1';

      WAIT FOR clk_period;

      ASSERT will_branch_in_decode = '1' REPORT "Test case 7 decode, will_branch_in_decode is not '1'" SEVERITY error;
      ASSERT two_bit_PC_selector = "00" REPORT "Test case 7 decode, two_bit_PC_selector_signal is not '00'" SEVERITY error;
      ASSERT prediction_out = '0' REPORT "Test case 7 decode, prediction_out is not '0'" SEVERITY error;

      --*******************************************************************************************************************




      --*******************************************************************************************************************
      -- Test Case - 8 ****************************************************************************************************

      -- This is the case where there is an unconditional branch in decode and there is a data hazard
      --prediction bit here is 0
      branched_in_decode <= '0';
      a_branch_instruction_is_in_decode <= '1';
      a_branch_instruction_is_in_execute <= '0';
      decode_branch_conditional <= '0';
      any_stall <= '0';
      can_branch <= '0';

      WAIT FOR clk_period;

      ASSERT will_branch_in_decode = '0' REPORT "Test case 8 decode, will_branch_in_decode is not '0'" SEVERITY error;
      ASSERT two_bit_PC_selector = "11" REPORT "Test case 8 decode, two_bit_PC_selector_signal is not '11'" SEVERITY error;
      ASSERT prediction_out = '0' REPORT "Test case 8 decode, prediction_out is not '0'" SEVERITY error;
      branched_in_decode <= '0';
      a_branch_instruction_is_in_decode <= '0';
      a_branch_instruction_is_in_execute <= '1';
      execute_branch_conditional <= '0';
      any_stall <= '0';

      WAIT FOR clk_period;

      ASSERT two_bit_PC_selector = "01" REPORT "Test case 8 decode, two_bit_PC_selector_signal is not '01'" SEVERITY error;
      ASSERT prediction_out = '0' REPORT "Test case 8 decode, prediction_out is not '0'" SEVERITY error;

      --*******************************************************************************************************************
      WAIT;
   END PROCESS;

END;