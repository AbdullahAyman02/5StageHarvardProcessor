Library ieee;
Use ieee.std_logic_1164.all;

ENTITY singleBitAdder IS     
          PORT( A,B,Cin : IN std_logic;                 
 		C,Cout : OUT std_logic); 
END singleBitAdder;

ARCHITECTURE struct_singleBitAdder OF singleBitAdder IS
BEGIN
	C <= A XOR B XOR Cin;            
	Cout <= (A AND B) or (Cin AND (A XOR B));
END struct_singleBitAdder;
