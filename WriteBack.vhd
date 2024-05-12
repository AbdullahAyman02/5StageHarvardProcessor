Library ieee;
Use ieee.std_logic_1164.all;

Entity WriteBack is
    Port ( 
        mem_out: in STD_LOGIC_VECTOR (31 downto 0);
        alu_out: in STD_LOGIC_VECTOR (31 downto 0);
        Controls : in STD_LOGIC_VECTOR (4 downto 0);
        Int_Fsm : in STD_LOGIC;

        RegData1 : out std_logic_vector(31 downto 0);
        Rti : out std_logic;
        Ret_rti : out std_logic
    );
End WriteBack;

Architecture WriteBack_atch of WriteBack is
    Component Mux2 is
        GENERIC (n : INTEGER := 32);
        PORT (
		selector : IN STD_LOGIC;
		input1, input2 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		output : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
	);
    End Component;

Begin
    Rti <= (not Int_Fsm) and Controls(0);
    Ret_rti <= ((not Int_Fsm) and Controls(1) and (not Controls(0))) or (Controls(0) and Int_Fsm);

    Mux2_1 : Mux2 generic map(32) PORT MAP (Controls(4), alu_out, mem_out, RegData1);
End WriteBack_atch;