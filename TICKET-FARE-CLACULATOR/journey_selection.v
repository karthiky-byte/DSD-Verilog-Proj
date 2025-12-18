module journey_selection (
input [2:0] path, // Path selection inputs
input rd, // Reset
input [1:0] journey_type, // Journey type: 00=Sitting, 01=Sleeper, 10=AC Sleeper
input [7:0] distance, // Distance of the journey in km
input [7:0] highway_distance,// Highway distance in km
input [7:0] num_adults, // Number of adults
input [7:0] num_children, // Number of children
output reg [15:0] total_cost // Total cost
);
reg [15:0] base_cost; // Base cost calculated by distance
reg [15:0] percent_extra; // Percentage extra charge based on path
reg [15:0] highway_cost; // Highway cost
reg [15:0] final_cost; // Final fare after all calculations
always @(*)
begin
if (rd)
begin
total_cost = 16'd0;
base_cost = 16'd0;
percent_extra = 16'd0;
highway_cost = 16'd0;
final_cost = 16'd0;
end
else
begin
// Step 1: Calculate cost per km based on distance
if (distance <= 10)
base_cost = (distance * 2'd2); // ₹2 per km
else if (distance <= 35)
base_cost = ((distance * 2'd3) / 2'd2); // ₹1.5 per km (fixed-point)
else
base_cost = distance * 2'd1; // ₹1 per km
// Step 2: Calculate percentage extra charge based on path
case (path)
3'b001: percent_extra = (base_cost * 5) / 100; // Non-stop: 5%
3'b010: percent_extra = (base_cost * 10) / 100; // Express: 10%
3'b100: percent_extra = 16'd0; // Local Passenger: 0%
default: percent_extra = 16'd0;
endcase
// Step 3: Calculate highway cost
highway_cost = highway_distance * 2'd1; // ₹1 per km for highway
// Step 4: Add extra charges to base cost
final_cost = base_cost + percent_extra + highway_cost;
// Step 5: Apply journey type multiplier
case (journey_type)
2'b00: final_cost = final_cost; // Sitting: No extra cost
2'b01: final_cost = (final_cost * 19) / 10; // Sleeper: 1.9x fare
2'b10: final_cost = (final_cost * 25) / 10; // AC Sleeper: 2.5x fare
default: final_cost = final_cost; // Default: No change
endcase
// Step 6: Assign final cost to output
total_cost = ((final_cost * num_adults) + (final_cost * num_children));
end
end
endmodule