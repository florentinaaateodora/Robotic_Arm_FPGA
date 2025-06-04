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

  
  signal r_clk            : std_logic;
  signal r_btn_0_1        : std_logic;
  signal r_btn_0_2        : std_logic;
  signal r_btn_1_1        : std_logic;
  signal r_btn_1_2        : std_logic;
  signal r_sw_0_1         : std_logic;
  signal r_sw_0_2         : std_logic;
  signal r_sw_1_1         : std_logic;
  signal r_sw_1_2         : std_logic;
  signal r_sel            : std_logic_vector(1 downto 0);

  
  signal pulse_width_sig  : integer range 125000 to 250000 := 150000;  
  signal pwm_out_sig      : std_logic;

  
  signal r_angle_0, r_angle_1, r_angle_2, r_angle_3 : integer range 0 to 180 := 90;

  
  signal r_btn_0_last, r_btn_1_last : std_logic := '0';
  

  
  component clock_divider
    port (
      i_clk_in  : in  std_logic;
      o_clk_out : out std_logic
    );
  end component;

  component pwm_generator
    generic (
      CLK_FREQ : integer := 50000000
    );
    port (
      clk         : in  std_logic;
      rst         : in  std_logic;
      pulse_width : in  integer range 125000 to 250000;
      pwm_out     : out std_logic
    );
  end component;

  component debounce_ff
    port (
      clk       : in  std_logic;
      noisy_in  : in  std_logic;
      clean_out : out std_logic
    );
  end component;

  component demux_4_1
    port (
      i_sel        : in  std_logic_vector(1 downto 0);
      i_data_in    : in  std_logic;
      o_data_out_0 : out std_logic;
      o_data_out_1 : out std_logic;
      o_data_out_2 : out std_logic;
      o_data_out_3 : out std_logic
    );
  end component;



begin

  
  clock_divider_inst : clock_divider
    port map (
      i_clk_in  => i_clk,
      o_clk_out => r_clk
    );

  
  debounce_inst_btn_0_1: debounce_ff 
    port map(
      clk => i_clk,
      noisy_in => i_btn_0, 
      clean_out => r_btn_0_1);
    
  debounce_inst_btn_0_2: debounce_ff 
    port map(
      clk => i_clk,
      noisy_in => r_btn_0_1, 
      clean_out => r_btn_0_2);
    
  debounce_inst_btn_1_1: debounce_ff 
    port map(
      clk => i_clk,
      noisy_in => i_btn_1, 
      clean_out => r_btn_1_1);
    
  debounce_inst_btn_1_2: debounce_ff 
    port map(
      clk => i_clk, 
      noisy_in => r_btn_1_1, 
      clean_out => r_btn_1_2);


    
  debounce_inst_sw_0_1 : debounce_ff 
    port map(
      clk => i_clk, 
      noisy_in => i_sw_0, 
      clean_out => r_sw_0_1);
    
  debounce_inst_sw_0_2 : debounce_ff 
    port map(
      clk => i_clk, 
      noisy_in => r_sw_0_1, 
      clean_out => r_sw_0_2);
    
  debounce_inst_sw_1_1 : debounce_ff 
    port map(
      clk => i_clk, 
      noisy_in => i_sw_1, 
      clean_out => r_sw_1_1);
    
  debounce_inst_sw_1_2 : debounce_ff 
    port map(
      clk => i_clk, 
      noisy_in => r_sw_1_1, 
      clean_out => r_sw_1_2);

  
  r_sel <= r_sw_1_2 & r_sw_0_2;

  
  demux_inst : demux_4_1
    port map (
      i_sel        => r_sel,
      i_data_in    => pwm_out_sig,
      o_data_out_0 => o_pwm_0,
      o_data_out_1 => o_pwm_1,
      o_data_out_2 => o_pwm_2,
      o_data_out_3 => o_pwm_3
    );

 
  pwm_inst : pwm_generator
    generic map (
      CLK_FREQ => 50000000  
    )
    port map (
      clk         => r_clk,
      rst         => i_reset,
      pulse_width => pulse_width_sig,
      pwm_out     => pwm_out_sig
    );

 
  process(r_clk)
  begin
    if rising_edge(r_clk) then
      if i_reset = '1' then
       
        r_angle_0 <= 90;
        r_angle_1 <= 90;
        r_angle_2 <= 90;
        r_angle_3 <= 90;

      else
        
        if (r_btn_0_2 = '1' and r_btn_0_last = '0') then
          case r_sel is
            when "00" => if r_angle_0 < 180 then r_angle_0 <= r_angle_0 + 1; end if;
            when "01" => if r_angle_1 < 180 then r_angle_1 <= r_angle_1 + 1; end if;
            when "10" => if r_angle_2 < 180 then r_angle_2 <= r_angle_2 + 1; end if;
            when "11" => if r_angle_3 < 180 then r_angle_3 <= r_angle_3 + 1; end if;
            when others => null;
          end case;
        end if;

        
        if (r_btn_1_2 = '1' and r_btn_1_last = '0') then
          case r_sel is
            when "00" => if r_angle_0 > 0 then r_angle_0 <= r_angle_0 - 1; end if;
            when "01" => if r_angle_1 > 0 then r_angle_1 <= r_angle_1 - 1; end if;
            when "10" => if r_angle_2 > 0 then r_angle_2 <= r_angle_2 - 1; end if;
            when "11" => if r_angle_3 > 0 then r_angle_3 <= r_angle_3 - 1; end if;
            when others => null;
          end case;
        end if;

        
        r_btn_0_last <= r_btn_0_2;
        r_btn_1_last <= r_btn_1_2;
      end if;
    end if;
  end process;

  
  process(r_sel, r_angle_0, r_angle_1, r_angle_2, r_angle_3)
  begin
    case r_sel is
      when "00" => pulse_width_sig <= 125000 + r_angle_0 * 695;
      when "01" => pulse_width_sig <= 125000 + r_angle_1 * 695;
      when "10" => pulse_width_sig <= 125000 + r_angle_2 * 695;
      when "11" => pulse_width_sig <= 125000 + r_angle_3 * 695;
      when others => pulse_width_sig <= 150000;
    end case;
  end process;

end Behavioral;


