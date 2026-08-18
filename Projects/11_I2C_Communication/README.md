# I2C Communication – VHDL Simulation using ModelSim

## 1. Project

**Project 11: I2C Communication using VHDL and ModelSim**

This project demonstrates a basic **I2C Master–Slave communication system** using VHDL. The complete communication is implemented and verified in **ModelSim simulation** without using physical FPGA hardware.

The project demonstrates:

* I2C START condition
* I2C STOP condition
* SCL clock generation
* SDA data transmission
* 7-bit slave address with Write bit
* 8-bit data transmission
* Slave ACK generation
* ACK detection through the SDA line
* Master `busy` and `done` status signals

---

## 2. Objective

The objective of this project is to understand the basic working principle of **I2C communication** by implementing a simple Master–Slave system in VHDL and verifying the complete communication sequence in ModelSim.

The simulation focuses on understanding how **SCL and SDA work together** and, especially, how the **ACK bit is generated on SDA during the 9th clock cycle**.

The project uses the following example:

```text
7-bit Slave Address = 1010000
Write Bit            = 0
Address Byte         = 10100000 = 0xA0

Data Byte            = 10101010 = 0xAA
```

The complete transaction is:

```text
START
   ↓
Address + Write
   ↓
ACK
   ↓
Data
   ↓
ACK
   ↓
STOP
   ↓
DONE
```

---

## 3. Summary of Files

### `i2c_master.vhd`

This is the main I2C Master module.

Its responsibilities are:

* Generate the I2C START condition
* Generate the SCL clock
* Send the slave address
* Send the Write bit
* Release SDA during the ACK cycle
* Allow the slave to generate ACK
* Send the data byte
* Generate the second ACK cycle
* Generate the STOP condition
* Indicate transaction status using `busy` and `done`

The master controls the communication sequence using a **finite state machine (FSM)**.

---

### `i2c_slave.vhd`

This module represents a **simulated I2C slave device**.

It is used only for ModelSim simulation.

Its responsibilities are:

* Receive the address from SDA
* Compare the received address with the expected slave address
* Receive the data byte
* Generate ACK by pulling SDA LOW
* Release SDA after the ACK clock

The slave does not actively drive SDA HIGH. It only pulls SDA LOW when required, which represents the basic open-drain behavior of I2C.

**Note:** This file represents an external I2C device during simulation. It would not be required in a real system where an actual I2C sensor, EEPROM, ADC, etc. acts as the slave.

---

### `i2c_master_tb.vhd`

This is the **testbench**.

Its responsibilities are:

* Generate the 50 MHz simulation clock
* Generate reset
* Generate the `start` signal
* Connect the I2C Master and Slave
* Provide simulated pull-up behavior on SCL and SDA
* Start the transaction
* Wait until `done` becomes HIGH
* Keep the simulation running long enough to observe the complete waveform

The testbench itself does not implement the I2C protocol. It provides the environment required to test the Master and Slave.

---

## 4. Important Notes and Logic Explanation

### 4.1 I2C uses two communication lines

I2C uses only two main signals:

```text
SCL → Serial Clock
SDA → Serial Data
```

Both lines are normally HIGH because of pull-up resistors.

Devices pull the lines LOW when required.

```text
HIGH → line released
LOW  → device pulls line LOW
```

Therefore, I2C uses an **open-drain/open-collector style of communication**.

---

### 4.2 SCL clock

The FPGA simulation clock is:

```text
50 MHz
```

The I2C clock is approximately:

```text
100 kHz
```

The master uses a clock divider:

```vhdl
constant CLK_DIV : integer := 250;
```

The 50 MHz clock has a period of:

```text
20 ns
```

250 clock cycles correspond to:

```text
250 × 20 ns = 5 µs
```

This creates approximately:

```text
5 µs LOW + 5 µs HIGH
```

giving an I2C SCL frequency of approximately:

```text
100 kHz
```

---

### 4.3 Address

The simulated slave address is:

```vhdl
SLAVE_ADDRESS = "1010000"
```

This is a **7-bit address**.

The master also sends the Write bit:

```text
Write = 0
```

Therefore, the complete transmitted address byte is:

```text
1010000 0
│       │
│       └── Write
└────────── 7-bit address
```

So:

```text
Address byte = 10100000
             = 0xA0
```

---

### 4.4 Data

The example data used in the project is:

```text
10101010
```

which is:

```text
0xAA
```

Therefore, the master sends:

```text
Address = 0xA0
Data    = 0xAA
```

---

### 4.5 `bit_count`

The variable:

```vhdl
signal bit_count : integer range 0 to 7;
```

keeps track of which bit of the address or data byte is currently being transmitted or received.

It starts from:

```text
7
```

and counts down:

```text
7 → 6 → 5 → 4 → 3 → 2 → 1 → 0
```

This represents the eight transmitted bits.

I2C transmits the **most significant bit first**.

---

### 4.6 `state`

The Master uses a finite state machine:

```vhdl
type state_type is (...)
```

The different states control individual parts of the I2C transaction.

Important states include:

