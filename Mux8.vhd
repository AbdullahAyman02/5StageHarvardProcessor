
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Mux8 IS
	GENERIC (n : INTEGER := 32);
	PORT (
		selectors : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		input1, input2, input3, input4, input5, input6, input7, input8 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
		output : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
	);
END Mux8;

ARCHITECTURE struct_Mux8 OF Mux8 IS
	COMPONENT Mux2 IS
		GENERIC (n : INTEGER := 32);
		PORT (
			selector : IN STD_LOGIC;
			input1, input2 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
			output : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT Mux4 IS
		GENERIC (n : INTEGER := 32);
		PORT (
			selectors : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			input1, input2, input3, input4 : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
			output : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL x1, x2 : STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
BEGIN
	u0 : Mux4 GENERIC MAP(n) PORT MAP(selectors(1 DOWNTO 0), input1, input2, input3, input4, x1);
	u1 : Mux4 GENERIC MAP(n) PORT MAP(selectors(1 DOWNTO 0), input5, input6, input7, input8, x2);
	u2 : Mux2 GENERIC MAP(n) PORT MAP(selectors(2), x1, x2, output);

END struct_Mux8;