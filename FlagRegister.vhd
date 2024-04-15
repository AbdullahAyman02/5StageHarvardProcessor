Library ieee;
Use ieee.std_logic_1164.all;

Entity FLagRegister is
    Port (clk, reset, rti: in std_logic;
          alu_flag_in, rti_flag_in: in std_logic_vector(3 downto 0);
          flag_out: out std_logic_vector(3 downto 0)
          );
END FLagRegister;

Architecture FlagRegister_arch of FLagRegister is

Begin

Process(clk, reset)
Begin
    If reset = '1' Then
        flag_out <= "0000";
    elsif rising_edge(clk) then
        If rti = '1' Then
            flag_out <= rti_flag_in;
        Else
            flag_out <= alu_flag_in;
        End If;
    End If;
End Process;

End FlagRegister_arch;