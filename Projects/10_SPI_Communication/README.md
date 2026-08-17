# Project 10 – SPI Communication using VHDL on DE10-Lite FPGA

## 1. Project Name

**Project 10 – SPI Communication using VHDL on DE10-Lite FPGA**

---

## 2. Objective

The objective of this project is to understand and implement **Serial Peripheral Interface (SPI) communication** using VHDL on the **Terasic DE10-Lite FPGA board**.

The project focuses on:

* Understanding the basic SPI communication protocol.
* Designing an SPI Master using VHDL.
* Generating SPI clock, chip-select, and serial data signals.
* Transmitting and receiving 8-bit data.
* Verifying the SPI design through **ModelSim simulation**.
* Implementing and testing the design on the **DE10-Lite FPGA**.
* Using an internal SPI loopback to verify transmitted and received data.
* Displaying the received data on the onboard LEDs.

The project is first implemented without an external SPI device. An internal loopback connects the SPI Master's `MOSI` signal to its `MISO` input to verify the complete transmit and receive process.

---

## 3. What is SPI Communication?

**SPI (Serial Peripheral Interface)** is a synchronous serial communication protocol commonly used for communication between microcontrollers, FPGAs, processors, and peripheral devices such as sensors, ADCs, DACs, memories, displays, and other integrated circuits.

SPI generally uses four signals:

| Signal      | Full Name                  | Direction      |
| ----------- | -------------------------- | -------------- |
| `SCLK`      | Serial Clock               | Master → Slave |
| `MOSI`      | Master Out Slave In        | Master → Slave |
| `MISO`      | Master In Slave Out        | Slave → Master |
| `CS` / `SS` | Chip Select / Slave Select | Master → Slave |

The **SPI Master** controls the communication by generating the clock and selecting the slave device using `CS`.

### SPI Mode Used

This project uses **SPI Mode 0**:

```text
CPOL = 0
CPHA = 0
```

Therefore:

* `SCLK` is normally LOW when inactive.
* Data is sampled on the rising edge of `SCLK`.
* Data is changed on the falling edge of `SCLK`.
* `CS` is active LOW.

### Basic SPI Communication

```text
              SPI MASTER
                  |
          ┌───────┼────────┐
          │       │        │
        MOSI     SCLK      CS
          │       │        │
          ▼       ▼        ▼
       ┌──────────────────────┐
       │     SPI SLAVE        │
       │                      │
       └──────────┬───────────┘
                  │
                 MISO
                  │
                  ▼
             SPI MASTER
```

For this project, an internal loopback is used:

```text
MOSI ─────────► MISO
```

Therefore, if the master transmits:

```text
10110010
```

the same data is received back:

```text
10110010
```

and displayed on the LEDs.

---

## 4. Project Files and VHDL File Summary

The project contains three main VHDL files.

### 4.1 `spi_master.vhd`

This is the **main SPI Master design** and is the actual hardware circuit synthesized and implemented on the FPGA.

Main functions:

* Receives 8-bit parallel transmission data.
* Generates the SPI clock.
* Generates the active-low chip-select signal.
* Serializes the transmit data.
* Sends data through `MOSI`.
* Samples incoming data through `MISO`.
* Stores the received 8-bit data.
* Generates a `done` signal when the transfer is complete.

Main interface:

```text
clk       → FPGA system clock
reset     → Reset
start     → Start SPI transmission
tx_data   → 8-bit data to transmit
miso      → Data received from slave

mosi      → Data sent to slave
sclk      → SPI clock
cs        → Chip select
rx_data   → Received 8-bit data
done      → Transfer complete
```

The DE10-Lite's 50 MHz clock is divided internally to generate an approximately **1 MHz SPI clock**.

---

### 4.2 `spi_master_tb.vhd`

This is the **simulation testbench**.

It is used only for simulation and is **not programmed into the FPGA**.

The testbench:

