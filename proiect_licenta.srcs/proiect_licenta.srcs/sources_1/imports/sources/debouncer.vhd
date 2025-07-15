library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity debounce_ff is
    Port (
        clk       : in  std_logic;   -- System clock
        noisy_in  : in  std_logic;   -- Raw button input
        clean_out : out std_logic    -- Debounced output
    );
end debounce_ff;

architecture Behavioral of debounce_ff is
    signal ff0, ff1, ff2 : std_logic := '0';
begin

    process(clk)
    begin
        if rising_edge(clk) then
            ff0 <= noisy_in;
            ff1 <= ff0;
            ff2 <= ff1;
        end if;
    end process;

    clean_out <= ff1 and ff2;  -- Output only when stable for two cycles

end Behavioral;