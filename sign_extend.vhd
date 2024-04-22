library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sign_extend is
    port (
        func : in std_logic_vector(2 downto 0);
        instruction_in: in std_logic_vector(15 downto 0);
        instruction_out: out std_logic_vector(31 downto 0)
    );
end entity sign_extend;

architecture Behavioral of sign_extend is
    begin
        process(instruction_in, func)
        begin
            if func = "111" then
                instruction_out <= "0000000000000000" & instruction_in;
            else
                instruction_out <= (15 downto 0 => instruction_in(15)) & instruction_in;
            end if;
        end process;
    end Behavioral;