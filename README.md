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


<img width="1920" height="1080" alt="maxlec_digital_safe_diagram_block" src="https://github.com/user-attachments/assets/749b914e-2158-4d42-b0e4-715eb6b1e2fc" />


digital_safe_top_tb simulation

<img width="1078" height="547" alt="digital_safe_top_tb" src="https://github.com/user-attachments/assets/5d25bebe-527d-469d-8fa1-010dc4757d3c" />

safe_core_tb simulation

<img width="1079" height="563" alt="safe_core_tb" src="https://github.com/user-attachments/assets/ff1b91ae-5e73-4185-8ab5-57503a6aa0ff" />

display_4digit_tb simulation

<img width="1112" height="236" alt="display_4digit_tb" src="https://github.com/user-attachments/assets/29457af5-9e53-4854-bdbf-7f83193bdfea" />



