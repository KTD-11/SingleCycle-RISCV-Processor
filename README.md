# Single-Cycle RISC-V (RV32I) Processor

This repository contains a complete Verilog hardware implementation of a single-cycle 32-bit RISC-V (RV32I) processor core. The design is modular, fully synthesizable, and verified using ModelSim/Questa with automated simulation scripting.

## Features

* **RV32I Core Architecture:** Supports basic R-type (add, sub, and, or, xor, sll, srl), I-type (addi), Load (lw), Store (sw), and Branch (beq, bne, blt) operations.
* **Compliant Register File:** 32-bit wide, 32-register array with strict architectural enforcement of register `x0` hardwired to `0`.
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
* `PC_Calculation.v` - Computes branch targets or standard sequential instruction steps (`PC + 4`).
* `Sign_Extend.v` - Sign-extension logic formatting immediate fields.
* `MUX2x1.v` - 32-bit parametric multiplexer for datapath multiplexing.
* `MC_tb.v` - System testbench driving the clock, reset, and simulation assertions.
* `run_sim.tcl` - Custom automation script for ModelSim/Questa wave generation.

---

## Instruction Loading with `$readmemh`

The processor's instruction memory is designed as a ROM that dynamically loads pre-compiled machine code instructions at the start of simulation. This is handled inside `MC_tb.v` using the Verilog `$readmemh` system task:

```verilog
initial begin
    $readmemh("instructions.txt", MC_DUT.Instruction_Memory_instance.mem);
end
```

### Formatting the Instruction File
* Create a file named `instructions.txt` in the same directory as your simulation files.
* Populate it with compiled 32-bit RISC-V hexadecimal instructions (one per line, without the `0x` prefix).
* For example, a simple sequence initializing registers might look like this:

```text
00500093 // addi x1, x0, 5
00a00113 // addi x2, x0, 10
002081b3 // add x3, x1, x2
```

---

## How to Simulate

The simulation is automated to run out-of-the-box inside ModelSim or Questa Sim.

### 1. Compile the Hardware Sources
In your ModelSim/Questa terminal, compile all the Verilog source files:

```bash
vlog *.v
```

### 2. Run the Automation Script

Launch the simulation and automatically configure the waveform window by executing the TCL script:

```bash
do run.tcl
```
