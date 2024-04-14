LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Mux2 IS
	GENERIC (n : INTEGER := 32);
	PORT (
		selector : IN STD_LOGIC;
		input1, input2 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		output : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
	);
END Mux2;

ARCHITECTURE struct_Mux2 OF Mux2 IS
BEGIN
	output <= input1 WHEN selector = '0' ELSE
		input2;
END struct_Mux2;