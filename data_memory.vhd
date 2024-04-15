LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY data_memory IS
    PORT (
        write_enable, read_enable, rst : IN STD_LOGIC;
        address : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        data_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        data_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );

END ENTITY data_memory;
ARCHITECTURE data_memory_design OF data_memory IS
    TYPE data_mem IS ARRAY (0 TO 4096) OF STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL memory : data_mem := (OTHERS => (OTHERS => '0'));
BEGIN
    PROCESS (rst, write_enable, read_enable, address, data_in)
    BEGIN
        IF rst = '1' THEN
            memory <= (OTHERS => (OTHERS => '0'));
        ELSIF write_enable = '1' THEN
            memory(to_integer(unsigned(address))) <= data_in(15 DOWNTO 0);
            memory(to_integer(unsigned(address)) + 1) <= data_in(31 DOWNTO 16);
        ELSIF read_enable = '1' THEN
            data_out <= memory(to_integer(unsigned(address)) + 1) & memory(to_integer(unsigned(address)));
        END IF;
    END PROCESS;
END ARCHITECTURE data_memory_design;