# Project 07: PWM Generation and LED Brightness Control using FPGA

## 1. Title

PWM Generation and LED Brightness Control using Intel MAX10 FPGA (DE10-Lite)


## 2. Objective

The objective of this project is to design and implement a PWM (Pulse Width Modulation) generator using VHDL on the DE10-Lite FPGA board.

The project demonstrates how FPGA-based digital logic can be used to control LED brightness by changing the duty cycle of a PWM signal.

The implemented design provides two brightness control modes:

- KEY0 pressed (Active LOW) → 50% duty cycle (medium brightness)
- KEY1 pressed (Active LOW) → 100% duty cycle (full brightness)

This project introduces important concepts such as PWM generation, counter-based timing, comparator logic, and hardware control using FPGA.


## 3. Basic Concepts: Summary

### Pulse Width Modulation (PWM)

PWM is a digital technique used to control the average power delivered to a device by rapidly switching a signal between HIGH and LOW states.

An FPGA output can only generate two voltage levels:

- Logic HIGH → 3.3V
- Logic LOW → 0V

By changing the duration for which the output remains HIGH within one PWM period, the average power can be controlled. This duration is called the duty cycle.


Duty Cycle Formula:

Duty Cycle (%) = (ON Time / Total Time) × 100


Examples:

100% Duty Cycle:

HIGH HIGH HIGH HIGH

LED remains ON continuously and produces maximum brightness.


50% Duty Cycle:

HIGH LOW HIGH LOW

LED is ON for half of the PWM period and produces medium brightness.


0% Duty Cycle:

LOW LOW LOW LOW

LED remains OFF.


In this project:

- 50% duty cycle is generated when KEY0 is pressed.
- 100% duty cycle is generated when KEY1 is pressed.


## PWM Generation Principle

The PWM signal is generated using two main blocks:

1. PWM Counter
2. Comparator Logic


The counter continuously increases:

0 → 1 → 2 → ........ → 1023 → 0


The counter value is compared with a reference value.

For 50% duty cycle:

Counter < 512

LED ON


Counter >= 512

LED OFF


This creates equal ON and OFF time, resulting in approximately 50% brightness.


The DE10-Lite onboard clock frequency is:

50 MHz


The PWM counter is 10-bit:

Counter range:

0 to 1023


The PWM frequency is:

PWM Frequency = 50 MHz / 1024

Approximately:

48.8 kHz


Since this frequency is much higher than human eye perception, the LED appears continuously illuminated with a brightness level based on the duty cycle.


## 4. VHDL Code Explanation Summary

The VHDL design consists of two main sections:


### 1. PWM Counter Generation

A 10-bit unsigned counter is created:

signal pwm_counter : unsigned(9 downto 0);


The counter increments at every rising edge of the 50 MHz clock.

When the counter reaches its maximum value (1023), it resets back to zero.


Counting sequence:

0 → 1 → 2 → ........ → 1023 → 0


This counter creates the timing reference required for PWM generation.


### 2. PWM Duty Cycle Control

The PWM output is generated using comparator logic.


### KEY1 Operation - Full Brightness

When KEY1 is pressed:

key1 = '0'


The PWM output is continuously HIGH:

led_pwm = '1'


Result:

100% duty cycle

LED operates at maximum brightness.



### KEY0 Operation - 50% Brightness

When KEY0 is pressed:

key0 = '0'


The counter value is compared with 512.


If:

Counter < 512

LED ON


If:

Counter >= 512

LED OFF


Result:

50% duty cycle

LED operates at medium brightness.



### Button Logic

The DE10-Lite push buttons are active LOW.

Button states:

Pressed  = '0'

Released = '1'


The design gives priority to KEY1. If both buttons are pressed simultaneously, the LED operates at 100% brightness.


## 5. Pin Assignment Summary

The following pins are assigned for the DE10-Lite FPGA board:


Clock:

Signal:

clk

Pin:

PIN_P11


Description:

50 MHz onboard FPGA clock



Buttons:

Signal:

key0

Pin:

KEY0


Function:

50% brightness control

Active LOW button



Signal:

key1

Pin:

KEY1


Function:

100% brightness control

Active LOW button



LED Output:

Signal:

led_pwm

Pin:

PIN_A8


Description:

Connected to LEDR0


## Hardware Operation Summary


No button pressed:

LED OFF


KEY0 pressed:

LED operates at approximately 50% brightness


KEY1 pressed:

LED operates at 100% brightness


## 6. Key Learnings

Through this project, the following concepts were learned:

- Understanding the working principle of PWM signals
- Generating PWM using FPGA counters
- Controlling LED brightness using duty cycle variation
- Understanding the relationship between PWM frequency and duty cycle
- Implementing comparator-based digital logic
- Working with active LOW push buttons on the DE10-Lite FPGA board
- Understanding real-time hardware control using VHDL
- Applying FPGA concepts used in embedded systems and control applications

The knowledge gained from this project can be extended to advanced applications such as:

- DC motor speed control
- Servo motor control
- Power electronics control
- LED dimming systems
- Embedded actuator control systems