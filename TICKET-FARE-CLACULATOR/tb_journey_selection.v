`timescale 1ns / 1ps

module tb_journey_selection;

    // Inputs
    reg [2:0] path;
    reg rd;
    reg [1:0] journey_type;
    reg [7:0] distance;
    reg [7:0] highway_distance;
    reg [7:0] num_adults;
    reg [7:0] num_children;

    // Outputs
    wire [15:0] total_cost;

    // Instantiate the Unit Under Test (UUT)
    journey_selection uut (
        .path(path),
        .rd(rd),
        .journey_type(journey_type),
        .distance(distance),
        .highway_distance(highway_distance),
        .num_adults(num_adults),
        .num_children(num_children),
        .total_cost(total_cost)
    );

    initial begin
        // Initialize Inputs
        path = 0;
        rd = 0;
        journey_type = 0;
        distance = 0;
        highway_distance = 0;
        num_adults = 0;
        num_children = 0;

        // Test 1: Reset case
        rd = 1;
        #1;
        if (total_cost == 16'd0) $display("Test 1 (Reset): PASS");
        else $display("Test 1 (Reset): FAIL - Expected 0, Got %d", total_cost);

        // Test 2: All zeros, no reset
        rd = 0;
        path = 3'b000;
        journey_type = 2'b00;
        distance = 8'd0;
        highway_distance = 8'd0;
        num_adults = 8'd0;
        num_children = 8'd0;
        #1;
        if (total_cost == 16'd0) $display("Test 2 (All zeros): PASS");
        else $display("Test 2 (All zeros): FAIL - Expected 0, Got %d", total_cost);

        // Test 3: Distance <=10 (bucket 1), path 001 (5%), type 00 (1x), highway=0, adults=1, children=0
        // Expected: base=10 (5*2), extra=(10*5)/100=0, highway=0, final=10, type=10, total=10*1=10
        distance = 8'd5;
        path = 3'b001;
        journey_type = 2'b00;
        highway_distance = 8'd0;
        num_adults = 8'd1;
        num_children = 8'd0;
        #1;
        if (total_cost == 16'd10) $display("Test 3 (Dist<=10, path001, type00): PASS");
        else $display("Test 3 (Dist<=10, path001, type00): FAIL - Expected 10, Got %d", total_cost);

        // Test 4: Distance <=10, path 001, type 00, highway=5, adults=1, children=0
        // Expected: base=10, extra=0, highway=5, final=15, type=15, total=15
        highway_distance = 8'd5;
        #1;
        if (total_cost == 16'd15) $display("Test 4 (Highway extra): PASS");
        else $display("Test 4 (Highway extra): FAIL - Expected 15, Got %d", total_cost);

        // Test 5: Distance <=10, path 001, type 01 (1.9x), highway=0, adults=0, children=1
        // Expected: base=10, extra=0, highway=0, final=10, type=(10*19)/10=19, total=19*1=19
        highway_distance = 8'd0;
        journey_type = 2'b01;
        num_adults = 8'd0;
        num_children = 8'd1;
        #1;
        if (total_cost == 16'd19) $display("Test 5 (Type01, only children): PASS");
        else $display("Test 5 (Type01, only children): FAIL - Expected 19, Got %d", total_cost);

        // Test 6: Distance 11-35 (bucket 2), path 010 (10%), type 10 (2.5x), highway=0, adults=2, children=1
        // dist=20: base=(20*3)/2=30, extra=30*10/100=3, highway=0, final=33, type=(33*25)/10=82, total=82*3=246
        distance = 8'd20;
        path = 3'b010;
        journey_type = 2'b10;
        num_adults = 8'd2;
        num_children = 8'd1;
        #1;
        if (total_cost == 16'd246) $display("Test 6 (Dist11-35, path010, type10, adults+children): PASS");
        else $display("Test 6 (Dist11-35, path010, type10, adults+children): FAIL - Expected 246, Got %d", total_cost);

        // Test 7: Distance 11-35, path 100 (0%), type 00, highway=10, adults=1, children=0
        // dist=20: base=30, extra=0, highway=10, final=40, type=40, total=40
        path = 3'b100;
        journey_type = 2'b00;
        highway_distance = 8'd10;
        num_adults = 8'd1;
        num_children = 8'd0;
        #1;
        if (total_cost == 16'd40) $display("Test 7 (Path100, highway): PASS");
        else $display("Test 7 (Path100, highway): FAIL - Expected 40, Got %d", total_cost);

        // Test 8: Distance >35 (bucket 3), path 000 (default 0%), type 11 (default 1x), highway=0, adults=1, children=1
        // dist=40: base=40*1=40, extra=0, highway=0, final=40, type=40, total=40*2=80
        distance = 8'd40;
        path = 3'b000;
        journey_type = 2'b11;
        highway_distance = 8'd0;
        num_adults = 8'd1;
        num_children = 8'd1;
        #1;
        if (total_cost == 16'd80) $display("Test 8 (Dist>35, default path, default type): PASS");
        else $display("Test 8 (Dist>35, default path, default type): FAIL - Expected 80, Got %d", total_cost);

        // Test 9: Edge distance=10 (bucket1), path=001, type=01, highway=0, adults=0, children=0
        // base=20, extra=1 (20*5/100=1), final=21, type=39 (21*19/10=39.9->39), total=0 (no passengers)
        distance = 8'd10;
        path = 3'b001;
        journey_type = 2'b01;
        num_adults = 8'd0;
        num_children = 8'd0;
        #1;
        if (total_cost == 16'd0) $display("Test 9 (No passengers): PASS");
        else $display("Test 9 (No passengers): FAIL - Expected 0, Got %d", total_cost);

        // Test 10: Edge distance=35 (bucket2), path=010, type=10, highway=5, adults=3, children=2
        // base=(35*3)/2=52, extra=52*10/100=5, highway=5, final=62, type=(62*25)/10=155, total=155*5=775
        distance = 8'd35;
        path = 3'b010;
        journey_type = 2'b10;
        highway_distance = 8'd5;
        num_adults = 8'd3;
        num_children = 8'd2;
        #1;
        if (total_cost == 16'd775) $display("Test 10 (Dist=35 edge): PASS");
        else $display("Test 10 (Dist=35 edge): FAIL - Expected 775, Got %d", total_cost);

        // Test 11: Edge distance=36 (bucket3), path=100, type=00, highway=0, adults=1, children=0
        // base=36*1=36, extra=0, highway=0, final=36, type=36, total=36
        distance = 8'd36;
        path = 3'b100;
        journey_type = 2'b00;
        num_adults = 8'd1;
        num_children = 8'd0;
        #1;
        if (total_cost == 16'd36) $display("Test 11 (Dist=36 edge): PASS");
        else $display("Test 11 (Dist=36 edge): FAIL - Expected 36, Got %d", total_cost);

        // Test 12: Max distance=255 (bucket3), path=001, type=01, highway=255, adults=1, children=1
        // base=255*1=255, extra=(255*5)/100=12, highway=255, final=522, type=(522*19)/10=991, total=991*2=1982
        distance = 8'd255;
        path = 3'b001;
        journey_type = 2'b01;
        highway_distance = 8'd255;
        num_adults = 8'd1;
        num_children = 8'd1;
        #1;
        if (total_cost == 16'd1982) $display("Test 12 (Max dist+highway): PASS");
        else $display("Test 12 (Max dist+highway): FAIL - Expected 1982, Got %d", total_cost);

        // Test 13: Large passengers, small dist to check potential overflow behavior
        // dist=1, path=000, type=00, highway=0, adults=255, children=255
        // base=2, extra=0, highway=0, final=2, type=2, total=2*510=1020
        distance = 8'd1;
        path = 3'b000;
        journey_type = 2'b00;
        highway_distance = 8'd0;
        num_adults = 8'd255;
        num_children = 8'd255;
        #1;
        if (total_cost == 16'd1020) $display("Test 13 (Max passengers, small dist): PASS");
        else $display("Test 13 (Max passengers, small dist): FAIL - Expected 1020, Got %d", total_cost);

        // Test 14: Overflow case example - large values
        // dist=255, path=010 (10%), type=10 (2.5x), highway=255, adults=100, children=100
        // base=255, extra=25, highway=255, final=535, type=(535*25)/10=1337, total=1337*200=267400 (will wrap in 16-bit)
        // Expected wrapped: 267400 % 65536 = 267400 - 4*65536 = 267400 - 262144 = 5256
        distance = 8'd255;
        path = 3'b010;
        journey_type = 2'b10;
        highway_distance = 8'd255;
        num_adults = 8'd100;
        num_children = 8'd100;
        #1;
        if (total_cost == 16'd5256) $display("Test 14 (Overflow wrap): PASS");
        else $display("Test 14 (Overflow wrap): FAIL - Expected 5256 (wrapped), Got %d", total_cost);

        $display("Testbench completed.");
        $finish;
    end

endmodule