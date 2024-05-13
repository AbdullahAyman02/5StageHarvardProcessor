LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY branching_controller_tb IS
END branching_controller_tb;

ARCHITECTURE behavior OF branching_controller_tb IS

   COMPONENT branching_controller
      PORT (
         a_branch_instruction_is_in_decode : IN STD_LOGIC;
         a_branch_instruction_is_in_execute : IN STD_LOGIC;
         decode_branch_conditional : IN STD_LOGIC;
         execute_branch_conditional : IN STD_LOGIC;
         branched_in_decode : IN STD_LOGIC;
         can_branch : IN STD_LOGIC;
         zero_flag : IN STD_LOGIC;

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

   --Outputs
   SIGNAL prediction_out : STD_LOGIC;
   SIGNAL two_bit_PC_selector : STD_LOGIC_VECTOR(1 DOWNTO 0);
   SIGNAL will_branch_in_decode : STD_LOGIC;
   SIGNAL branch_out : STD_LOGIC;

BEGIN

   uut : branching_controller PORT MAP(
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
      branch_out => branch_out
   );
   stim_proc : PROCESS
   BEGIN

      WAIT FOR 100 ns;
      -- Test Case - 1 ************************************************************************************************

      -- This is the case where i am in decode and predicting not taken while there is no data hazard with a conditional branch
      --prediction bit here is zero by default
      branched_in_decode <= '0';
      a_branch_instruction_is_in_decode <= '1';
      decode_branch_conditional <= '1';
      can_branch <= '1';

      assert will_branch_in_decode = '0' report "Test case 1, will_branch_in_execute is not '0'" severity error;
      assert two_bit_PC_selector = "11" report "Test case 1, two_bit_PC_selector_signal is not '11'" severity error;
      assert prediction_out = '0' report "Test case 1, prediction_out is not '0'" severity error;
      WAIT FOR 100 ns;

      -- Now the branch instruction will be in the execute, and i predicted correct (not taken)
      --prediction bit here is zero by default
      branched_in_decode <= '0';
      a_branch_instruction_is_in_execute <= '1';
      execute_branch_conditional <= '1';
      zero_flag <= '0';

      assert will_branch_in_execute = '0' report "Test case 1, will_branch_in_execute is not '0'" severity error;
      assert two_bit_PC_selector = "11" report "Test case 1, two_bit_PC_selector_signal is not '11'" severity error;
      assert prediction_out = '0' report "Test case 1, prediction_out is not '0'" severity error;
      WAIT FOR 100 ns;

      --******************************************************************************************************************




      -- Test Case - 2 ****************************************************************************************************

      -- This is the case where i am in decode and predicting not taken while there is no data hazard with a conditional branch
      --prediction bit here is zero by default
      branched_in_decode <= '0';
      a_branch_instruction_is_in_decode <= '1';
      decode_branch_conditional <= '1';
      can_branch <= '1';

      assert will_branch_in_decode = '0' report "Test case 2, will_branch_in_execute is not '0'" severity error;
      assert two_bit_PC_selector = "11" report "Test case 2, two_bit_PC_selector_signal is not '11'" severity error;
      assert prediction_out = '0' report "Test case 2, prediction_out is not '0'" severity error;
      WAIT FOR 100 ns;
      -- Now the branch instruction will be in the execute, and i predicted wrong (taken)
      --prediction bit here is zero by default
      branched_in_decode <= '0';
      a_branch_instruction_is_in_execute <= '1';
      execute_branch_conditional <= '1';
      zero_flag <= '1';

      assert will_branch_in_execute = '1' report "Test case 2, will_branch_in_execute is not '0'" severity error;
      assert two_bit_PC_selector = "10" report "Test case 2, two_bit_PC_selector_signal is not '11'" severity error;
      assert prediction_out = '1' report "Test case 2, prediction_out is not '0'" severity error;
      WAIT FOR 100 ns;

      --*******************************************************************************************************************






      -- branched_in_decode <= '0';
      -- a_branch_instruction_is_in_decode <= '1';
      -- decode_branch_conditional <= '1';
      -- can_branch <= '0';

      -- -- will_branch_in_decode <= '0';
      -- -- two_bit_PC_selector_signal <= "11";
      -- -- prediction_out <= '0';
      -- -- was_there_a_data_hazard_in_decode <= '1';
      -- WAIT FOR 100 ns;

      -- branched_in_decode <= '0';
      -- a_branch_instruction_is_in_decode <= '1';
      -- decode_branch_conditional <= '0';
      -- can_branch <= '1';

      -- -- will_branch_in_decode <= '1';
      -- -- two_bit_PC_selector_signal <= "00";

      -- WAIT FOR 100 ns;

      -- branched_in_decode <= '0';
      -- a_branch_instruction_is_in_decode <= '1';
      -- decode_branch_conditional <= '0';
      -- can_branch <= '0';
      -- -- will_branch_in_decode <= '0';

      WAIT;
   END PROCESS;

END;