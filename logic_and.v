module logic_and (
    input  [3:0] A,       // 4-bit input A
    input  [3:0] B,       // 4-bit input B
    output [3:0] Y    // 4-bit output result
);

    assign Y=A&B;


endmodule