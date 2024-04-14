Library ieee;
use ieee.std_logic_1164.all;

Entity Mux2 is
    Port (
        A, B : in std_logic_vector(31 downto 0);
        S : in std_logic;
        C : out std_logic_vector(31 downto 0)
    );
End Mux2;

Architecture Mux2_arch of Mux2 is
begin
    C <= A when S = '0' else B;
end Mux2_arch;