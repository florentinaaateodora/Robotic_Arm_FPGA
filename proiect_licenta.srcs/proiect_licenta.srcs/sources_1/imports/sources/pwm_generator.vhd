library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm_generator is
    generic (
        CLK_FREQ : integer := 50000000  -- 50 MHz input clock
    );
    port (
        clk         : in  std_logic;
        rst         : in  std_logic;
        pulse_width : in  integer range 125000 to 250000; --  clock cycles (1ms-2ms)
        pwm_out     : out std_logic
    );
end pwm_generator;

architecture Behavioral of pwm_generator is
    
    constant PERIOD_COUNT : integer := CLK_FREQ / 50;  -- 20 ms period
    signal counter        : integer range 0 to PERIOD_COUNT := 0;
    signal pwm_reg        : std_logic := '0';
begin

    process(clk, rst)
    begin
        if rst = '1' then
            counter  <= 0;
            pwm_reg  <= '0';
        elsif rising_edge(clk) then
            if counter >= PERIOD_COUNT then
                counter <= 0;
            else
                counter <= counter + 1;
            end if;

            if counter < pulse_width then
                pwm_reg <= '1';
            else
                pwm_reg <= '0';
            end if;
        end if;
    end process;

    pwm_out <= pwm_reg;

end Behavioral;
