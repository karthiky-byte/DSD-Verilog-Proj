module compare(
    input  [3:0] A,      
    input  [3:0] B,      
    output reg [7:0] result 
);

    always @(*) begin
        if (A > B)
            result = 8'd2; // Indicate A > B
        else if (A < B)
            result = 8'd1; // Indicate A < B
        else
            result = 8'd0; // Indicate A == B
    end

endmodule