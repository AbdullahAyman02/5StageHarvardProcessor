library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

entity PC is
generic (n: integer := 32);
    port (
        rst, enable, clk: IN std_logic;
	    update: in std_logic_vector(n-1 downto 0);
        inst_address: OUT std_logic_vector(n-1 downto 0)
    );
end entity PC;

architecture programCounter of PC is
    SIGNAL curr_address: std_logic_vector(n-1 downto 0);
begin
    process(clk, rst)
    begin
        if rst = '1' then
            curr_address <= (others => '0');
        elsif rising_edge(clk) and enable='1' then
            curr_address <= update;
        end if;
    end process;

    inst_address <= curr_address;

end architecture programCounter;