# MIPS Processor (Behavioral-Level Implementation)

This project features a **behavioral-level Verilog implementation** of a simplified MIPS processor. It supports a **subset of standard MIPS instructions** and is designed for simulation and educational purposes.

---
## Images~

### Flow Diagram  
![Flow Diagram](/images/Screenshot%202025-04-13%20at%2011.36.17 AM.png)

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
    iverilog -o output AluControl.v Control.v DataMemory.v InstructionMemory.v ProgramCounter.v RegisterFile.v TestBench.v TopModule.v
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

<table style="width:100%; border-collapse: collapse; margin-bottom: 1rem;">
  <thead>
    <tr style="background-color: #f8f8f8;">
      <th style="border: 1px solid #ddd; padding: 8px; text-align: left;">Instruction Type</th>
      <th style="border: 1px solid #ddd; padding: 8px; text-align: left;">Format</th>
      <th style="border: 1px solid #ddd; padding: 8px; text-align: left;">Details</th>
    </tr>
  </thead>
  <tbody>
    <!-- R-Type Row -->
    <tr>
      <td style="border: 1px solid #ddd; padding: 8px; vertical-align: top;"><strong>R-Type</strong></td>
      <td style="border: 1px solid #ddd; padding: 8px; font-family: monospace; vertical-align: top;">
        opcode (6) | rs (5) | rt (5) | rd (5) | shamt (5) | funct (6)
      </td>
      <td style="border: 1px solid #ddd; padding: 8px; vertical-align: top;">
        <strong>Opcode:</strong> <code>000000</code><br>
        <strong>Funct Codes:</strong>
        <ul style="margin: 0; padding-left: 1.2rem;">
          <li>ADD: <code>000000</code></li>
          <li>SUB: <code>000001</code></li>
          <li>AND: <code>000010</code></li>
          <li>OR:  <code>000011</code></li>
          <li>SLT: <code>000100</code></li>
        </ul>
      </td>
    </tr>
    <!-- I-Type Row -->
    <tr>
      <td style="border: 1px solid #ddd; padding: 8px; vertical-align: top;"><strong>I-Type</strong></td>
      <td style="border: 1px solid #ddd; padding: 8px; font-family: monospace; vertical-align: top;">
        opcode (6) | rs (5) | rt (5) | immediate (16)
      </td>
      <td style="border: 1px solid #ddd; padding: 8px; vertical-align: top;">
        <strong>Opcodes:</strong>
        <ul style="margin: 0; padding-left: 1.2rem;">
          <li>LW:  <code>000100</code></li>
          <li>SW:  <code>000101</code></li>
          <li>BEQ: <code>000110</code></li>
        </ul>
      </td>
    </tr>
    <!-- J-Type Row -->
    <tr>
      <td style="border: 1px solid #ddd; padding: 8px; vertical-align: top;"><strong>J-Type</strong></td>
      <td style="border: 1px solid #ddd; padding: 8px; font-family: monospace; vertical-align: top;">
        opcode (6) | address (26)
      </td>
      <td style="border: 1px solid #ddd; padding: 8px; vertical-align: top;">
        <strong>Opcodes:</strong>
        <ul style="margin: 0; padding-left: 1.2rem;">
          <li>JUMP: <code>000010</code></li>
          <li>JAL:  <code>000011</code></li>
        </ul>
      </td>
    </tr>
  </tbody>
</table>

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

##  Contact

Feel free to open issues or submit pull requests.  
**GitHub:** [electrify-7](https://github.com/electrify-7)

---
