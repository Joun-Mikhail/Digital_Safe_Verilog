## Clock
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports {clk}];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk}];

## Buttons
set_property -dict { PACKAGE_PIN M18 IOSTANDARD LVCMOS33 } [get_ports {btnu}];
set_property -dict { PACKAGE_PIN P18 IOSTANDARD LVCMOS33 } [get_ports {btnd}];
set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports {btnc}];

## Switches SW0..SW3
set_property -dict { PACKAGE_PIN J15 IOSTANDARD LVCMOS33 } [get_ports {sw[0]}];
set_property -dict { PACKAGE_PIN L16 IOSTANDARD LVCMOS33 } [get_ports {sw[1]}];
set_property -dict { PACKAGE_PIN M13 IOSTANDARD LVCMOS33 } [get_ports {sw[2]}];
set_property -dict { PACKAGE_PIN R15 IOSTANDARD LVCMOS33 } [get_ports {sw[3]}];

## LEDs LED0..LED7
set_property PACKAGE_PIN H17 [get_ports {led[0]}];
set_property PACKAGE_PIN K15 [get_ports {led[1]}];
set_property PACKAGE_PIN J13 [get_ports {led[2]}];
set_property PACKAGE_PIN N14 [get_ports {led[3]}];
set_property PACKAGE_PIN R18 [get_ports {led[4]}];
set_property PACKAGE_PIN V17 [get_ports {led[5]}];
set_property PACKAGE_PIN U17 [get_ports {led[6]}];
set_property PACKAGE_PIN U16 [get_ports {led[7]}];
set_property IOSTANDARD LVCMOS33 [get_ports {led[*]}];

## Seven-segment cathodes CA..CG + DP (active-low)
## seg[6]=A ... seg[0]=G
set_property PACKAGE_PIN T10 [get_ports {seg[6]}];
set_property PACKAGE_PIN R10 [get_ports {seg[5]}];
set_property PACKAGE_PIN K16 [get_ports {seg[4]}];
set_property PACKAGE_PIN K13 [get_ports {seg[3]}];
set_property PACKAGE_PIN P15 [get_ports {seg[2]}];
set_property PACKAGE_PIN T11 [get_ports {seg[1]}];
set_property PACKAGE_PIN L18 [get_ports {seg[0]}];
set_property PACKAGE_PIN H15 [get_ports {dp}];
set_property IOSTANDARD LVCMOS33 [get_ports {seg[*] dp}];

## Seven-segment anodes AN7..AN0 (active-low)
set_property PACKAGE_PIN J17 [get_ports {an[0]}];
set_property PACKAGE_PIN J18 [get_ports {an[1]}];
set_property PACKAGE_PIN T9  [get_ports {an[2]}];
set_property PACKAGE_PIN J14 [get_ports {an[3]}];
set_property PACKAGE_PIN P14 [get_ports {an[4]}];
set_property PACKAGE_PIN T14 [get_ports {an[5]}];
set_property PACKAGE_PIN K2  [get_ports {an[6]}];
set_property PACKAGE_PIN U13 [get_ports {an[7]}];
set_property IOSTANDARD LVCMOS33 [get_ports {an[*]}];
## RGB LED17
set_property -dict { PACKAGE_PIN N16 IOSTANDARD LVCMOS33 } [get_ports {rgb_r}];
set_property -dict { PACKAGE_PIN R11 IOSTANDARD LVCMOS33 } [get_ports {rgb_g}];
set_property -dict { PACKAGE_PIN G14 IOSTANDARD LVCMOS33 } [get_ports {rgb_b}];


set_property -dict { PACKAGE_PIN C17 IOSTANDARD LVCMOS33 } [get_ports {RelayPin}];
