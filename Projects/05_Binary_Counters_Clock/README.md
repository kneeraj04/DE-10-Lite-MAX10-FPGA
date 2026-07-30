# Project 05: Running LED using Binary Counter and Clock Divider

## 1. Objective

The objective of this project is to understand sequential logic design in FPGA by implementing a running LED pattern using VHDL on the DE10-Lite FPGA board.

This project demonstrates:

- Usage of the onboard 50 MHz FPGA clock
- Clock frequency division using a binary counter
- Implementation of sequential counters
- LED control using decoder logic
- Generation of time delays using FPGA hardware

The design creates a running LED effect where one LED remains ON for approximately one second and moves sequentially from LEDR0 to LEDR9 in a continuous loop.

---

# 2. Code Explanation Summary

The VHDL design consists of three main sections:

## A. Clock Divider Counter

The DE10-Lite FPGA provides a 50 MHz clock signal, which means the clock changes 50 million times per second. This frequency is too fast for human observation.

To create a visible delay, a 26-bit counter (`div_counter`) is implemented.

Working principle:

- The counter increments on every rising edge of the 50 MHz clock.
- When the counter reaches 49,999,999, approximately one second has elapsed.
- The counter resets and generates a timing event for changing the LED position.

```
50 MHz Clock
      |
      |
      ▼
Clock Divider Counter
      |
      |
      ▼
1 second timing interval
```

---

## B. LED Position Counter

A second counter (`led_index`) is used to store the current LED position.

Function:

- Starts from LEDR0.
- Increments after every one-second interval.
- Moves sequentially up to LEDR9.
- Returns back to LEDR0 after reaching the last LED.

LED sequence:

```
LEDR0 → LEDR1 → LEDR2 → LEDR3 → ... → LEDR9 → Repeat
```

---

## C. LED Decoder Logic

The LED decoder converts the binary value of `led_index` into an LED output.

A `case` statement is used to activate only one LED at a time.

Example:

```
led_index = 3

Output:

LEDR = 0000001000

LED3 = ON
```

All other LEDs remain OFF.

---

# 3. FPGA Pin Assignment

| Signal | FPGA Pin | Description |
|--------|----------|-------------|
| CLK50 | PIN_P11 | 50 MHz onboard clock |
| LEDR0 | PIN_A8 | Red LED 0 |
| LEDR1 | PIN_A9 | Red LED 1 |
| LEDR2 | PIN_A10 | Red LED 2 |
| LEDR3 | PIN_B10 | Red LED 3 |
| LEDR4 | PIN_D13 | Red LED 4 |
| LEDR5 | PIN_C13 | Red LED 5 |
| LEDR6 | PIN_E14 | Red LED 6 |
| LEDR7 | PIN_D14 | Red LED 7 |
| LEDR8 | PIN_A11 | Red LED 8 |
| LEDR9 | PIN_B11 | Red LED 9 |

**I/O Standard:**

```
3.3-V LVTTL
```

---

# 4. Results and Analysis

After compiling and programming the FPGA, the running LED sequence was successfully observed.

Observed behavior:

- LEDR0 turns ON for approximately one second.
- The active LED moves sequentially from LEDR0 to LEDR9.
- Only one LED is ON at any given time.
- After reaching LEDR9, the sequence restarts from LEDR0.

Observed LED pattern:

```
LEDR0
  ↓
LEDR1
  ↓
LEDR2
  ↓
LEDR3
  ↓
...
  ↓
LEDR9
  ↓
Repeat
```

The experiment successfully verified:

- Correct utilization of the onboard FPGA clock.
- Clock division using a binary counter.
- Proper implementation of synchronous sequential logic.
- Generation of accurate time delays without external hardware.

---

# 5. Key Learnings

Through this project, the following FPGA concepts were learned:

- Understanding FPGA clock signals and synchronous design.
- Difference between combinational and sequential logic.
- Usage of `rising_edge()` for clock-triggered processes.
- Implementation of binary counters in VHDL.
- Clock frequency division techniques.
- Usage of `unsigned` signals with `numeric_std` library.
- Designing LED control logic using `case` statements.
- Understanding how FPGA hardware executes parallel operations.

This project provides the foundation for advanced FPGA applications such as:

- Finite State Machines (FSM)
- Digital clocks
- PWM generators
- Frequency counters
- Communication protocol controllers
- Real-time hardware controllers