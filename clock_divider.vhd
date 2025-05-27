library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock_divider is port(
     i_clk_in       : in    std_logic; 
	 o_clk_out      : out   std_logic 
	 );    
end clock_divider;

architecture clock_divider of clock_divider is
     constant DIVIDER : integer := 2_500_000;  
	 signal r_counter : integer range 0 to DIVIDER;
	 signal r_clk_out : std_logic := '0'; -- ara deðiþken 
begin
     process(i_clk_in) is begin
	     if(rising_edge(i_clk_in)) then
		     if(r_counter = (DIVIDER-1)) then
			     r_counter <= 0;
				  r_clk_out <= not r_clk_out; --counter MAXV degerine ulastýgýnda CLK2 toggle eder
			  else
			     r_counter <= r_counter +1;	  
			  end if;
		  end if;
	  end process;
    o_clk_out <= r_clk_out;
end clock_divider;