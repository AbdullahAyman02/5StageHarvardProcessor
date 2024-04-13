Library ieee;
Use ieee.std_logic_1164.all;

ENTITY nBitFullAdder IS
GENERIC (n: integer := 32);
	PORT (	A,B: IN std_logic_vector (n-1 DOWNTO 0);
		Cin: IN std_logic;
		C: OUT std_logic_vector (n-1 DOWNTO 0);
		Cout, Overflow: OUT std_logic);
END nBitFullAdder;

Architecture struct_nBitFullAdder of nBitFullAdder is
	COMPONENT singleBitAdder is
		PORT( 	A,B,Cin : IN std_logic;                 
 			C,Cout : OUT std_logic); 
	END COMPONENT;
	SIGNAL temp: std_logic_vector (n DOWNTO 0);
BEGIN
	temp(0) <= Cin;
	Loop1: FOR i IN 0 TO n-1 GENERATE
		fx: singleBitAdder PORT MAP (A(i),B(i),temp(i),C(i),temp(i+1));
	END GENERATE;
	Cout <= temp(n);
	Overflow <= temp(n) XOR temp(n-1);
END struct_nBitFullAdder;
