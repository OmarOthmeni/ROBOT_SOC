# BE RoBoT "BoB" - NIOS II Embedded System

This repository contains the complete design and implementation of the **BoB Robot** embedded system, developed on an **Intel/Altera DE1-SoC FPGA** (Cyclone V). The project integrates a 32-bit NIOS II soft-processor with custom VHDL peripherals.

## 📂 Project Architecture

The repository is organized to strictly separate hardware description, system-on-chip configuration, and software application logic.

### 🏗️ Hardware (`/hardware`)
Contains the top-level and intermediate schematics for the FPGA design.
* **`peripheriques.bdf`**: The main top-level entry point connecting the NIOS II to the outside world.
* **`DECODAGE_ROBOT.bdf`**: Hardware implementation of the address decoding logic.
* **Sub-modules**: Visual blocks for Motors (`moteur_robot.bdf`), Sensors (`Capteur_SRF05.bdf`), and User Interface (`AFFICHEUR_ROBOT.bdf`, `LED_ROBOT.bdf`).

### 📜 VHDL Logic (`/vhdl`)
Contains the hardware description language (VHDL) files that define the behavior of the components.
* **`DECODAGE_ROBOT.vhd`**: Logic managing the 8 memory chip-select zones ($C_{S0}$ to $C_{S7}$).
* **`moteurs.vhd`**: PWM signal generation for motor speed and direction control.
* **`capteurs_robot.vhd` & `echo.vhd`**: Ultrasonic sensor pulse processing and distance measurement logic.

### ⚙️ System Configuration (`/system`)
The Qsys (Platform Designer) environment files.
* **`NIOS_ROBOT_LAST.qsys`**: Defines the CPU parameters, Avalon-MM bus, and On-Chip Memory.
* **`NIOS_ROBOT_LAST.sopcinfo`**: Hardware description passed to the Nios II Software Build Tools.

### 💻 Software (`/logiciel`)
The C/C++ application layer.
* **`ROBOT_EEEA_1A/`**: Application project containing the main loop (`hello_world_small.c`).
* **`robot_def.h`**: Critical header mapping C pointers to physical hardware addresses.
* **`ROBOT_EEEA_1A_bsp/`**: Board Support Package (HAL) auto-generated based on the hardware.

---

## 🛠️ Implementation Details

### Memory Mapping
The project utilizes a custom Address Decoder to interface the NIOS II processor with several peripherals across the following zones:
- **Zone 0 ($C_{S0}$)**: Seven-Segment Displays (HEX0 - HEX5).
- **Zone 1 ($C_{S1}$)**: Status LEDs.
- **Zone 2 ($C_{S2}$)**: Robot Sensors (Line tracking/Distance).
- **Zone 3 ($C_{S3}$)**: User Input Switches.
- **Zone 4 ($C_{S4}$)**: Motor Drive (Direction and Duty Cycle).

### Tools Used
- **Quartus Prime 18.1** (Synthesis & Implementation)
- **Qsys / Platform Designer** (SoC Integration)
- **NIOS II Software Build Tools (Eclipse)** (C Programming)
- **ModelSim** (Logic Simulation)

---
*Maintained by Omar Othmeni* *ENSEEIHT - Toulouse INP*