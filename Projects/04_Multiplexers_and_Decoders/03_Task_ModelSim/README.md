# Project 04 – Task 3: 2-to-4 Decoder Functional Simulation using ModelSim

## Objective

The objective of this task is to verify the functionality of the **2-to-4 Decoder VHDL design** using **ModelSim simulation** before implementing it on the physical DE10-Lite FPGA board.

The simulation process validates that the decoder correctly converts a 2-bit binary input into one active output line.

The complete verification flow:

```
VHDL Design
     |
     ↓
Testbench Creation
     |
     ↓
ModelSim Simulation
     |
     ↓
Waveform Verification
     |
     ↓
FPGA Hardware Testing
```

---

# Files Created

The following VHDL files were created for simulation:

```
Task_03_Decoder_ModelSim/

│
├── Decoder.vhd
│
├── tb_Decoder.vhd
│
└── decoder_waveform.png
```

---

## 1. Decoder.vhd

This is the main design file containing the **2-to-4 Decoder RTL description**.

The decoder receives:

### Inputs

- A
- B

### Outputs

- Y0
- Y1
- Y2
- Y3

The design implements the decoder logic using a `case` statement.

Input combinations:

```
BA = 00  → Y0 = 1

BA = 01  → Y1 = 1

BA = 10  → Y2 = 1

BA = 11  → Y3 = 1
```

---

## 2. tb_Decoder.vhd (Testbench)

The testbench is used to automatically apply different input combinations to the decoder and observe the output response.

The testbench does not represent hardware. It is only used for simulation and verification.

---

# Importance of Testbench

A **testbench** is an essential part of FPGA development because it allows designers to verify the correctness of their HDL code before programming the FPGA.

Advantages of using a testbench:

- Detects logical errors before hardware testing.
- Saves debugging time.
- Allows automatic testing of multiple input combinations.
- Verifies expected output behavior.
- Helps analyze timing and signal transitions.

The simulation workflow separates:

```
Design Creation
       |
       ↓
Functional Verification
       |
       ↓
Hardware Implementation
```

---

# Testbench Code Summary

The testbench performs the following operations:

### 1. Component Declaration

The decoder module is connected to the testbench using:

```
component Decoder
```

This represents the design under test (DUT).

---

### 2. Signal Declaration

Internal signals are created:

```
A, B
Y0, Y1, Y2, Y3
```

These signals act like FPGA switches and LEDs during simulation.

---

### 3. Device Under Test (DUT)

The decoder module is instantiated:

```
DUT: Decoder
```

The testbench provides inputs and receives outputs from the decoder.

---

### 4. Stimulus Process

The testbench applies all possible input combinations:

```
BA = 00

BA = 01

BA = 10

BA = 11
```

Each input combination is applied for:

```
0.1 ns
```

The output response is observed in the ModelSim waveform window.

---

# ModelSim Setup Procedure

## Step 1: Create ModelSim Project

1. Open ModelSim.
2. Select:

```
File
 ↓
New
 ↓
Project
```

3. Create a new project folder.

---

## Step 2: Add Existing Files

Add:

```
Decoder.vhd

tb_Decoder.vhd
```

to the project.

---

## Step 3: Compile Files

Select:

```
Compile
 ↓
Compile All
```

Successful compilation should show:

```
Compilation successful
```

---

## Step 4: Start Simulation

Go to:

```
Simulate
 ↓
Start Simulation
```

Select:

```
work
 |
 └── tb_Decoder
```

The testbench is selected as the simulation top module.

---

## Step 5: Add Signals

Add signals to the waveform window:

```
A
B
Y0
Y1
Y2
Y3
```

using:

```
Add Wave
```

---

## Step 6: Run Simulation

Run simulation:

```
run  600 ps
```

The testbench applies all four input combinations.

---

# Waveform Analysis and Results

The expected ModelSim waveform is:

| Simulation Time | B | A | Y0 | Y1 | Y2 | Y3 |
|----------------|---|---|----|----|----|----|
| 0 ns | 0 | 0 | 1 | 0 | 0 | 0 |
| 0.1 ns | 0 | 1 | 0 | 1 | 0 | 0 |
| 0.2 ns | 1 | 0 | 0 | 0 | 1 | 0 |
| 0.3 ns | 1 | 1 | 0 | 0 | 0 | 1 |

---

## Waveform Interpretation

### Input: BA = 00

Output:

```
Y0 = HIGH
```

Only Y0 becomes active.

---

### Input: BA = 01

Output:

```
Y1 = HIGH
```

Only Y1 becomes active.

---

### Input: BA = 10

Output:

```
Y2 = HIGH
```

Only Y2 becomes active.

---

### Input: BA = 11

Output:

```
Y3 = HIGH
```

Only Y3 becomes active.

---

The waveform confirms that the decoder generates a **one-hot output**, where only one output is HIGH at a time.

---

# Key Learnings

- Understanding the importance of simulation before FPGA hardware implementation.
- Learning how to create and use VHDL testbenches.
- Understanding the role of Design Under Test (DUT).
- Learning ModelSim simulation workflow.
- Compiling and running VHDL designs in ModelSim.
- Analyzing digital signals using waveform visualization.
- Verifying combinational logic behavior using simulation.
- Understanding one-hot output encoding in decoder circuits.
- Developing a professional FPGA design flow:

```
Design → Simulation → Synthesis → Hardware Testing
```

---

# Project Outcome

Successfully verified the functionality of the **2-to-4 Decoder VHDL design** using ModelSim.

The simulation results matched the expected truth table, confirming that the decoder logic is correct and ready for FPGA implementation on the DE10-Lite board.