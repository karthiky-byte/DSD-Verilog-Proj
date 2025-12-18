module sub (
    input [3:0] a, b,                 
    output reg [3:0] subout,    
    output reg borrow        
);

    integer i;
    reg [4:0] c;                // Intermediate carries (for ripple)
    wire [3:0] b_inv;           // Inverted B (~B)

    // Invert B for 2's complement
    assign b_inv = ~b;

    always @(a, b_inv)
    begin
        c[0] = 1'b1;            // Initial +1 for 2's complement (overrides external cin)
        for (i = 0; i <= 3; i = i + 1) begin
            subout[i] = a[i] ^ b_inv[i] ^ c[i];
            c[i+1] = (a[i] & b_inv[i]) | (a[i] & c[i]) | (b_inv[i] & c[i]);
        end
        // Borrow-out = NOT (final carry) for underflow detection
        borrow = ~c[4];
    end

endmodule