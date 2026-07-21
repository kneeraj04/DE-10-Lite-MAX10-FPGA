# Project 01: LED Blink using VHDL on DE10-Lite FPGA

## 1. Objective

The objective of this project is to understand the complete FPGA development workflow by implementing a simple LED blinking application on the **Terasic DE10-Lite FPGA board** using **VHDL**.

This project introduces the fundamentals of:

- FPGA design flow
- VHDL hardware description
- Quartus Prime compilation
- FPGA pin assignment
- FPGA programming using USB-Blaster

---

# 2. Development Steps

## Step 1: Create VHDL Design

- Created a new Quartus Prime project.
- Developed the VHDL source code (`LED_Test.vhd`) using Visual Studio Code.
- Added the VHDL file into the Quartus project.
- Set `LED_Test` as the **Top-Level Entity**.

---

## Step 2: Assign FPGA Pins

- Opened:

```
Assignments → Pin Planner
```

- Connected VHDL signals to the physical FPGA pins.

| Signal | FPGA Pin | Description |
|--------|----------|-------------|
| `clk` | PIN_P11 | 50 MHz onboard clock |
| `led` | PIN_A8 | LEDR0 |

- Selected I/O Standard:

```
3.3-V LVTTL
```

---

## Step 3: Compile and Program FPGA

- Compiled the project using Quartus Prime.
- Generated the FPGA programming file:

```
LED_Test.sof
```

- Opened Quartus Programmer.
- Selected:

```
USB-Blaster (JTAG)
```

- Loaded the `.sof` file and programmed the FPGA.
- Verified LEDR0 blinking operation on the DE10-Lite board.

---

# 3. Code Explanation

## What did we build?

A hardware circuit that controls LEDR0 and generates a continuous blinking pattern with a fixed time delay.

---

## How does it work?

- The DE10-Lite provides a **50 MHz clock signal** to the FPGA.
- The counter increments on every rising edge of the clock.
- The counter counts:

```
150,000,000 clock cycles
```

which corresponds approximately to:

```
3 seconds
```

- After reaching this value:
  - The counter resets.
  - The LED state toggles.

The final LED behavior:

```
LED ON  → 3 seconds
LED OFF → 3 seconds
Repeat continuously
```

---

# Importance of Clock in FPGA

Unlike a microcontroller, an FPGA does not execute instructions sequentially.

Instead, VHDL describes hardware circuits that operate synchronously using clock signals.

The clock:

- Synchronizes sequential logic.
- Determines when registers update.
- Provides accurate timing.
- Enables counters, timers, communication interfaces (UART, SPI, I²C), and state machines.

Without the clock, the counter cannot increment and the LED cannot blink.

---

# 4. Understanding FPGA Output and LED Operation

The DE10-Lite board uses an **active-low LED configuration**.

This means:

| FPGA Output | Voltage | LED State |
|-------------|---------|-----------|
| `0` | 0 V | LED ON |
| `1` | 3.3 V | LED OFF |

The LED is connected between **3.3 V and the FPGA output pin** through a current-limiting resistor.

```
+3.3 V
  |
330 Ω Resistor
  |
 LED
  |
FPGA Pin
```

### FPGA Output = 0 (LED ON)

The FPGA pin provides a path to ground.

```
3.3 V → Resistor → LED → FPGA Pin (0 V)
```

Current flows through the LED, causing it to turn ON.

---

### FPGA Output = 1 (LED OFF)

The FPGA pin is at 3.3 V.

```
3.3 V → Resistor → LED → FPGA Pin (3.3 V)
```

There is no voltage difference across the LED, so no current flows and the LED remains OFF.

---

## Key Learning

The VHDL code controls the FPGA output signal, but the physical board connection determines how the LED behaves.

For DE10-Lite:

```
FPGA Output 0 → LED ON
FPGA Output 1 → LED OFF
```

Therefore, the output signal is inverted in VHDL:

```vhdl
led <= not led_state;
```

---

# 5. Doubts and Questions

(Add future doubts, observations, and debugging notes here)

---

# 6. References

- Terasic DE10-Lite User Manual
- Intel Quartus Prime Lite 16.1 Documentation