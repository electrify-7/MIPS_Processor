# MIPS Processor (Behavioral-Level Implementation)

This project features a **behavioral-level Verilog implementation** of a simplified MIPS processor. It supports a **subset of standard MIPS instructions** and is designed for simulation and educational purposes.

---

## Images~

### Flow Diagram  
![Flow Diagram](/images/Screenshot%202025-04-13%20at%2011.36.17 AM.png)

### FSM Diagram 
![FSM Diagram](/images/Screenshot%202025-04-13%20at%2011.35.51 AM.png)

---

## To setup:

### Clone the Repository

```bash
git clone https://github.com/electrify-7/MIPS_Processor.git
cd MIPS_Processor
```

### 🔧 Prerequisites

Ensure that you have a Verilog simulator installed. The recommended tool is **Icarus Verilog**, and optionally **GTKWave** for waveform viewing.

---

##  Installation & Usage

### Install Verilog Simulator

#### On Ubuntu/Debian

```bash
sudo apt update
sudo apt install iverilog gtkwave
```

#### On macOS (with Homebrew)

```bash
brew install icarus-verilog
brew install --cask gtkwave
```

---

###  Running the Simulation

1. **Compile the Verilog files:**

    ```bash
    iverilog -o mips_simulation top_module.v other_modules.v
    ```

2. **Execute the simulation:**

    ```bash
    vvp mips_simulation
    ```

3. **(Optional) View the waveform:**

    ```bash
    gtkwave dumpfile.vcd
    ```

---

## Instruction Set Architecture (ISA)

| Instruction Type | Format | Details |
|------------------|--------|---------|
| **R-Type** | `opcode (6) | rs (5) | rt (5) | rd (5) | shamt (5) | funct (6)` |  
Opcode: `000000`  
Funct Codes:  
• `000000` – ADD  
• `000001` – SUB  
• `000010` – AND  
• `000011` – OR  
• `000100` – SLT  
|
| **I-Type** | `opcode (6) | rs (5) | rt (5) | immediate (16)` |  
Opcodes:  
• `000100` – LW  
• `000101` – SW  
• `000110` – BEQ  
|
| **J-Type** | `opcode (6) | address (26)` |  
Opcodes:  
• `000010` – JUMP  
• `000011` – JAL  
|

---

##  Project Structure (Till 13.04.25)

```bash
MIPS_Processor/
├── AluControl.v
├── Control.v
├── DataMemory.v
├── InstructionMemory.v
├── RegisterFile.v
├── TopModule.v
├── TestBench.v
├── ProgramCounter.v
└── README.md
```

---

##  Notes

- The processor is designed for simulation, not synthesis.
- You can extend the instruction set or add pipeline stages as enhancements.
- Waveform files (e.g., `dumpfile.vcd`) can be configured in the testbench.

---

## 📬 Contact

Feel free to open issues or submit pull requests.  
**GitHub:** [electrify-7](https://github.com/electrify-7)

---
