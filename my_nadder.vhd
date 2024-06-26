LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY my_nadder IS
    GENERIC (n : INTEGER := 32);
    PORT (
        a, b : IN STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        cin : IN STD_LOGIC;
        s : OUT STD_LOGIC_VECTOR(n - 1 DOWNTO 0);
        cout, overflow : OUT STD_LOGIC);
END my_nadder;

ARCHITECTURE a_my_adder OF my_nadder IS
    COMPONENT my_adder IS
        PORT (
            a, b, cin : IN STD_LOGIC;
            s, cout : OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL temp : STD_LOGIC_VECTOR(n DOWNTO 0);
BEGIN

    temp(0) <= cin;
    loop1 : FOR i IN 0 TO n - 1 GENERATE
        fx : my_adder PORT MAP(a(i), b(i), temp(i), s(i), temp(i + 1));
    END GENERATE;
    with cin select
            cout <= temp(n) WHEN '0',
            not temp(n) WHEN OTHERS;
    overflow <= temp(n) XOR temp(n - 1);
END a_my_adder;