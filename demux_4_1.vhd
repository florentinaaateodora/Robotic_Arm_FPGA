library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux_4_1 is
    Port(
        i_sel           : in    std_logic_vector(1 downto 0);
        i_data_in       : in    std_logic;
        o_data_out_0    : out   std_logic;
        o_data_out_1    : out   std_logic;
        o_data_out_2    : out   std_logic;
        o_data_out_3    : out   std_logic
    );
end demux_4_1;

architecture Behavioral of demux_4_1 is

begin

    o_data_out_0 <= i_data_in when i_sel = "00";
    o_data_out_1 <= i_data_in when i_sel = "01";
    o_data_out_2 <= i_data_in when i_sel = "10";
    o_data_out_3 <= i_data_in when i_sel = "11";

end Behavioral;
