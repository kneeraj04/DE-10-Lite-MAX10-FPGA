# Project 06: Traffic Light Controller Using FSM on DE10-Lite FPGA

---

# 1. Title

## Design and Implementation of a Single Road Traffic Light Controller Using Finite State Machine (FSM) on DE10-Lite FPGA

---

# 2. Objective

The objective of this project is to design and implement a single-road traffic light controller using a **Finite State Machine (FSM)** on the **Terasic DE10-Lite FPGA board**.

The controller is designed using a **Moore FSM**, where the output depends only on the current state.

The traffic light controller consists of four states:

| State | Traffic Signal |
|-------|----------------|
| S0 | Green Light ON |
| S1 | Yellow Light ON |
| S2 | Red Light ON |
| S3 | Yellow Light ON |

Each state remains active for approximately **2 seconds**. A timer circuit generates the required delay, and the timer output controls the FSM state transitions.

The complete design flow includes:

---

# 3. FSM File Creation and HDL Conversion

## 3.1 FSM Design Using Quartus SMF

The traffic controller FSM was first designed using the **Quartus State Machine File (.smf) editor**.

A Moore FSM architecture was selected because the traffic light outputs depend only on the current state.

## State Transition Diagram
      timer_done=1

   +----+
   |    |
   ↓    |
 +----+     +----+
 | S0 | --> | S1 |
 | G  |     | Y  |
 +----+     +----+
                |
                |
                ↓
            +----+
            | S2 |
            | R  |
            +----+
                |
                |
                ↓
            +----+
            | S3 |
            | Y  |
            +----+
                |
                |
                +-------> S0

                
State sequence:

---

## 3.2 FSM States

| State | Output |
|-------|--------|
| S0 | Green = 1 |
| S1 | Yellow = 1 |
| S2 | Red = 1 |
| S3 | Yellow = 1 |


The FSM uses the following signals:

### Inputs

| Signal | Description |
|--------|-------------|
| clock | FPGA clock signal |
| reset | Reset input |
| timer_done | State transition trigger |

### Outputs

| Signal | Description |
|--------|-------------|
| Green | Green traffic light |
| Yellow | Yellow traffic light |
| Red | Red traffic light |

---

## 3.3 Conversion to HDL

After completing the FSM design in the SMF editor, Quartus automatically generated the VHDL implementation.

Generated file:

The generated VHDL contains:

- State declaration
- Current state register
- Next-state logic
- Output decoding logic


The FSM file only contains the **traffic control logic**.

It does not include:

- Clock divider/timer
- FPGA pin connections
- LED interface

---

# 4. Traffic_Timer_Top.vhd Implementation

## 4.1 Why Traffic_Timer_Top is Required?

The FSM requires a timing input:

The SMF-generated FSM only changes states when this signal becomes HIGH.

Therefore, a separate top-level module was created:


This module integrates:

1. Timer circuit
2. FSM module
3. FPGA LED outputs


---

## 4.2 Timer Implementation

The DE10-Lite FPGA provides:

For a 2 second delay:

A counter is implemented to generate:

after 100 million clock cycles.

The timer signal triggers FSM transitions.

---

## 4.3 FSM and Top Module Connection

          CLOCK_50
              |
              |
      +---------------+
      | Timer Counter |
      +---------------+
              |
              |
         timer_done
              |
              |
      +---------------+
      | Traffic FSM   |
      | S0-S1-S2-S3   |
      +---------------+
         |     |     |
         |     |     |
      LEDR0  LEDR1  LEDR2
      Green Yellow Red

      
---

## 4.4 Difference Between FSM File and Traffic_Timer_Top

| Traffic_Controller.vhd (FSM) | Traffic_Timer_Top.vhd |
|------------------------------|------------------------|
| Generated from SMF | Written manually |
| Contains FSM states | Contains timer + FSM |
| Controls traffic sequence | Provides timing control |
| Uses timer_done input | Generates timer_done |
| No hardware interface | Connects FPGA pins |


---

# 5. Pin Assignments

The design was implemented on the **Terasic DE10-Lite FPGA board**.


## Clock

| Signal | FPGA Pin | Description |
|--------|----------|-------------|
| CLOCK_50 | PIN_P11 | 50 MHz onboard clock |


## LED Outputs

| Signal | FPGA Pin | Function |
|--------|----------|----------|
| LEDR0 | PIN_A8 | Green Light |
| LEDR1 | PIN_A9 | Yellow Light |
| LEDR2 | PIN_A10 | Red Light |


## Reset

| Signal | Description |
|--------|-------------|
| RESET | FSM reset input |

The reset polarity was modified according to the DE10-Lite hardware configuration.

---

# 6. Results and Analysis

The traffic light controller was successfully synthesized, compiled, and programmed on the DE10-Lite FPGA.


## Hardware Output Sequence

| Time | FSM State | LED Output |
|------|-----------|------------|
| 0 - 2 sec | S0 | Green LED ON |
| 2 - 4 sec | S1 | Yellow LED ON |
| 4 - 6 sec | S2 | Red LED ON |
| 6 - 8 sec | S3 | Yellow LED ON |


The sequence repeats continuously:

The FPGA successfully implemented a real-time traffic controller using FSM-based digital logic.

---

# 7. Key Learnings

Through this project, the following concepts were learned:

- Designing FSMs using Quartus SMF editor.
- Converting graphical FSM designs into VHDL.
- Understanding Moore FSM architecture.
- Implementing state transition logic.
- Designing timer circuits using FPGA clock cycles.
- Integrating multiple VHDL modules.
- Creating a top-level FPGA hardware interface.
- Performing FPGA pin assignments.
- Handling reset polarity issues.
- Debugging sequential logic using physical FPGA outputs.
- Implementing a complete digital control system on FPGA.


---

# Conclusion

Project 06 demonstrated the complete FPGA development workflow:

A functional single-road traffic light controller was successfully designed and implemented on the DE10-Lite FPGA using a Moore FSM architecture.