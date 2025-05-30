library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Servo_Control is
    Port (
        clk     : in STD_LOGIC;
        btn0    : in STD_LOGIC;
        btn1    : in STD_LOGIC;
        sw0     : in STD_LOGIC;
        sw1     : in STD_LOGIC;
        servo1  : out STD_LOGIC;
        servo2  : out STD_LOGIC;
        servo3  : out STD_LOGIC;
        servo4  : out STD_LOGIC
    );
end Servo_Control;

architecture Behavioral of Servo_Control is

    signal counter        : INTEGER range 0 to 2500000 := 0; -- 125MHz / 50Hz
    signal pos_counter1   : INTEGER range 50000 to 250000 := 150000;
    signal pos_counter2   : INTEGER range 50000 to 250000 := 150000;
    signal pos_counter3   : INTEGER range 50000 to 250000 := 150000;
    signal pos_counter4   : INTEGER range 50000 to 250000 := 150000;

    signal pwm_signal1    : STD_LOGIC := '0';
    signal pwm_signal2    : STD_LOGIC := '0';
    signal pwm_signal3    : STD_LOGIC := '0';
    signal pwm_signal4    : STD_LOGIC := '0';

    signal move_counter   : INTEGER range 0 to 625000 := 0; -- aprox. 5ms delay (125MHz/200)

begin
    process(clk)
    begin
        if rising_edge(clk) then

            -- PWM time base counter
            if counter < 2500000 then
                counter <= counter + 1;
            else
                counter <= 0;
            end if;

            -- PWM generation
          -- PWM generation pentru servo1
if counter < pos_counter1 then
    pwm_signal1 <= '1';
else
    pwm_signal1 <= '0';
end if;

-- PWM generation pentru servo2
if counter < pos_counter2 then
    pwm_signal2 <= '1';
else
    pwm_signal2 <= '0';
end if;

-- PWM generation pentru servo3
if counter < pos_counter3 then
    pwm_signal3 <= '1';
else
    pwm_signal3 <= '0';
end if;

-- PWM generation pentru servo4
if counter < pos_counter4 then
    pwm_signal4 <= '1';
else
    pwm_signal4 <= '0';
end if;

            -- Movement control limiter
            if move_counter < 625000 then  -- 5ms la 125MHz
                move_counter <= move_counter + 1;
            else
                move_counter <= 0;

                -- Continuous movement while button is held
                if btn0 = '1' then
                    if sw1 = '0' and sw0 = '0' then
                        if pos_counter1 < 250000 then
                            pos_counter1 <= pos_counter1 + 500;
                        end if;
                    elsif sw1 = '0' and sw0 = '1' then
                        if pos_counter2 < 250000 then
                            pos_counter2 <= pos_counter2 + 500;
                        end if;
                    elsif sw1 = '1' and sw0 = '0' then
                        if pos_counter3 < 250000 then
                            pos_counter3 <= pos_counter3 + 500;
                        end if;
                    elsif sw1 = '1' and sw0 = '1' then
                        if pos_counter4 < 250000 then
                            pos_counter4 <= pos_counter4 + 500;
                        end if;
                    end if;
                end if;

                if btn1 = '1' then
                    if sw1 = '0' and sw0 = '0' then
                        if pos_counter1 > 50000 then
                            pos_counter1 <= pos_counter1 - 500;
                        end if;
                    elsif sw1 = '0' and sw0 = '1' then
                        if pos_counter2 > 50000 then
                            pos_counter2 <= pos_counter2 - 500;
                        end if;
                    elsif sw1 = '1' and sw0 = '0' then
                        if pos_counter3 > 50000 then
                            pos_counter3 <= pos_counter3 - 500;
                        end if;
                    elsif sw1 = '1' and sw0 = '1' then
                        if pos_counter4 > 50000 then
                            pos_counter4 <= pos_counter4 - 500;
                        end if;
                    end if;
                end if;
            end if;

        end if;
    end process;
    
   --pt miscare mai rapida pot pune +/- 1000   mai sus la pos counter

    -- Assign PWM outputs to servo pins
    servo1 <= pwm_signal1;
    servo2 <= pwm_signal2;
    servo3 <= pwm_signal3;
    servo4 <= pwm_signal4;

end Behavioral;
