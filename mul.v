module mul(
    input [3:0] a, 
    input [3:0] b, 
    output reg [7:0] prod
);
    integer i;
    reg [7:0] temp_a;
    reg [7:0] temp_b;

    always @(a, b)
    begin
        prod = 8'b00000000;
        temp_a = {4'b0000, a};  // extend A to 8 bits
        temp_b = {4'b0000, b};
        for (i = 0; i < 4; i = i + 1)
        begin
            if (b[i] == 1)
                prod = prod + (temp_a << i);
        end
    end
endmodule