```text
IDLE
START_1
START_2

ADDRESS_SETUP
ADDRESS_HIGH
ADDRESS_LOW

ADDRESS_ACK_SETUP
ADDRESS_ACK_HIGH
ADDRESS_ACK_LOW

DATA_SETUP
DATA_HIGH
DATA_LOW

DATA_ACK_SETUP
DATA_ACK_HIGH
DATA_ACK_LOW

STOP_1
STOP_2
STOP_3

DONE_STATE
```

This makes the timing of SCL and SDA easier to control and understand.

---

### 4.7 `scl_drive_low`

```vhdl
signal scl_drive_low : std_logic;
```

This controls whether the master pulls SCL LOW.

```text
scl_drive_low = 1
        ↓
SCL = LOW

scl_drive_low = 0
        ↓
SCL = released
```

The actual output is:

```vhdl
scl <= '0' when scl_drive_low = '1' else 'Z';
```

`'Z'` means the master releases the line.

The simulated pull-up then brings the line HIGH.

---

### 4.8 `sda_drive_low`

```vhdl
signal sda_drive_low : std_logic;
```

This controls whether the Master pulls SDA LOW.

```text
sda_drive_low = 1
        ↓
SDA = LOW

sda_drive_low = 0
        ↓
SDA = released
```

The master uses:

```vhdl
sda <= '0' when sda_drive_low = '1' else 'Z';
```

This is important because the master must **release SDA during the ACK cycle**.

---

### 4.9 ACK mechanism

The ACK is one of the most important concepts in this project.

After every 8 transmitted bits, the receiver gets one additional clock cycle for ACK.

Therefore:

```text
8 data/address clocks
+
1 ACK clock
=
9 SCL clocks
```

During the 9th clock:

```text
Master → releases SDA
Slave  → pulls SDA LOW
```

Therefore:

```text
SDA = 0 → ACK
SDA = 1 → NACK
```

For the address:

```text
10100000
         ↓
       9th clock
         ↓
      SDA = 0
         ↓
        ACK
```

For the data:

```text
10101010
         ↓
       9th clock
         ↓
      SDA = 0
         ↓
        ACK
```

This project deliberately represents the ACK **directly on SDA**, rather than using separate artificial `ack_address` or `ack_data` signals.

---

### 4.10 `ack_drive` and `ack_active`

Inside the simulated slave:

```vhdl
signal ack_drive  : std_logic;
signal ack_active : std_logic;
```

are used to control the ACK.

When the slave needs to acknowledge:

```text
ack_drive  = 1
ack_active = 1
```

The slave then pulls:

```text
SDA = 0
```

After the ACK clock finishes, the slave releases SDA.

---

### 4.11 `busy`

The Master output:

```vhdl
busy
```

indicates that an I2C transaction is in progress.

Expected behavior:

```text
IDLE          → busy = 0

START         → busy = 1

Communication → busy = 1

STOP          → busy = 1

DONE          → busy = 0
```

---

### 4.12 `done`

The Master output:

```vhdl
done
```

indicates that the complete transaction has finished.

Initially:

```text
done = 0
```

After:

```text
START
ADDRESS
ACK
DATA
ACK
STOP
```

the Master reaches:

```text
DONE_STATE
```

and:

```text
done = 1
```

---

## 5. Expected Output in ModelSim

The important signals to add to the waveform are:

```text
clk
reset
start
scl
sda
busy
done
```

The expected communication is:

```text
START
   ↓
10100000
   ↓
ACK
   ↓
10101010
   ↓
ACK
   ↓
STOP
   ↓
DONE
```

### Address transmission

```text
SDA:

1 0 1 0 0 0 0 0 | 0
-----------------   -
   8 address bits  ACK
```

The 9th clock contains:

```text
SDA = 0
```

---

### Data transmission

```text
SDA:

1 0 1 0 1 0 1 0 | 0
-----------------   -
     8 data bits   ACK
```

Again:

```text
SDA = 0
```

during the ACK clock.

---

### Overall waveform

Conceptually, the waveform should look like:

```text
        START       ADDRESS       ACK      DATA       ACK      STOP

SCL  ‾‾‾\___/‾\___/‾\___/‾\___/‾\___/‾\___ ... ___/‾\___/‾‾‾

SDA  ‾‾‾\ 10100000 \0/ 10101010 \0/ ‾‾‾‾
       ↑             ↑             ↑
     START         Address         Data
                   ACK             ACK
```

The exact visual shape will depend on the ModelSim zoom level.

### Expected status

At the beginning:

```text
busy = 0
done = 0
```

After `start`:

```text
busy = 1
done = 0
```

After the complete transaction:

```text
busy = 0
done = 1
```

---

## 6. Key Learnings

* I2C uses only **SCL and SDA** for communication.
* SDA is transmitted **MSB first**.
* A 7-bit address is followed by a **Read/Write bit**.
* The example uses slave address `0x50`, Write operation, and data `0xAA`.
* Every transmitted byte is followed by a **9th clock for ACK/NACK**.
* **ACK is represented by SDA being LOW (`0`) during the 9th clock.**
* The master must **release SDA** during the ACK cycle.
* I2C uses **open-drain/open-collector signaling**.
* `'Z'` is used in VHDL to represent releasing the bus.
* A finite state machine is useful for controlling the I2C timing.
* The testbench provides the simulation environment, while the Master and Slave implement the communication.
* `i2c_slave.vhd` is only a **simulation model**; in a real system, the external I2C device would generate the ACK.
