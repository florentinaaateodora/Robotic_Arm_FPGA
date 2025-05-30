library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_pwm_generator is
end tb_pwm_generator;

architecture behavior of tb_pwm_generator is
    
    component pwm_generator is
    generic (
        CLK_FREQ : integer := 50000000  -- 50 MHz input clock
    );
    port (
        clk         : in  std_logic;
        rst         : in  std_logic;
        pulse_width : in  integer range 125000 to 250000; -- in clock cycles (1ms-2ms)
        pwm_out     : out std_logic
    );
    end component;

    -- Signals
    signal clk              : std_logic := '0';
    signal rst              : std_logic := '1';
    signal pulse_width      : integer := 125000;
    signal pwm_out          : std_logic;

    -- Clock period
    constant CLK_PERIOD : time := 8 ns; -- 125 MHz clock

begin

    -- Instantiate the PWM Generator
    UUT : pwm_generator
        generic map (
            CLK_FREQ   => 125_000_000
        )
        port map (
            clk                 => clk,
            rst                 => rst,
            pulse_width         => pulse_width,
            pwm_out             => pwm_out
        );

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Reset logic
    stim_proc : process
    begin
        -- Initial reset pulse
        wait for 100 ns;
        rst <= '0';

        -- Run simulation for a while
        wait for 200 ms;
        
        -- 1ms PWM
        pulse_width <= 125000; 
        wait for 200 ms;
        
        -- 1.5 ms PWM
        pulse_width <= 187500; 
        wait for 200 ms;
        
        -- 2 ms PWM
        pulse_width <= 250000; 
        wait for 200 ms;

        -- End simulation
        assert false report "Simulation finished" severity failure;
    end process;

end behavior;

