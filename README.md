# 8-Bit CPU in Verilog

A fully custom 8-bit processor designed from scratch in Verilog and simulated 
in Questa Intel FPGA Starter Edition. Built as a portfolio project targeting 
chip design internships.

## Architecture
Fetch → Decode → Execute → Writeback
The CPU implements a complete datapath including Program Counter, Instruction 
Memory, Control Unit, Register File, ALU, Data Memory, and Stack.

## Instruction Set

| Instruction | Opcode | Description |
|-------------|--------|-------------|
| MOVI | 0111 | Load immediate value into register |
| ADD | 0010 | Add two registers |
| SUB | 0011 | Subtract two registers |
| AND | 0100 | Bitwise AND |
| OR | 0101 | Bitwise OR |
| LOAD | 0000 | Load from data memory |
| STORE | 0001 | Store to data memory |
| JMP | 0110 | Unconditional jump |
| CALL | 1000 | Call subroutine, push PC to stack |
| RETURN | 1001 | Return from subroutine, pop PC from stack |
| PUSH | 1010 | Push register to stack |
| POP | 1011 | Pop stack to register |

## Modules

| Module | File | Description |
|--------|------|-------------|
| ALU | alu.v | Supports ADD, SUB, AND, OR, PASS |
| Register File | reg_file.v | 8x8-bit registers, 2 read ports, 1 write port |
| Program Counter | program_counter.v | 8-bit PC with jump and reset |
| Instruction Memory | instr_mem.v | 256x16-bit ROM |
| Data Memory | data_mem.v | 256x8-bit RAM |
| Stack | stack.v | 16-deep LIFO stack with SP |
| Control Unit | control_unit.v | Opcode decoder, generates all control signals |
| CPU Top | cpu_top.v | Full integration of all modules |

## Simulation Results

All modules individually verified in Questa Intel FPGA Starter Edition.

### ALU
![ALU Simulation](alu.png)

### Register File
![Register File Simulation](reg_file.png)

### Program Counter
![Program Counter Simulation](pc.png)

### Instruction Memory
![Instruction Memory Simulation](instr_mem.png)

### Data Memory
![Data Memory Simulation](data_mem.png)

### Stack
![Stack Simulation](stack.png)

### Control Unit
![Control Unit Simulation](control_unit.png)

### Full CPU Running
![CPU Top Simulation](cpu_top.png)

## Tools Used

- **HDL:** Verilog
- **Simulator:** Questa Intel FPGA Starter Edition 2025.2
- **Synthesis:** Quartus Prime Lite 25.1
- **Target:** Custom ISA, 8-bit datapath

## How to Simulate

1. Open Questa Intel FPGA Starter Edition
2. Compile all source files:
3. vlog +acc alu.v reg_file.v program_counter.v
instr_mem.v data_mem.v stack.v
control_unit.v cpu_top.v tb/cpu_top_tb.v
3. Load simulation:
vsim +acc work.cpu_top_tb
4. Add waves and run:
add wave sim:/cpu_top_tb/uut/*
run -all

## Key Concepts Demonstrated

- RTL design and simulation workflow
- Fetch-Decode-Execute-Writeback pipeline concept
- Harvard vs Von Neumann architecture tradeoffs
- Control unit design using combinational logic
- Stack-based subroutine handling (CALL/RETURN)
- Synchronous vs combinational memory reads
  ## Author
[github.com/Isshu-s](https://github.com/Isshu-s)
