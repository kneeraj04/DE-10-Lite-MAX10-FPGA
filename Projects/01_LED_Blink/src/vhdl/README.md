# Project 01: LED Control and Sequential Logic using VHDL on DE10-Lite FPGA

This project focuses on implementing basic LED control applications using VHDL. It introduces the complete FPGA development workflow, including VHDL design creation, Quartus Prime compilation, FPGA pin assignment, and hardware programming.

This project contains two tasks:

- **Task 1: LED Blink using VHDL (LED_Test)**
- **Task 2: Running LED Sequence using VHDL (LED_Test2)**

---

# Task 1: LED Blink using VHDL (LED_Test)

## Objective

The objective of this task was to implement a simple LED blinking application on the DE10-Lite FPGA board using VHDL.

This task introduces:
- FPGA design workflow
- VHDL hardware description
- Quartus Prime compilation
- FPGA pin assignment
- FPGA programming using USB-Blaster

---

## Implementation

A hardware circuit was created to control **LEDR0** and generate a continuous blinking pattern with a fixed delay.

The onboard **50 MHz clock** was used as the timing source. A counter was implemented to count clock cycles on every rising edge of the clock. After reaching the predefined count value, the LED output state was toggled.

LED behavior:

```
LED ON  → 3 seconds
LED OFF → 3 seconds
Repeat continuously
```

---

## FPGA Pin Assignment

The VHDL signals were mapped to the physical FPGA pins using **Quartus Pin Planner**.

| Signal | FPGA Pin | Description |
|--------|----------|-------------|
| `clk` | PIN_P11 | 50 MHz onboard clock |
| `led` | PIN_A8 | LEDR0 |

I/O Standard:

```
3.3-V LVTTL
```

---

## Key Learning

Through this task, the following FPGA concepts were explored:

- FPGA development workflow
- VHDL entity and architecture structure
- Importance of clock signals in FPGA
- Clock-driven sequential logic
- Counter implementation
- Register updates
- FPGA output control
- Active-low LED configuration
- Quartus compilation and FPGA programming

---

# Task 2: Running LED Sequence using VHDL (LED_Test2)

## Objective

The objective of this task was to implement a running LED sequence on the DE10-Lite FPGA board using VHDL.

The LED sequence follows:

```
LEDR0 → LEDR1 → LEDR2 → ... → LEDR9 → Repeat
```

---

## Implementation

The design uses the onboard **50 MHz clock** and consists of three main logic blocks.

---

## 1. Clock Divider

A counter was implemented to divide the 50 MHz clock frequency and generate a visible delay between LED transitions.

The counter increments on every clock cycle and creates a timing interval for updating the LED position.

---

## 2. LED Position Counter

A register was created to store the active LED position.

The sequence follows:

```
0 → 1 → 2 → 3 → ... → 9 → 0
```

Each value represents one LED.

Example:

```
LED Position = 0 → LEDR0 ON
LED Position = 1 → LEDR1 ON
LED Position = 2 → LEDR2 ON
```

---

## 3. LED Decoder

A case-based decoder logic was implemented to convert the LED position value into the corresponding LED output.

Example:

```vhdl
when "0010" =>
    LEDR(2) <= '1';
```

This activates LEDR2 when the LED position value is 2, while keeping all other LEDs OFF.

---

## FPGA Pin Assignment

The VHDL signals were mapped to the physical DE10-Lite FPGA pins using Quartus Pin Planner.

Configured signals:

| Signal | Description |
|--------|-------------|
| `CLOCK_50` | 50 MHz onboard clock |
| `LEDR[9:0]` | 10 onboard red LEDs |

I/O Standard:

```
3.3-V LVTTL
```

---

## VHDL Design Structure

The design consists of two main processes:

### Clock Process

- Detects the rising edge of `CLOCK_50`.
- Increments the clock counter.
- Generates the timing delay.
- Updates the LED position.

### Decoder Process

- Reads the LED position value.
- Activates the selected LED.
- Keeps all other LEDs OFF.

---

## Key Learning

Through this task, the following FPGA concepts were explored:

- Clock-driven sequential processes
- Counters and registers
- Signal declaration and assignment
- Case-based decoder logic
- FPGA pin mapping
- Hardware description using VHDL
- Designing sequential digital hardware blocks

---

# Doubts and Questions

(Add future doubts, observations, debugging notes, and improvements here)

---

# References

- Terasic DE10-Lite User Manual
- Intel Quartus Prime Lite 16.1 Documentation