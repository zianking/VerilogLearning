set_property PACKAGE_PIN W19 [get_ports clk]
set_property PACKAGE_PIN F4 [get_ports rst_n]
set_property PACKAGE_PIN C2 [get_ports keyplus]
set_property PACKAGE_PIN B2 [get_ports keyminus]
set_property PACKAGE_PIN E2 [get_ports keysetzero]
set_property PACKAGE_PIN D2 [get_ports keysetnum]
set_property PACKAGE_PIN AA19 [get_ports startswitch]

set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports keyplus]
set_property IOSTANDARD LVCMOS33 [get_ports keyminus]
set_property IOSTANDARD LVCMOS33 [get_ports keysetzero]
set_property IOSTANDARD LVCMOS33 [get_ports keysetnum]
set_property IOSTANDARD LVCMOS33 [get_ports startswitch]

create_clock -period 20.000 -name sys_clk [get_ports clk]

set_property PACKAGE_PIN Y22 [get_ports uartout]
set_property IOSTANDARD LVCMOS33 [get_ports uartout]

set_property PACKAGE_PIN P17 [get_ports point]
set_property IOSTANDARD LVCMOS33 [get_ports point]

set_property PACKAGE_PIN R14 [get_ports {cs[0]}]
set_property PACKAGE_PIN R18 [get_ports {cs[1]}]
set_property PACKAGE_PIN T18 [get_ports {cs[2]}]
set_property PACKAGE_PIN N17 [get_ports {cs[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {cs[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cs[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cs[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cs[3]}]

# digitout = {a,b,c,d,e,f,g}

set_property PACKAGE_PIN N15 [get_ports {digitout[6]}]  ;# A
set_property PACKAGE_PIN R17 [get_ports {digitout[5]}]  ;# B
set_property PACKAGE_PIN P16 [get_ports {digitout[4]}]  ;# C
set_property PACKAGE_PIN N14 [get_ports {digitout[3]}]  ;# D
set_property PACKAGE_PIN N13 [get_ports {digitout[2]}]  ;# E
set_property PACKAGE_PIN R16 [get_ports {digitout[1]}]  ;# F
set_property PACKAGE_PIN P15 [get_ports {digitout[0]}]  ;# G

set_property IOSTANDARD LVCMOS33 [get_ports {digitout[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitout[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitout[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitout[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitout[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitout[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digitout[0]}]