# Digital Safe (Verilog FPGA Project)

## Description
This project implements a digital safe using Verilog on FPGA.
Four bits array input 

## Features
- Password input using switches
- Password verification
- Lock / Unlock system
- LED indication
- Four 7-segments display

OUTPUTS

Two leds to flag lock and open state of the lock
(?) add 7-seg to show current password state

INPUTS

Four switch to input a number up to 9, one relock/reset button, one enter button to validate current number input.

## Author & Roles
- John Heshmat [Password matching comparaison]
- Peter Shehata [Openning/Locking system]
- Maxime Lecomte [Input conversion block]

## Block diagram
<img width="1920" height="1080" alt="block_diagram_top_level" src="https://github.com/user-attachments/assets/0f9dd319-8498-430f-a99b-dabfab3c8640" />

### digital_safe_top_tb simulation
[digital_safe_top_tb.v](https://github.com/Joun-Mikhail/Digital_Safe_Verilog/blob/76d02d4a5872c8516e33f84956432781cfafeae6/Safe_password_week3/Safe_password_week3.srcs/sim_1/digital_safe_top_tb.v) 

<img width="1078" height="547" alt="digital_safe_top_tb" src="https://github.com/user-attachments/assets/5d25bebe-527d-469d-8fa1-010dc4757d3c" />

### safe_core_tb simulation

[safe_core_tb](https://github.com/Joun-Mikhail/Digital_Safe_Verilog/blob/76d02d4a5872c8516e33f84956432781cfafeae6/Safe_password_week3/Safe_password_week3.srcs/sim_1/safe_core_tb.v)

<img width="1079" height="563" alt="safe_core_tb" src="https://github.com/user-attachments/assets/ff1b91ae-5e73-4185-8ab5-57503a6aa0ff" />

### display_4digit_tb simulation

[display_4digiti_tb](https://github.com/Joun-Mikhail/Digital_Safe_Verilog/blob/76d02d4a5872c8516e33f84956432781cfafeae6/Safe_password_week3/Safe_password_week3.srcs/sim_1/display_4digit_tb.v)

<img width="1112" height="236" alt="display_4digit_tb" src="https://github.com/user-attachments/assets/29457af5-9e53-4854-bdbf-7f83193bdfea" />



