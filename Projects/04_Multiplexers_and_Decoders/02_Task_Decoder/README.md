# Project 04 – Task 3: 2-to-4 Decoder using Schematic Design on DE10-Lite FPGA

## Objective

The objective of this project is to design and implement a **2-to-4 Decoder** using the **Quartus Prime Block Diagram/Schematic Editor** on the Terasic DE10-Lite FPGA board.

The project demonstrates the implementation of combinational logic using basic digital gates. The decoder converts a 2-bit binary input into one of four active output lines.

The design is created using:

- NOT gates
- AND gates

The final circuit is compiled, programmed into the FPGA, and verified using onboard switches and LEDs.

---

# Hardware Used

- Terasic DE10-Lite FPGA Board
- Intel MAX 10 FPGA
- Quartus Prime Lite 16.1
- Quartus Block Diagram/Schematic Editor

---

# Theory

A **Decoder** is a combinational logic circuit that converts binary information from input lines into a unique output line.

A **2-to-4 Decoder** consists of:

- 2 Input lines (A, B)
- 4 Output lines (Y0, Y1, Y2, Y3)

For every input combination, only one output becomes HIGH while all other outputs remain LOW. This type of output is called **one-hot encoding**.

---

# Truth Table

| B | A | Y0 | Y1 | Y2 | Y3 |
|:-:|:-:|:-:|:-:|:-:|:-:|
| 0 | 0 | 1 | 0 | 0 | 0 |
| 0 | 1 | 0 | 1 | 0 | 0 |
| 1 | 0 | 0 | 0 | 1 | 0 |
| 1 | 1 | 0 | 0 | 0 | 1 |

---

# Logic Equations

Each output is activated by a specific input combination.

```
Y0 = B' . A'

Y1 = B' . A

Y2 = B . A'

Y3 = B . A
```

where:

- `'` represents NOT operation
- `.` represents AND operation

---

# Schematic Block Diagram

```

                 A ----------------+
                                    |
                                  +-----+
                                  | NOT |
                                  +-----+
                                    |
                                    A'


                 B ----------------+
                                    |
                                  +-----+
                                  | NOT |
                                  +-----+
                                    |
                                    B'


        A' --------+
                   |
                   |
        B' --------|---- AND -----> Y0 -----> LEDR0


        A ---------+
                   |
                   |
        B' --------|---- AND -----> Y1 -----> LEDR1


        A' --------+
                   |
                   |
        B ---------|---- AND -----> Y2 -----> LEDR2


        A ---------+
                   |
                   |
        B ---------|---- AND -----> Y3 -----> LEDR3


```

---

# FPGA Pin Assignments

## Input Assignment

| FPGA Switch | Signal | Description |
|-------------|--------|-------------|
| SW0 | A | Decoder Input Bit 0 |
| SW1 | B | Decoder Input Bit 1 |

---

## Output Assignment

| FPGA LED | Signal | Description |
|----------|--------|-------------|
| LEDR0 | Y0 | Output for input 00 |
| LEDR1 | Y1 | Output for input 01 |
| LEDR2 | Y2 | Output for input 10 |
| LEDR3 | Y3 | Output for input 11 |

---

# Hardware Verification

The decoder was tested on the DE10-Lite FPGA using onboard switches and LEDs.

The output LEDs indicate the decoded binary input.

## Test Cases

| SW1 (B) | SW0 (A) | Active Output | LED Status |
|:-------:|:-------:|---------------|------------|
| 0 | 0 | Y0 | LEDR0 ON |
| 0 | 1 | Y1 | LEDR1 ON |
| 1 | 0 | Y2 | LEDR2 ON |
| 1 | 1 | Y3 | LEDR3 ON |

---

# Example Operation

### Input:

```
SW1 = 0
SW0 = 1
```

Binary input:

```
BA = 01
```

Output:

```
Y1 = HIGH
```

LED Result:

```
LEDR1 ON
All other LEDs OFF
```

---

# Key Learnings

- Understanding the operation of decoder circuits.
- Learning one-hot output generation.
- Implementing combinational logic using schematic design.
- Using NOT gates to generate complemented inputs.
- Using AND gates to create unique output conditions.
- Designing digital circuits using Quartus Block Diagram Editor.
- Assigning FPGA pins using Pin Planner.
- Compiling and programming schematic designs onto FPGA hardware.
- Verifying digital logic using physical switches and LEDs.

---

# Project Outcome

Successfully implemented and verified a **2-to-4 Decoder** on the DE10-Lite FPGA using schematic design.

The FPGA correctly activates one output LED based on the binary input provided through switches, demonstrating the functionality of a combinational decoder circuit.

---
