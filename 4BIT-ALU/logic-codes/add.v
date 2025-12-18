module add (a,b,addout,carry);

    input [3:0] a, b;                 
    output reg [3:0] addout;    
    output reg carry;
    integer i;
    reg [4:0]c;  // Intermediate carries (c[0] = carry from bit 0 to bit 1, etc.)
    always @(a,b)
    begin
        c[0]=0;
        for (i=0;i<=3;i=i+1)
            begin
                addout[i]=a[i]^b[i]^c[i];
                c[i+1]=(a[i]&b[i])|(a[i]&c[i])|(b[i]&c[i]);
            end
            carry=c[4];
    end

endmodule