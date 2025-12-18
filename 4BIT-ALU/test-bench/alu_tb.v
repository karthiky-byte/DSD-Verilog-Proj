`timescale 1ns / 1ps
module alu_tb;

    reg [3:0] A, B;
    reg [2:0] opcode;
    wire [7:0] result;
    wire carry;
    // Instantiate ALU top module
    alu_top uut (
        .A(A),
        .B(B),
        .opcode(opcode),
        .result(result),
        .carry(carry)
    );

    // Generate VCD file for GTKWave
//    initial begin
//        $dumpfile("alu_wave.vcd");
//        $dumpvars(0, alu_tb);
//    end

    initial begin
        $display("=== Starting ALU Testbench with Edge Cases ===");

        // ---------------- NORMAL TESTS ----------------
        A = 4'd5; B = 4'd12; opcode = 3'b000; #10;  // ADD 5 + 3
        A = 4'd9; B = 4'd4; opcode = 3'b001; #10;  // SUB 9 - 4
        A = 4'd6; B = 4'd3; opcode = 3'b010; #10;  // MUL 6 × 3
        A = 4'd8; B = 4'd2; opcode = 3'b011; #10;  // DIV 8 ÷ 2
        A = 4'b1100; B = 4'b1010; opcode = 3'b100; #10; // LOGIC OR
        A = 4'b1011; B = 4'b0000; opcode = 3'b101; #10; // LOGIC AND
        A = 4'b1010; B = 4'b0001; opcode = 3'b110; #10; // ROTATE (default left)
        A = 4'b0110; B = 4'b1000; opcode = 3'b111; #10; // COMPARE

        // ---------------- EDGE / SPECIAL CASES ----------------
        // 1. Addition Overflow: 15 + 15
        A = 4'd15; B = 4'd15; opcode = 3'b000; #10;

        // 2. Subtraction Borrow Case: 9 - 2
        A = 4'd9; B = 4'd2; opcode = 3'b001; #10;

        // 3. Multiplication Max: 15 × 15
        A = 4'd15; B = 4'd15; opcode = 3'b010; #10;

        // 4. Divide-by-Zero case
        A = 4'd7; B = 4'd0; opcode = 3'b011; #10;
        A = 4'd7; B = 4'd2; opcode = 3'b011; #10;




        // 7. Rotate left and right pattern edge cases
        A = 4'b1001; B = 4'b0000; opcode = 3'b110; #10; 
        // 8. Comparator test - Equal numbers
        A = 4'd10; B = 4'd10; opcode = 3'b111; #10;

//        $display("=== All test cases executed ===");
     $finish;
    end
endmodule