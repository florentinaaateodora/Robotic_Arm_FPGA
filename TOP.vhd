library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity TOP is
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
end TOP;

architecture Behavioral of TOP is

component clock_divider is 
port(
     i_clk_in       : in    std_logic; 
	 o_clk_out      : out   std_logic 
	 ); 
	 
end component; 	 
	 
component demux_4_1 is
port(
     i_sel           : in    std_logic_vector(1 downto 0);
     i_data_in       : in    std_logic;
     o_data_out_0    : out   std_logic;
     o_data_out_1    : out   std_logic;
     o_data_out_2    : out   std_logic;
     o_data_out_3    : out   std_logic
    );
  
 
end component;

component debounce_ff is
port(
        clk       : in  std_logic;   -- System clock
        noisy_in  : in  std_logic;   -- Raw button input
        clean_out : out std_logic    -- Debounced output
    );
    
end component; 

component pwm_generator is
    generic (
        CLK_FREQ    : integer := 50000000;
        PWM_FREQ    : integer := 1000;
        DUTY_CYCLE  : integer := 50 
    );
    port (
        clk          : in  std_logic;
        rst          : in  std_logic;
        --duty_cycle   : in  integer range 0 to 100;
        pwm_out      : out std_logic
    );    
    
    
end component;

    signal r_clk        : std_logic;
    
    signal r_btn_0_1    : std_logic;
    signal r_btn_0_2    : std_logic;
    
    signal r_btn_1_1    : std_logic;
    signal r_btn_1_2    : std_logic;
    
    signal r_sw_0_1     : std_logic;
    signal r_sw_0_2     : std_logic;
    
    signal r_sw_1_1     : std_logic;
    signal r_sw_1_2     : std_logic;
    
    signal r_sel        : std_logic_vector(1 downto 0);
    signal r_data_in    : std_logic;
    
    
    signal duty_counter     : integer range 0 to 100 := 7; 
    signal pwm_out          : std_logic;
    signal pwm_out_sig      : std_logic;



begin

process(i_clk)
    variable btn_0_last : std_logic := '0';
    variable btn_1_last : std_logic := '0';
begin
    if rising_edge(i_clk) then
        if i_reset = '1' then
            duty_counter <= 7;
        elsif (r_btn_0_2 = '1' and btn_0_last = '0') then
            if duty_counter < 100 then
                duty_counter <= duty_counter + 1;
            end if;
        elsif (r_btn_1_2 = '1' and btn_1_last = '0') then
            if duty_counter > 0 then
                duty_counter <= duty_counter - 1;
            end if;
        end if;

        -- Memorăm starea anterioară a butoanelor
        btn_0_last := r_btn_0_2;
        btn_1_last := r_btn_1_2;
    end if;
end process;


clock_divider_inst : clock_divider
port map (
    i_clk_in        => i_clk,
    o_clk_out       => r_clk
);

debounce_inst_btn_0_1: debounce_ff
port map(
    clk       => i_clk,
    noisy_in  => i_btn_0,
    clean_out => r_btn_0_1
);

debounce_inst_btn_0_2: debounce_ff
port map(
    clk       => i_clk,
    noisy_in  => r_btn_0_1,
    clean_out => r_btn_0_2
);

debounce_inst_btn_1_1: debounce_ff
port map(
    clk       => i_clk,
    noisy_in  => i_btn_1,
    clean_out => r_btn_1_1
);

debounce_inst_btn_1_2: debounce_ff
port map(
    clk       => i_clk,
    noisy_in  => r_btn_1_1,
    clean_out => r_btn_1_2
);

debounce_inst_sw_0_1: debounce_ff
port map(
    clk       => i_clk,
    noisy_in  => i_sw_0,
    clean_out => r_sw_0_1
);

debounce_inst_sw_0_2: debounce_ff
port map(
    clk       => i_clk,
    noisy_in  => r_sw_0_1,
    clean_out => r_sw_0_2
);

debounce_inst_sw_1_1: debounce_ff
port map(
    clk       => i_clk,
    noisy_in  => i_sw_1,
    clean_out => r_sw_1_1
);

debounce_inst_sw_1_2: debounce_ff
port map(
    clk       => i_clk,
    noisy_in  => r_sw_1_1,
    clean_out => r_sw_1_2
);


r_sel <= r_sw_1_2 & r_sw_0_2;  -- MSB is sw_1, LSB is sw_0
--r_data_in <= pwm_out;

demux_inst : demux_4_1
port map (
    i_sel           => r_sel,
    i_data_in        => pwm_out_sig,
    o_data_out_0    => o_pwm_0,
    o_data_out_1    => o_pwm_1,
    o_data_out_2    => o_pwm_2,
    o_data_out_3    => o_pwm_3
);

pwm_inst : pwm_generator
    generic map (
        CLK_FREQ => 50000000,
        PWM_FREQ => 1000,
        DUTY_CYCLE => 50
    )
    port map (
        clk             => r_clk,
        rst             => i_reset,
        --duty_cycle      => duty_counter,
        pwm_out         => pwm_out_sig
    );
    
end Behavioral;
