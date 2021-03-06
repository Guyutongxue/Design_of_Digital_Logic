set_property PACKAGE_PIN L1 [get_ports {led_gy[15]}]
set_property PACKAGE_PIN P1 [get_ports {led_gy[14]}]
set_property PACKAGE_PIN N3 [get_ports {led_gy[13]}]
set_property PACKAGE_PIN P3 [get_ports {led_gy[12]}]
set_property PACKAGE_PIN U3 [get_ports {led_gy[11]}]
set_property PACKAGE_PIN W3 [get_ports {led_gy[10]}]
set_property PACKAGE_PIN V3 [get_ports {led_gy[9]}]
set_property PACKAGE_PIN V13 [get_ports {led_gy[8]}]
set_property PACKAGE_PIN V14 [get_ports {led_gy[7]}]
set_property PACKAGE_PIN U14 [get_ports {led_gy[6]}]
set_property PACKAGE_PIN U15 [get_ports {led_gy[5]}]
set_property PACKAGE_PIN W18 [get_ports {led_gy[4]}]
set_property PACKAGE_PIN V19 [get_ports {led_gy[3]}]
set_property PACKAGE_PIN U19 [get_ports {led_gy[2]}]
set_property PACKAGE_PIN E19 [get_ports {led_gy[1]}]
set_property PACKAGE_PIN U16 [get_ports {led_gy[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_gy[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_gy[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_gy[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_gy[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_gy[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_gy[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_gy[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_gy[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_gy[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_gy[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_gy[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_gy[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_gy[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_gy[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_gy[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_gy[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports clk_gy]
set_property IOSTANDARD LVCMOS33 [get_ports rst_gy]
set_property PACKAGE_PIN W5 [get_ports clk_gy]
set_property PACKAGE_PIN U18 [get_ports rst_gy]

create_clock -period 8.000 -name clk_pin_gy -waveform {0.000 4.000} [get_ports clk_gy]
set_input_delay -clock [get_clocks *] -min -0.500 [get_ports rst_gy]
set_output_delay -clock [get_clocks *] 0.000 [get_ports -filter { NAME =~  "*" && DIRECTION == "OUT" }]