* Generates a 50 MHz clock.
* Applies reset.
* Provides test transmission data.
* Generates the start signal.
* Acts as a simple simulated SPI slave.
* Provides data on `MISO`.
* Allows the SPI Master to be verified in ModelSim.
* Allows observation of `CS`, `SCLK`, `MOSI`, `MISO`, `RX_DATA`, and `DONE`.

The testbench allows the SPI Master to be tested before implementing it on physical hardware.

---

### 4.3 `spi_top.vhd`

This is the **top-level FPGA design**.

It connects the SPI Master to the physical DE10-Lite inputs and outputs.

Main functions:

```text
SW[7:0]   → Transmission data
KEY0      → Start SPI transfer
CLOCK_50  → FPGA clock
LED[7:0]  → Received data
```

An internal loopback is created:

```vhdl
miso_signal <= mosi_signal;
```

Therefore:

```text
MOSI → MISO
```

The received data is connected to the LEDs.

Because the DE10-Lite LEDs are active LOW, the LED output is inverted:

```vhdl
LEDR <= not rx_data;
```

---

## 5. Steps for Executing the Project

### Step 1 – Create the Quartus Project

Create a new Quartus Prime project for the **Terasic DE10-Lite / Intel MAX 10 FPGA**.

Select the appropriate MAX 10 device corresponding to the DE10-Lite board.

---

### Step 2 – Create the VHDL Files

Create the following files:

```text
spi_master.vhd
spi_master_tb.vhd
spi_top.vhd
```

Add the required synthesizable files to the Quartus project.

The testbench is used for simulation and does not need to be synthesized into the FPGA.

---

### Step 3 – Develop the SPI Master

First implement:

```text
spi_master.vhd
```

The SPI Master is responsible for converting parallel transmission data into serial SPI data.

```text
Parallel TX Data
       ↓
   SPI Master
       ↓
   Serial Data
       ↓
      MOSI
```

For received data:

```text
      MISO
       ↓
   SPI Master
       ↓
   Parallel RX Data
```

---

### Step 4 – Create the Testbench

Create:

```text
spi_master_tb.vhd
```

The testbench provides:

* Clock
* Reset
* Start signal
* Transmission data
* Simulated MISO response

The testbench behaves like a simulated environment around the SPI Master.

---

### Step 5 – Compile and Simulate in ModelSim

Create the ModelSim working library:

```text
vlib work
```

Compile the SPI Master:

```text
vcom spi_master.vhd
```

Compile the testbench:

```text
vcom spi_master_tb.vhd
```

Start the simulation:

```text
vsim work.spi_master_tb
```

Add signals to the waveform:

```text
add wave *
```

Run the simulation:

```text
run 1 ms
```

---

### Step 6 – Verify the Simulation

The important signals to observe are:

```text
clk
reset
start
tx_data
cs
sclk
mosi
miso
rx_data
done
```

For example, if:

```text
TX_DATA = 10110010
```

the SPI Master should transmit:

```text
MOSI = 1 0 1 1 0 0 1 0
```

The SPI clock should generate eight clock cycles for the 8-bit transfer.

After the transfer:

```text
CS → HIGH
DONE → HIGH
RX_DATA → Received byte
```

The simulation should be verified before moving to the physical FPGA implementation.

---

### Step 7 – Create the FPGA Top-Level Design

After successful simulation, create:

```text
spi_top.vhd
```

The top-level design connects:

```text
SW[7:0]
   ↓
SPI Master
   ↓
MOSI
   ↓
Internal Loopback
   ↓
MISO
   ↓
SPI Master
   ↓
RX_DATA
   ↓
LED[7:0]
```

`KEY0` is used to start the SPI transmission.

Since the DE10-Lite push buttons are active LOW:

```text
KEY0 released → 1
KEY0 pressed  → 0
```

---

### Step 8 – Assign FPGA Pins

Use the **Quartus Pin Planner** to assign the physical DE10-Lite pins.

The main signals are:

