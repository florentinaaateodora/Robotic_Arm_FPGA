library IEEE;
library STD;
use IEEE.STD_LOGIC_1164.ALL;
use STD.ENV.ALL;

entity TB_TOP is
end TB_TOP;

architecture Behavioral of TB_TOP is

component TOP is
  Port (
    i_clk       : in    std_logic;
    i_reset     : in    std_logic;
    i_btn_0     : in    std_logic;
    i_btn_1     : in    std_logic;
    i_sw_0      : in    std_logic;
    i_sw_1      : in    std_logic;
    o_pwm_0     : out   std_logic;
    o_pwm_1     : out   std_logic;
    o_pwm_2     : out   std_logic;
    o_pwm_3     : out   std_logic
  );
end component;

    signal tb_i_clk   : std_logic;
    signal tb_i_reset : std_logic;
    signal tb_i_btn_0 : std_logic;
    signal tb_i_btn_1 : std_logic;
    signal tb_i_sw_0  : std_logic;
    signal tb_i_sw_1  : std_logic;
    signal tb_o_pwm_0 : std_logic;
    signal tb_o_pwm_1 : std_logic;
    signal tb_o_pwm_2 : std_logic;
    signal tb_o_pwm_3 : std_logic;
    
    -- Clock period
    constant CLK_PERIOD : time := 8 ns; -- 125 MHz clock

begin

    UUT: TOP 
    port map(
      i_clk   => tb_i_clk  ,
      i_reset => tb_i_reset,
      i_btn_0 => tb_i_btn_0,
      i_btn_1 => tb_i_btn_1,
      i_sw_0  => tb_i_sw_0 ,
      i_sw_1  => tb_i_sw_1 ,
      o_pwm_0 => tb_o_pwm_0,
      o_pwm_1 => tb_o_pwm_1,
      o_pwm_2 => tb_o_pwm_2,
      o_pwm_3 => tb_o_pwm_3
      );

    -- Clock generation
    clk_process : process
    begin
        while true loop
            tb_i_clk <= '0';
            wait for CLK_PERIOD / 2;
            tb_i_clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;
    
    stim_proc : process
    begin
        tb_i_reset      <= '0';
       
        ---------------------------------------------------------------------------------------
        tb_i_sw_0       <= '0';     -- SELECT MOTOR 0
        tb_i_sw_1       <= '0';     -- SELECT MOTOR 0
        
        -- CONTROL MOTOR 0
        tb_i_btn_0      <= '0';
        tb_i_btn_1      <= '0';
        wait for 200 ms;
        
        tb_i_btn_0      <= '0';
        tb_i_btn_1      <= '1';
        wait for 200 ms;
        
        tb_i_btn_0      <= '0';
        tb_i_btn_1      <= '0';
        wait for 100 ms;
        
        tb_i_btn_0      <= '1';
        tb_i_btn_1      <= '0';
        wait for 200 ms;
        
        tb_i_btn_0      <= '0';
        tb_i_btn_1      <= '0';
        wait for 100 ms;
        --------------------------------------------------------------------------------------- 
        
        ---------------------------------------------------------------------------------------
        tb_i_sw_0       <= '0';     -- SELECT MOTOR 1
        tb_i_sw_1       <= '1';     -- SELECT MOTOR 1
        
        -- CONTROL MOTOR 1
        tb_i_btn_0      <= '0';
        tb_i_btn_1      <= '0';
        wait for 200 ms;
        
        tb_i_btn_0      <= '0';
        tb_i_btn_1      <= '1';
        wait for 200 ms;
        
        tb_i_btn_0      <= '0';
        tb_i_btn_1      <= '0';
        wait for 100 ms;
        
        tb_i_btn_0      <= '1';
        tb_i_btn_1      <= '0';
        wait for 200 ms;
        
        tb_i_btn_0      <= '0';
        tb_i_btn_1      <= '0';
        wait for 100 ms;
        ---------------------------------------------------------------------------------------
        
        ---------------------------------------------------------------------------------------
        tb_i_sw_0       <= '1';     -- SELECT MOTOR 2
        tb_i_sw_1       <= '0';     -- SELECT MOTOR 2
        
        -- CONTROL MOTOR 2
        tb_i_btn_0      <= '0';
        tb_i_btn_1      <= '0';
        wait for 200 ms;
        
        tb_i_btn_0      <= '0';
        tb_i_btn_1      <= '1';
        wait for 200 ms;
        
        tb_i_btn_0      <= '0';
        tb_i_btn_1      <= '0';
        wait for 100 ms;
        
        tb_i_btn_0      <= '1';
        tb_i_btn_1      <= '0';
        wait for 200 ms;
        
        tb_i_btn_0      <= '0';
        tb_i_btn_1      <= '0';
        wait for 100 ms;
        ---------------------------------------------------------------------------------------
        
        ---------------------------------------------------------------------------------------
        tb_i_sw_0       <= '1';     -- SELECT MOTOR 3
        tb_i_sw_1       <= '1';     -- SELECT MOTOR 3
        
        -- CONTROL MOTOR 3
        tb_i_btn_0      <= '0';
        tb_i_btn_1      <= '0';
        wait for 200 ms;
        
        tb_i_btn_0      <= '0';
        tb_i_btn_1      <= '1';
        wait for 200 ms;
        
        tb_i_btn_0      <= '0';
        tb_i_btn_1      <= '0';
        wait for 100 ms;
        
        tb_i_btn_0      <= '1';
        tb_i_btn_1      <= '0';
        wait for 200 ms;
        
        tb_i_btn_0      <= '0';
        tb_i_btn_1      <= '0';
        wait for 100 ms;
        ---------------------------------------------------------------------------------------  

        
        
        -- assert false report "Simulation finished" severity failure;
        finish(0);  -- End simulation
    end process;


end Behavioral;
