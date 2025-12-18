#  4-Bit Arithmetic Logic Unit (ALU)

##  Introduction
This project is a modular **8-function ALU** designed in Verilog HDL. It accepts two 4-bit inputs (`A` and `B`) and performs various arithmetic and logical operations based on a 3-bit selection code (`opcode`).

This module is designed using a **Top-Down approach**, where the main `alu_top` module instantiates smaller submodules for each specific operation (Addition, Subtraction, Multiplication, etc.).Use vivado for good simulation and Design.

##  Key Features
* **8 Distinct Operations:** capable of Math, Logic, and Comparison.
* **Modular Design:** Easy to debug and expand because each operation is in its own module.
* **8-bit Output:** Handles result expansion (e.g., 4-bit * 4-bit = 8-bit product).
* **Carry Flag:** Dedicated output for adder carry status.

##  Pin Description
| Signal Name | Direction | Width | Description |
| :--- | :--- | :--- | :--- |
| `A` | Input | 4-bit | First operand. |
| `B` | Input | 4-bit | Second operand. |
| `opcode` | Input | 3-bit | Operation selector (000 to 111). |
| `result` | Output | 8-bit | The final result of the operation. |
| `carry` | Output | 1-bit | Carry out flag (primarily for addition). |

##  Operation Table (Opcode)
The ALU performs the following functions based on the input `opcode`:

| Opcode | Operation | Description |
| :--- | :--- | :--- |
| **000** | `ADD` | Addition (`A + B`) |
| **001** | `SUB` | Subtraction (`A - B`) |
| **010** | `MUL` | Multiplication (`A * B`) |
| **011** | `DIV` | Division (Returns Quotient) |
| **100** | `OR` | Logical OR (`A | B`) |
| **101** | `AND` | Logical AND (`A & B`) |
| **110** | `ROT` | Bitwise Rotation |
| **111** | `CMP` | Comparison (Equality/Magnitude) |

##  File Structure
This project requires the following files to compile:
* `alu_top.v` (The Main Module)
* `add.v` (Adder Module)
* `sub.v` (Subtractor Module)
* `mul.v` (Multiplier Module)
* `div.v` (Divider Module)
* `logic_or.v` & `logic_and.v`
* `rotate.v`
* `compare.v`
