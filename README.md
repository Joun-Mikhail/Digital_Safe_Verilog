
# Digital Safe (Verilog FPGA Project)

## System description

This project implements a digital safe using Verilog on FPGA.

## Features

- Four digits pasword.
- Visual communication of the safe & password status with the user.

INPUTS

- 4-Switches to input each digits values on 4bits from 0 to F
- 3-Buttons to operate the system by the user
    Button-Up) Reset the system,
    Button-Center) Relock the safe,
    Button-Down) Confirm current digit input by the switches. 

OUTPUTS

- 4x7-Segments displays : Displays the LOCK/OPEN status.
- 4x7-Segments displays : Displays the current digit input value and password completion of each digits.
- 2xDebug LEDs : LED n°8 flag lock status of the safe, LED n°7 keep tracks of the error flag.
- RGB LED : A user friendly way to indicate the OPEN/LOCK status to the user thanks to color code ( where GREEN : OPEN / RED : LOCK).

## USER MANUAL

1) Reset the system to start a new input
2) Compsoe the first digit with the switchs
3) Confirm the digit value input
4) Repeat until the 4th digit
5) When confirming the 4th digit the system should display the safe OPEN/CLOSE status.

## Author & Roles
- John Heshmat [Password matching comparaison]
- Peter Shehata [Openning/Locking system]
- Maxime Lecomte [Input conversion block]

## Project poster

<img width="1074" height="761" alt="Capture d’écran 2026-05-05 194917" src="https://github.com/user-attachments/assets/aee75441-7c1b-4160-8957-fab52fcdd9c6" />

[Digital Safe Poster.pdf](https://github.com/user-attachments/files/27410918/Poster.A3.-.Copy.1.pdf)


## Block diagram
<img width="1920" height="1080" alt="Block_diagram_update" src="https://github.com/user-attachments/assets/881cf075-a41a-4580-9aa9-435092395ea5" />

### digital_safe_top_tb simulation
[digital_safe_top_tb.v](https://github.com/Joun-Mikhail/Digital_Safe_Verilog/blob/81bc66416f0062f3d8d901966933a745b3e02f25/Safe_Password_week4/Safe_Password_week4.srcs/sim_1/digital_safe_top_tb.v) 

<img width="1078" height="547" alt="digital_safe_top_tb" src="https://github.com/user-attachments/assets/5d25bebe-527d-469d-8fa1-010dc4757d3c" />

### safe_core_tb simulation

[safe_core_tb](https://github.com/Joun-Mikhail/Digital_Safe_Verilog/blob/81bc66416f0062f3d8d901966933a745b3e02f25/Safe_Password_week4/Safe_Password_week4.srcs/sim_1/safe_core_tb.v)

<img width="1079" height="563" alt="safe_core_tb" src="https://github.com/user-attachments/assets/ff1b91ae-5e73-4185-8ab5-57503a6aa0ff" />

### display_8digit_tb simulation

[display_8digiti_tb](https://github.com/Joun-Mikhail/Digital_Safe_Verilog/blob/81bc66416f0062f3d8d901966933a745b3e02f25/Safe_Password_week4/Safe_Password_week4.srcs/sim_1/display_4digit_tb.v)

<img width="1112" height="236" alt="display_4digit_tb" src="https://github.com/user-attachments/assets/29457af5-9e53-4854-bdbf-7f83193bdfea" />

##Resources_Report

<img width="1276" height="872" alt="utilization_1" src="https://github.com/user-attachments/assets/617ae29b-0889-40cf-bc96-54631b589614" />
<img width="1175" height="871" alt="utilization_2" src="https://github.com/user-attachments/assets/bca2fdba-8cb4-46ac-9e84-eb50e91c84eb" />



