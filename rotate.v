module rotate(
    input [3:0] A,        // 4-bit input data            
    input [3:0] B,    // Rotate amount (0–3) last two lsb decide how musch to be rotated
    //MSB of B decide in which way to rotate 0 = Rotate Left, 1 = Rotate Right
    output reg [7:0] result
);
    reg [3:0] temp;
    reg [1:0] amt;
    reg dir;
    always @(*) 
    begin
    begin
        amt[0]=B[0];
        amt[1]=B[1];
        dir=B[3];
      end
      
        if (dir == 0) // Rotate Left
            temp = (A << amt) | (A >> (4 - amt));
        else           // Rotate Right
            temp = (A >> amt) | (A << (4 - amt));

        result = {4'b0000, temp}; // pad upper bits with zeros
    end
endmodule