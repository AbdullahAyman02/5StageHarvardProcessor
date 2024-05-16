LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY branchingRegister IS
    PORT (
        clk : IN STD_LOGIC;
        taken_address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        not_taken_address : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        prediction_bit : IN STD_LOGIC;
        address_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );

END ENTITY branchingRegister;

ARCHITECTURE branchingRegisterDesign OF branchingRegister IS
BEGIN
    PROCESS (clk)
    BEGIN
        if rising_edge(clk) then
            if prediction_bit = '1' then
                address_out <= not_taken_address;
            else
                address_out <= taken_address ;
            end if;
        end if;
      
    END PROCESS;
END ARCHITECTURE branchingRegisterDesign;