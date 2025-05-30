library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock_divider_50Hz is
    Port (
        clk_in    : in  STD_LOGIC;  -- 125 MHz clock
        clk_out   : out STD_LOGIC   -- 50 Hz output
    );
end clock_divider_50Hz;

architecture Behavioral of clock_divider_50Hz is
    signal counter : INTEGER range 0 to 2_499_999 := 0;  -- 2.5 million cycles for 50 Hz
    signal clk_50  : STD_LOGIC := '0';  -- Output clock at 50 Hz
begin
    process(clk_in)
    begin
        if rising_edge(clk_in) then
            if counter = 2_499_999 then
                counter <= 0;
                clk_50 <= not clk_50; -- Toggle output clock
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    clk_out <= clk_50;  -- Provide 50 Hz clock output
end Behavioral;
