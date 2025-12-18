`timescale 1ns / 1ps
module alu_top(
    input [3:0] A, B,        
    input [2:0] opcode,      // Operation selector (3-bit)
    output reg [7:0] result,
    output reg carry 
);

    wire [3:0] add_out, sub_out, logic_or,logic_and, quot;
    wire add_carry,sub_borrow;
    wire [7:0] mul_out, parity_out, rotate_out, compare_out;
    
    // Submodule instantiations
    add      ADD (A, B, add_out, add_carry);
    sub      SUB (A, B, sub_out, sub_borrow);
    mul      MUL (A, B, mul_out);
    div      DIV (A, B, quot);
    logic_or LOGIC (A, B, logic_or);
    logic_and LOGIC1 (A, B, logic_and);
    rotate   ROT  (A, B, rotate_out);
    compare  CMP  (A, B, compare_out);

    // Operation selection
    always @(*) begin
        case (opcode)
            3'b000: result = add_out;       // Addition
            3'b001: result = sub_out;       // Subtraction
            3'b010: result = mul_out;                  // Multiplication
            3'b011: result = quot;              // Division (high nibble=quotient, low=rem)
            3'b100: result = logic_or;     // Logic and operation
            3'b101: result = logic_and;               // Logic or operation
            3'b110: result = rotate_out;               // Bit rotation
            3'b111: result = compare_out;              // Comparator
            default: result = 8'b00000000;
        endcase
        carry=add_carry;
    end
endmodule