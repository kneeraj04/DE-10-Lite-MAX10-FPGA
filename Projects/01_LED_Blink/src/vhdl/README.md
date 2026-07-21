# Project 01: LED Blink using VHDL on DE10-Lite FPGA

## 1. Objective

The objective of this project is to understand the complete FPGA development workflow by implementing a simple LED blinking application on the DE10-Lite FPGA board using VHDL. This project introduces the fundamentals of FPGA design, hardware description using VHDL, compilation, pin assignment, and FPGA programming.

---

## 2. Development Steps

### Step 1: Create VHDL Design
- Created a new Quartus Prime project.
- Wrote the VHDL source code (`LED_Test.vhd`) in Visual Studio Code.
- Added the VHDL file to the Quartus project and set it as the Top-Level Entity.

### Step 2: Assign FPGA Pins
- Opened **Assignments → Pin Planner**.
- Connected the VHDL signals to the physical FPGA pins.
- Assigned:
  - `clk` → `PIN_P11` (50 MHz onboard clock)
  - `led` → `PIN_A8` (LEDR0)
- Set the I/O standard to **3.3-V LVTTL**.

### Step 3: Compile and Program
- Compiled the project using Quartus Prime.
- Generated the `.sof` programming file.
- Opened **Programmer**, selected **USB-Blaster (JTAG)**, loaded the `.sof` file, and programmed the FPGA.
- Verified LEDR0 blinking on the DE10-Lite board.

---

## 3. Code Explanation

### What did we build?

A hardware circuit that blinks LEDR0 continuously with a fixed delay.

### How does it work?

- The FPGA receives a **50 MHz clock** from the onboard oscillator.
- A **counter** increments on every rising edge of the clock.
- After counting **150,000,000 clock cycles** (approximately 3 seconds), the counter resets.
- At the same time, the LED state is toggled.
- This results in:
  - LED ON for 3 seconds
  - LED OFF for 3 seconds
  - Repeat continuously

### Why is the clock important?

Unlike a microcontroller, an FPGA does not execute software instructions sequentially. All sequential hardware requires a clock.

The clock:
- Synchronizes all sequential logic.
- Determines when registers update.
- Provides an accurate time reference for counters, timers, communication protocols (UART, SPI, I²C), and state machines.

Without the clock, the counter would never increment, and the LED would never blink.

---

## 4. Doubts and Questions

-

---

## 5. References

- Terasic DE10-Lite User Manual
- Intel Quartus Prime Lite 16.1 Documentation