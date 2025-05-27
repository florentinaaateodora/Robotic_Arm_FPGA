library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm_generator is
    generic (
        CLK_FREQ   : integer := 50000000; -- Input clock frequency in Hz
        PWM_FREQ   : integer := 1000;     -- Desired PWM frequency in Hz
        DUTY_CYCLE : integer := 50        -- Duty cycle in percent (0 to 100)
    );
    port (
        clk      : in  std_logic;
        rst      : in  std_logic;
        pwm_out  : out std_logic
    );
end pwm_generator;

architecture Behavioral of pwm_generator is
    constant PERIOD_COUNT : integer := CLK_FREQ / PWM_FREQ;
    constant HIGH_COUNT   : integer := (DUTY_CYCLE * PERIOD_COUNT) / 100;
    signal counter        : integer range 0 to PERIOD_COUNT - 1 := 0;
    signal pwm_reg        : std_logic := '0';
begin

    process(clk, rst)
    begin
        if rst = '1' then
            counter <= 0;
            pwm_reg <= '0';
        elsif rising_edge(clk) then
            if counter = PERIOD_COUNT - 1 then
                counter <= 0;
            else
                counter <= counter + 1;
            end if;

            if counter < HIGH_COUNT then
                pwm_reg <= '1';
            else
                pwm_reg <= '0';
            end if;
        end if;
    end process;

    pwm_out <= pwm_reg;

end Behavioral;