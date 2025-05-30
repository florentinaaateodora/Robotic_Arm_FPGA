## Clock signal
set_property PACKAGE_PIN H16 [get_ports i_clk]
set_property IOSTANDARD LVCMOS33 [get_ports i_clk]
create_clock -period 20.0 [get_ports i_clk]   # 50 MHz = 20 ns period

## Buttons
set_property PACKAGE_PIN D19 [get_ports i_btn_0]
set_property IOSTANDARD LVCMOS33 [get_ports i_btn_0]
set_property PACKAGE_PIN D20 [get_ports i_btn_1]
set_property IOSTANDARD LVCMOS33 [get_ports i_btn_1]

set_property PACKAGE_PIN L19 [get_ports i_reset]
set_property IOSTANDARD LVCMOS33 [get_ports i_reset]

## Switches
set_property PACKAGE_PIN M20 [get_ports i_sw_0]
set_property IOSTANDARD LVCMOS33 [get_ports i_sw_0]
set_property PACKAGE_PIN M19 [get_ports i_sw_1]
set_property IOSTANDARD LVCMOS33 [get_ports i_sw_1]

## PWM outputs (servos)
set_property PACKAGE_PIN U10 [get_ports o_pwm_0]
set_property IOSTANDARD LVCMOS33 [get_ports o_pwm_0]

set_property PACKAGE_PIN T5 [get_ports o_pwm_1]
set_property IOSTANDARD LVCMOS33 [get_ports o_pwm_1]

set_property PACKAGE_PIN V11 [get_ports o_pwm_2]
set_property IOSTANDARD LVCMOS33 [get_ports o_pwm_2]

set_property PACKAGE_PIN W11 [get_ports o_pwm_3]
set_property IOSTANDARD LVCMOS33 [get_ports o_pwm_3]

set_property PACKAGE_PIN R14 [get_ports o_led_0]
set_property IOSTANDARD LVCMOS33 [get_ports o_led_0]
set_property PACKAGE_PIN P14 [get_ports o_led_1]
set_property IOSTANDARD LVCMOS33 [get_ports o_led_1]

