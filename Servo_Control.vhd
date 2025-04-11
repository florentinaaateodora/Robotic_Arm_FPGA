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
        servo1  : out STD_LOGIC; -- A5 (U10)
        servo2  : out STD_LOGIC; -- A4 (T5)
        servo3  : out STD_LOGIC; -- A3 (V11)
        servo4  : out STD_LOGIC  -- A2 (W11)
    );
end Servo_Control;

architecture Behavioral of Servo_Control is

    signal counter       : INTEGER range 0 to 2000000 := 0;
    signal pos_counter1  : INTEGER range 50000 to 250000 := 150000; -- Servo 1 position
    signal pos_counter2  : INTEGER range 50000 to 250000 := 150000; -- Servo 2 position
    signal pos_counter3  : INTEGER range 50000 to 250000 := 150000; -- Added: Servo 3 position
    signal pos_counter4  : INTEGER range 50000 to 250000 := 150000; -- Added: Servo 4 position
    signal pwm_signal1   : STD_LOGIC := '0';
    signal pwm_signal2   : STD_LOGIC := '0';
    signal pwm_signal3   : STD_LOGIC := '0'; -- Added: PWM for servo3
    signal pwm_signal4   : STD_LOGIC := '0'; -- Added: PWM for servo4

    signal btn0_prev, btn1_prev : STD_LOGIC := '0';

begin
    process(clk)
    begin
        if rising_edge(clk) then

            -- PWM time base counter
            if counter < 2000000 then
                counter <= counter + 1;
            else
                counter <= 0;
            end if;

            -- Edge detection for button presses
            if btn0 = '1' and btn0_prev = '0' then
                if sw1 = '0' and sw0 = '0' then
                    if pos_counter1 < 250000 then
                        pos_counter1 <= pos_counter1 + 10000;
                    end if;
                elsif sw1 = '0' and sw0 = '1' then
                    if pos_counter2 < 250000 then
                        pos_counter2 <= pos_counter2 + 10000;
                    end if;
                elsif sw1 = '1' and sw0 = '0' then -- Added
                    if pos_counter3 < 250000 then
                        pos_counter3 <= pos_counter3 + 10000;
                    end if;
                elsif sw1 = '1' and sw0 = '1' then -- Added
                    if pos_counter4 < 250000 then
                        pos_counter4 <= pos_counter4 + 10000;
                    end if;
                end if;
            end if;

            if btn1 = '1' and btn1_prev = '0' then
                if sw1 = '0' and sw0 = '0' then
                    if pos_counter1 > 50000 then
                        pos_counter1 <= pos_counter1 - 10000;
                    end if;
                elsif sw1 = '0' and sw0 = '1' then
                    if pos_counter2 > 50000 then
                        pos_counter2 <= pos_counter2 - 10000;
                    end if;
                elsif sw1 = '1' and sw0 = '0' then -- Added
                    if pos_counter3 > 50000 then
                        pos_counter3 <= pos_counter3 - 10000;
                    end if;
                elsif sw1 = '1' and sw0 = '1' then -- Added
                    if pos_counter4 > 50000 then
                        pos_counter4 <= pos_counter4 - 10000;
                    end if;
                end if;
            end if;

            -- Update previous button states
            btn0_prev <= btn0;
            btn1_prev <= btn1;

            -- PWM generation for all servos
            if counter < pos_counter1 then
                pwm_signal1 <= '1';
            else
                pwm_signal1 <= '0';
            end if;

            if counter < pos_counter2 then
                pwm_signal2 <= '1';
            else
                pwm_signal2 <= '0';
            end if;

            if counter < pos_counter3 then -- Added
                pwm_signal3 <= '1';
            else
                pwm_signal3 <= '0';
            end if;

            if counter < pos_counter4 then -- Added
                pwm_signal4 <= '1';
            else
                pwm_signal4 <= '0';
            end if;

        end if;
    end process;

    -- Assign PWM outputs to servo pins
    servo1 <= pwm_signal1; -- A5 (U10)
    servo2 <= pwm_signal2; -- A4 (T5)
    servo3 <= pwm_signal3; -- A3 (V11) -- Added
    servo4 <= pwm_signal4; -- A2 (W11) -- Added

end Behavioral;

