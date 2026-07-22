# Project 02: Static Birth Date Display on 7-Segment Displays using VHDL

## Objective

The objective of this project is to display a fixed birth date on the six onboard 7-segment displays of the **Terasic DE10-Lite FPGA** using **VHDL**. This project introduces the basics of combinational logic design, FPGA output interfacing, and hardware pin assignment without requiring a clock signal.

**Display Format**

| HEX5 | HEX4 | HEX3 | HEX2 | HEX1 | HEX0 |
|:----:|:----:|:----:|:----:|:----:|:----:|
| Day (Tens) | Day (Ones) | Month (Tens) | Month (Ones) | Year (Tens) | Year (Ones) |

Example:

```
HEX5 HEX4   HEX3 HEX2   HEX1 HEX0
  2    8      0    7      9    9
```

Displays:

```
28-07-99
```

---

## VHDL Code Summary

The design consists of a single VHDL entity named **BirthDate_Display** with six 8-bit output ports corresponding to the six 7-segment displays available on the DE10-Lite board.

A reusable VHDL function named **SevenSeg()** is implemented to convert a decimal digit (0–9) into its corresponding **active-low 7-segment pattern**.

Each display output is assigned a constant value representing the desired birth date.

Key features include:

- Static combinational logic design
- Reusable digit-to-7-segment decoder function
- Active-low segment encoding
- Eight-bit output including the decimal point (DP)
- Simple and modular VHDL implementation

---

## Why is a Clock Not Used?

A clock signal is required only when designing **sequential logic**, such as counters, timers, registers, or finite state machines.

In this project, the displayed digits never change after FPGA configuration. Therefore, the outputs are constant values generated using **combinational logic**.

Since no timing-dependent operations are performed, a clock signal is **not required**.

---

## Pin Assignment Summary

Each 7-segment display on the DE10-Lite consists of **8 FPGA pins**:

- 7 segment LEDs (a–g)
- 1 Decimal Point (DP)

The project uses six output vectors:

| Signal | Description |
|---------|-------------|
| HEX0[7:0] | Year (Ones) |
| HEX1[7:0] | Year (Tens) |
| HEX2[7:0] | Month (Ones) |
| HEX3[7:0] | Month (Tens) |
| HEX4[7:0] | Day (Ones) |
| HEX5[7:0] | Day (Tens) |

The corresponding FPGA pins are assigned using the **Pin Planner** according to the **DE10-Lite User Manual**.

All pins use the following I/O standard:

- **3.3-V LVTTL**

---

## Key Learnings

After completing this project, the following FPGA and VHDL concepts were learned:

- Understanding the structure of a VHDL **Entity** and **Architecture**
- Creating reusable VHDL functions
- Designing combinational logic circuits
- Driving multiple 7-segment displays
- Understanding active-low display operation
- Using `STD_LOGIC_VECTOR` for hardware outputs
- Performing FPGA pin assignments using Quartus Prime Pin Planner
- Understanding the relationship between FPGA logic and physical hardware pins
- Compiling, programming, and verifying a VHDL design on the DE10-Lite FPGA board

---

## Hardware Used

- **FPGA Board:** Terasic DE10-Lite
- **FPGA Device:** Intel MAX10 (10M50DAF484C7G)
- **Development Software:** Quartus Prime Lite 16.1
- **Hardware Description Language:** VHDL

---

## Project Outcome

After programming the FPGA, the six onboard 7-segment displays continuously show the configured birth date without requiring any external inputs or clock signal.

This project serves as an introduction to FPGA output interfacing and lays the foundation for future projects involving switches, push buttons, counters, multiplexing, and sequential digital logic.