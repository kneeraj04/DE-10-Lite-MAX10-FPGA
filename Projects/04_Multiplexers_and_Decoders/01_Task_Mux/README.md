# Project 04 – 4-to-1 Multiplexer using VHDL and Schematic Design on DE10-Lite FPGA

## Objective

The objective of this project is to design and implement a **4-to-1 Multiplexer (MUX)** on the Terasic DE10-Lite FPGA board using two different design approaches:

1. **VHDL RTL Implementation** using behavioral modeling.
2. **Schematic/Block Diagram Implementation** using basic logic gates.

This project demonstrates how a multiplexer selects one of multiple input signals based on select lines and routes the selected input to a single output.

---

# Hardware Used

- Terasic DE10-Lite FPGA Board
- Intel MAX 10 FPGA
- Quartus Prime Lite 16.1
- VHDL
- Quartus Block Diagram/Schematic Editor

---

# Theory

A **Multiplexer (MUX)** is a combinational logic circuit that selects one input from multiple inputs and forwards the selected signal to a single output.

A **4-to-1 Multiplexer** consists of:

- 4 Data Inputs (I0, I1, I2, I3)
- 2 Select Inputs (S1, S0)
- 1 Output (Y)

The select inputs determine which input signal appears at the output.

---

## Truth Table

| S1 | S0 | Selected Input | Output (Y) |
|:--:|:--:|:--------------:|:----------:|
| 0 | 0 | I0 | I0 |
| 0 | 1 | I1 | I1 |
| 1 | 0 | I2 | I2 |
| 1 | 1 | I3 | I3 |

---

# Implementation 1: VHDL RTL Design

## VHDL Description

The 4-to-1 multiplexer was implemented using VHDL behavioral modeling.

The design uses:

- A combinational process block
- A `case` statement for input selection
- Select lines to control the output path

The VHDL design:

- Reads the two select inputs (S1 and S0)
- Selects one of the four input signals (I0–I3)
- Sends the selected input to the output LED

---

## VHDL Block Diagram

```
             Select Lines

                S1 S0
                 |
                 |
        +----------------+
        |                |
I0 ---->|                |
I1 ---->|                |
I2 ---->|    4:1 MUX     |---- Y ----> LEDR0
I3 ---->|                |
        |                |
        +----------------+

```

---

# Implementation 2: Schematic / Block Diagram Design

## Description

The same 4-to-1 multiplexer was implemented using Quartus Prime **Block Diagram/Schematic Editor**.

The circuit was created using:

- NOT gates
- AND gates
- OR gate

This implementation represents the actual hardware logic behind the multiplexer.

---

## Gate-Level Logic Equation

The Boolean expression of the 4-to-1 MUX is:

```
Y = I0.S1'.S0'
  + I1.S1'.S0
  + I2.S1.S0'
  + I3.S1.S0
```

---

## Schematic Block Diagram

```

              S1 ----------------+
                                 |
                               +-----+
                               | NOT |
                               +-----+
                                 |
                                S1'


              S0 ----------------+
                                 |
                               +-----+
                               | NOT |
                               +-----+
                                 |
                                S0'


 SW0 (I0) --------+
                  |
                  |
                 AND --------+
                  |          |
 S1' -------------+          |
                             |
 S0' ------------------------|
                             |
                             |
 SW1 (I1) --------+          |
                  |          |
                 AND --------|
                  |
 S1' -------------+
                  |
 S0 --------------+


 SW2 (I2) --------+
                  |
                 AND --------|
                  |
 S1 --------------+
                  |
 S0' -------------+


 SW3 (I3) --------+
                  |
                 AND --------+
                  |
 S1 --------------+
                  |
 S0 --------------+


                 +-------------+
                 |             |
                 |  OR Gate    |
                 |             |
                 +-------------+
                       |
                       |
                       Y
                       |
                    LEDR0


```

---

# FPGA Pin Assignments

## Input Assignment

| FPGA Switch | Signal | Description |
|-------------|--------|-------------|
| SW0 | I0 | Data Input 0 |
| SW1 | I1 | Data Input 1 |
| SW2 | I2 | Data Input 2 |
| SW3 | I3 | Data Input 3 |
| SW4 | S0 | Select Line 0 |
| SW5 | S1 | Select Line 1 |

---

## Output Assignment

| FPGA LED | Signal | Description |
|----------|--------|-------------|
| LEDR0 | Y | Multiplexer Output |

---

# Hardware Verification

The design was tested on the DE10-Lite FPGA using onboard switches and LEDs.

The output LED follows the selected input signal.

| Select (S1 S0) | Selected Input | Expected Output |
|-----------------|----------------|-----------------|
| 00 | SW0 | LEDR0 follows SW0 |
| 01 | SW1 | LEDR0 follows SW1 |
| 10 | SW2 | LEDR0 follows SW2 |
| 11 | SW3 | LEDR0 follows SW3 |

### Example

```
S1 = 1
S0 = 0

Selected Input = SW2

If SW2 = ON
    LEDR0 = ON

If SW2 = OFF
    LEDR0 = OFF
```

---

# Key Learnings

- Understanding combinational logic circuits.
- Understanding the working principle of multiplexers.
- Implementing the same digital circuit using:
  - VHDL RTL design
  - Hardware schematic design
- Learning the difference between RTL abstraction and gate-level implementation.
- Using `case` statements for combinational logic in VHDL.
- Designing circuits using Quartus Block Diagram/Schematic Editor.
- Performing FPGA pin assignments using Pin Planner.
- Compiling, programming, and testing FPGA designs on real hardware.
- Understanding how select lines control data routing.

---

# Project Outcome

Successfully implemented and verified a **4-to-1 Multiplexer** on the DE10-Lite FPGA using:

1. **VHDL RTL Implementation**
2. **Schematic Gate-Level Implementation**

The output LED correctly represents the selected input signal based on the two select switches, demonstrating the functionality of a combinational multiplexer.

---