| Signal        | Function                |
| ------------- | ----------------------- |
| `CLOCK_50`    | 50 MHz onboard clock    |
| `KEY0`        | SPI transmission start  |
| `SW0–SW7`     | 8-bit transmission data |
| `LEDR0–LEDR7` | 8-bit received data     |

The pin assignments must correspond to the DE10-Lite board pinout.

---

### Step 9 – Compile the FPGA Design

Set:

```text
Top-Level Entity = spi_top
```

Then run:

```text
Processing → Start Compilation
```

The project should compile successfully without errors.

---

### Step 10 – Program the DE10-Lite

Open:

```text
Tools → Programmer
```

Select the appropriate:

```text
USB-Blaster
```

Load the generated `.sof` file and program the FPGA.

---

### Step 11 – Perform the Hardware Test

Set an 8-bit value using the switches.

For example:

```text
SW[7:0] = 10110010
```

Press `KEY0`.

The SPI Master transmits:

```text
10110010
```

through `MOSI`.

The internal loopback connects:

```text
MOSI → MISO
```

The Master receives the same data:

```text
RX_DATA = 10110010
```

The received data is then displayed on the LEDs.

Different switch patterns can be tested:

```text
00000000
11111111
10101010
11001100
10110010
```

This confirms that the SPI transmit and receive logic is functioning correctly.

---

## 6. Pin Assignment Summary

The project uses the following DE10-Lite resources:

| FPGA Signal   | DE10-Lite Resource   | Purpose             |
| ------------- | -------------------- | ------------------- |
| `CLOCK_50`    | 50 MHz onboard clock | System clock        |
| `KEY0`        | Push button KEY0     | Start SPI transfer  |
| `SW0–SW7`     | Slide switches       | 8-bit transmit data |
| `LEDR0–LEDR7` | Red LEDs             | 8-bit received data |

### SPI Signals

The following SPI signals currently exist **internally inside the FPGA**:

```text
MOSI
MISO
SCLK
CS
```

They are not yet connected to external FPGA pins.

The current project uses an internal loopback:

```text
MOSI ─────────► MISO
```

This allows the SPI communication logic to be verified without requiring an external SPI peripheral.

---

## 7. Key Learnings

### SPI Protocol

* Understanding the purpose of `MOSI`, `MISO`, `SCLK`, and `CS`.
* Understanding the Master-Slave communication structure.
* Understanding SPI Mode 0.
* Understanding active-low chip select.
* Understanding serial transmission of parallel data.

### VHDL

* Creating a synthesizable VHDL module using `entity` and `architecture`.
* Using `std_logic` and `std_logic_vector`.
* Using sequential logic with a clocked `process`.
* Implementing counters for clock division.
* Implementing shift registers for serial data transmission.
* Using a bit counter to control an 8-bit transfer.
* Creating a hierarchical VHDL design.

### Simulation

* Creating a VHDL testbench.
* Understanding the difference between a hardware design and its testbench.
* Compiling VHDL files in ModelSim.
* Starting a simulation using the `vsim` command.
* Adding signals to the waveform.
* Verifying SPI timing using `CS`, `SCLK`, `MOSI`, and `MISO`.
* Debugging digital communication using simulation waveforms.

### FPGA Implementation

* Creating a Quartus Prime FPGA project.
* Setting the top-level entity.
* Performing FPGA pin assignments using the Pin Planner.
* Compiling the VHDL design.
* Programming the DE10-Lite FPGA.
* Testing the design using physical switches, push buttons, and LEDs.
* Understanding active-low FPGA board peripherals.

### Embedded Systems Perspective

This project demonstrates an important FPGA and embedded-systems development workflow:

```text
Specification
      ↓
VHDL Design
      ↓
Simulation
      ↓
Waveform Verification
      ↓
FPGA Synthesis
      ↓
Pin Assignment
      ↓
FPGA Programming
      ↓
Real Hardware Testing
```

The project also establishes the foundation for the next stage: connecting the FPGA SPI Master to a **real external SPI peripheral**, such as a sensor, ADC, DAC, EEPROM, or another controller.
