module div (
    input [3:0] a,    // Dividend
    input [3:0] b,    // Divisor
    output reg [3:0] quot // Quotient
);

    reg [3:0] rem;

    integer i;

    always @(a or b)
    begin

        quot = 4'b0000;
        rem  = 4'b0000;

        if (b == 0) begin
            
            quot = 4'bxxxx;
        end
        else
        begin
     
            for (i = 3; i >= 0; i = i - 1)
            begin
                rem = {rem[2:0], a[i]};
                if (rem >= b)
                begin
                    rem = rem - b;
                    quot[i] = 1'b1;
                end
            end
        end
    end

endmodule