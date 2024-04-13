library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sign_extend is
    port (
        instruction_in: in std_logic_vector(15 downto 0);
        instruction_out: out std_logic_vector(31 downto 0)
    );
end entity sign_extend;

architecture Behavioral of sign_extend is
begin
    instruction_out <= instruction_in & (instruction_in(15) & others => instruction_in(15));
end Behavioral;