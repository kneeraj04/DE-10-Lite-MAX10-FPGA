# Project 03: Switch and Push Button Controlled LEDs using VHDL

## Objective

The objective of this project is to learn how to interface digital input devices with an FPGA using VHDL. The design reads the status of the slide switches (SW0–SW9) and push buttons (KEY0 and KEY1) on the Terasic DE10-Lite FPGA board and controls the onboard LEDs accordingly. This project introduces FPGA input/output ports, combinational logic, and the concepts of active HIGH and active LOW digital signals.

---

## Code Explanation Summary

The VHDL design implements simple combinational logic using concurrent signal assignments.

- **SW0–SW7** directly control **LEDR0–LEDR7**.
- **KEY0** controls **LEDR8**.
- **KEY1** controls **LEDR9**.
- Since the push buttons are **active LOW**, the `NOT` operator is used so that pressing a button turns the corresponding LED ON.
- The design does **not** use a clock because the LEDs update immediately whenever an input changes.

---

## FPGA Pin Assignments

### Slide Switches

| Signal | FPGA Pin |
|---------|----------|
| SW0 | PIN_C10 |
| SW1 | PIN_C11 |
| SW2 | PIN_D12 |
| SW3 | PIN_C12 |
| SW4 | PIN_A12 |
| SW5 | PIN_B12 |
| SW6 | PIN_A13 |
| SW7 | PIN_A14 |
| SW8 | PIN_B14 |
| SW9 | PIN_F15 |

### Push Buttons

| Signal | FPGA Pin |
|---------|----------|
| KEY0 | PIN_B8 |
| KEY1 | PIN_A7 |

### Red LEDs

| Signal | FPGA Pin |
|---------|----------|
| LEDR0 | PIN_A8 |
| LEDR1 | PIN_A9 |
| LEDR2 | PIN_A10 |
| LEDR3 | PIN_B10 |
| LEDR4 | PIN_D13 |
| LEDR5 | PIN_C13 |
| LEDR6 | PIN_E14 |
| LEDR7 | PIN_D14 |
| LEDR8 | PIN_A11 |
| LEDR9 | PIN_B11 |

> **I/O Standard:** 3.3-V LVTTL

---

## What is a Schmitt Trigger Circuit?

A **Schmitt Trigger** is an electronic circuit that converts noisy or slowly changing input signals into clean digital signals. It uses two different switching thresholds (called **hysteresis**) to eliminate false transitions caused by electrical noise or switch bouncing.

On the DE10-Lite FPGA board, the slide switches and push buttons pass through Schmitt Trigger input circuits before reaching the FPGA. This ensures reliable logic HIGH ('1') and logic LOW ('0') levels, resulting in stable input detection.

### Advantages

- Reduces switch bounce
- Improves noise immunity
- Produces clean digital signals
- Ensures reliable FPGA input operation

---

## Key Learnings

- Learned how to interface switches and push buttons with an FPGA.
- Understood FPGA input and output port declarations in VHDL.
- Implemented combinational logic using concurrent signal assignments.
- Learned the difference between **active HIGH** and **active LOW** digital inputs.
- Used the `NOT` operator to handle active LOW push buttons.
- Performed FPGA pin assignments using Quartus Prime Pin Planner.
- Learned the purpose of Schmitt Trigger circuits in digital hardware.
- Verified the design on the Terasic DE10-Lite FPGA development board.

---

## Hardware Used

- Terasic **DE10-Lite FPGA Development Board**
- Intel **MAX 10 FPGA**
- 10 Slide Switches (SW0–SW9)
- 2 Push Buttons (KEY0–KEY1)
- 10 Red LEDs (LEDR0–LEDR9)

---

## Tools Used

- Quartus Prime 16.1
- VHDL
- USB-Blaster
- Terasic DE10-Lite FPGA Board

---

## Project Outcome

After completing this project, you will understand how to read digital inputs from an FPGA development board and control output devices using combinational logic. This project serves as the foundation for implementing logic gates, multiplexers, finite state machines, counters, and other digital systems in future FPGA projects.