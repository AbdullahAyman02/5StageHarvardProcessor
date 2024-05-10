LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY BranchingController_tb IS
END BranchingController_tb;

ARCHITECTURE behavior OF BranchingController_tb IS 

    COMPONENT BranchingController
    PORT(
         Decode_Branch : IN  std_logic;
         Decode_Conditional : IN  std_logic;
         Execute_Branch : IN  std_logic;
         Execute_Conditional : IN  std_logic;
         Can_Branch : IN  std_logic;
         Zero_Flag : IN  std_logic;
         Branched_In_Decode : IN  std_logic;
         Prediction : OUT  std_logic;
         Branch : OUT  std_logic;
         Selectors : OUT  std_logic_vector(1 downto 0);
         Branching_In_Decode : OUT  std_logic
        );
    END COMPONENT;


   signal Decode_Branch : std_logic := '0';
   signal Decode_Conditional : std_logic := '0';
   signal Execute_Branch : std_logic := '0';
   signal Execute_Conditional : std_logic := '0';
   signal Can_Branch : std_logic := '0';
   signal Zero_Flag : std_logic := '0';
   signal Branched_In_Decode : std_logic := '0';


   signal Prediction : std_logic;
   signal Branch : std_logic;
   signal Selectors : std_logic_vector(1 downto 0);
   signal Branching_In_Decode : std_logic;

BEGIN


   uut: BranchingController PORT MAP (
          Decode_Branch => Decode_Branch,
          Decode_Conditional => Decode_Conditional,
          Execute_Branch => Execute_Branch,
          Execute_Conditional => Execute_Conditional,
          Can_Branch => Can_Branch,
          Zero_Flag => Zero_Flag,
          Branched_In_Decode => Branched_In_Decode,
          Prediction => Prediction,
          Branch => Branch,
          Selectors => Selectors,
          Branching_In_Decode => Branching_In_Decode
        );


   stim_proc: process
   begin		
     
      wait for 100 ns;	

   

      

      wait;
   end process;

END;