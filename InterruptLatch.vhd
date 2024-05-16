LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY InterruptLatch IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Interrupt : IN STD_LOGIC;
        Stall : IN STD_LOGIC;
        From_ret_rti_counter : IN STD_LOGIC;
        Immediate_bit_from_fetch : IN STD_LOGIC;
        Branch : IN STD_LOGIC;
        -- Branched_from_decode : IN STD_LOGIC;
        -- Reset_previous_latch : OUT STD_LOGIC;
        Latched_interrupt : OUT STD_LOGIC
    );
END InterruptLatch;

ARCHITECTURE struct_InterruptLatch OF InterruptLatch IS
    SIGNAL any_stall : STD_LOGIC := '0';
BEGIN
    any_stall <= Stall OR From_ret_rti_counter OR Immediate_bit_from_fetch;
    PROCESS (Reset, CLK)
        VARIABLE Counter : STD_LOGIC := '1';
        VARIABLE Flushing : STD_LOGIC := '0';
        VARIABLE Stalling : STD_LOGIC := '0';
    BEGIN
        IF Reset = '1' THEN
            Latched_Interrupt <= '0';
            -- Reset_previous_latch <= '1';
        ELSIF falling_edge(CLK) THEN
            IF Flushing = '1' AND Branch = '0' THEN
                Flushing := '0';
            END IF;
            IF Stalling = '1' AND any_stall = '0' THEN
                Stalling := '0';
            END IF;
            IF Branch = '1' THEN
                Flushing := '1';
            END IF;
            IF any_stall = '1' THEN
                Stalling := '1';
            END IF;
        ELSIF rising_edge(CLK) THEN
            IF Interrupt = '1' THEN
                Latched_Interrupt <= '1';
                Counter := '0';
                -- Reset_previous_latch <= '1';
            ELSIF Counter = '0' THEN
                IF any_stall = '0' AND Branch = '0' AND Flushing = '0' AND Stalling = '0' THEN
                    Latched_Interrupt <= '0';
                    -- Reset_previous_latch <= '1';
                    Counter := '1';
                END IF;
                -- IF Counter = '0' AND (Branch = '1' OR (BRANCHED_FROM_DECODE = '0' AND BRANCH = '0') OR any_stall = '1') THEN
                --     Reset_previous_latch <= '0';
                -- END IF;
            END IF;
        END IF;
    END PROCESS;
END struct_InterruptLatch;