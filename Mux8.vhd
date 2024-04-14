Library ieee;
use ieee.std_logic_1164.all;

Entity Mux8 is 
    Port ( 
        in0, in1, in2, in3, in4, in5, in6, in7 : in std_logic_vector(31 downto 0);
        S : in std_logic_vector(2 downto 0);
        out : out std_logic_vector(31 downto 0)
    );
End Mux8;

Architecture Mux8_arch of Mux8 is

Begin
    with S select
        out <= in0 when "000",
               in1 when "001",
               in2 when "010",
               in3 when "011",
               in4 when "100",
               in5 when "101",
               in6 when "110",
               in7 when others;
End Mux8_arch;