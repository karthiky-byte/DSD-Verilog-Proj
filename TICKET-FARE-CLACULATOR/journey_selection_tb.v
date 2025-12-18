module journey_selection_tb;
// Inputs
reg [2:0] path; // Path selection inputs
reg rd; // Reset
reg [1:0] journey_type; // Journey type: 00=Sitting, 01=Sleeper, 10=AC Sleeper
reg [7:0] distance; // Distance of the journey in km
reg [7:0] highway_distance; // Highway distance in km
reg [7:0] num_adults; // Number of adults
reg [7:0] num_children; // Number of children
// Output
wire [15:0] total_cost; // Total cost

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
// Apply Reset
rd = 1; // Reset active
path = 3'b000; // Default path
journey_type = 2'b00; // Default journey type
distance = 8'd0; // Default distance
highway_distance = 8'd0; // Default highway distance
num_adults = 8'd0; // Default number of adults
num_children = 8'd0; // Default number of children
#10 rd = 0; // Release reset
// Test Case: Non-stop journey, Sleeper, with highway
path = 3'b001; // Non-stop journey
journey_type = 2'b01; // Sleeper
distance = 8'd20; // Distance: 20 km

9

highway_distance = 8'd5; // Highway distance: 5 km
num_adults = 8'd2; // 2 adults
num_children = 8'd1; // 1 child
#50;
$stop;
end
endmodule