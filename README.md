# Single-Cycle RISC-V (RV32I) Processor

This repository contains a complete Verilog hardware implementation of a single-cycle 32-bit RISC-V (RV32I) processor core. The design is modular, fully synthesizable, and verified using ModelSim/Questa with automated simulation scripting.

## Features

* **RV32I Core Architecture:** Supports basic R-type (add, sub, and, or, xor, sll, srl), I-type (addi), Load (lw), Store (sw), and Branch (beq, bne, blt) operations.
* **Compliant Register File:** 32-bit wide, 32-register array with strict architectural enforcement of $x0$ hardwired to `0`.
* **32-Bit ALU:** Full arithmetic and logic unit with automated zero and sign flag generation for branch resolution.
* **Latch-Free Control Unit:** Clean combinational control logic designed to prevent inferred latches during synthesis.
* **Automated Verification:** Fully automated testbench setup driven by a custom TCL simulation script.

---

## Repository Structure

The processor is divided into clean, dedicated hardware modules:

* `MC.v` - The top-level Datapath module routing and interconnecting all sub-components.
* `ALU.v` - Arithmetic Logic Unit handling shifts, math, and logical operations.
* `Control_Unit.v` - Main decoder and ALU decoder generating execution control signals.
* `Register_File.v` - Multi-port register memory bank.
* `Data_Memory.v` - RAM storage for data operations.
* `Instruction_Memory.v` - ROM storing execution machine code.
* `Program_Counter.v` - Pointer register tracks current instruction address.
* `PC_Calculation.v` - Computes branch targets or standard sequential instruction steps ($PC + 4$).
* `Sign_Extend.v` - Sign-extension logic formatting immediate fields.
* `MUX2x1.v` - 32-bit parametric multiplexer for datapath multiplexing.
* `MC_tb.v` - System testbench driving the clock, reset, and simulation assertions.
* `run_sim.tcl` - Custom automation script for ModelSim/Questa wave generation.

---

## How to Simulate

The simulation is automated to run out-of-the-box inside ModelSim or Questa Sim.

### 1. Compile the Hardware Sources
In your ModelSim/Questa terminal, compile all the Verilog source files:

```bash
vlog *.v

### 2. Run the Automation Script

Launch the simulation and automatically configure the waveform window by executing the TCL script:

Bash
do run_sim.tcl
