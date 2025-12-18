#  Journey Fare Calculator (Verilog)

##  Introduction
This project is a **Verilog HDL module** designed to calculate the total travel fare for a journey. It takes various inputs like distance, journey type (Sitting/Sleeper), highway usage, and passenger count to compute the final ticket cost dynamically.

##  Key Features
* **Distance-Based Pricing:** automatically adjusts the rate per km based on the total distance (Tiered pricing).
* **Journey Types:** Supports Sitting, Sleeper, and AC Sleeper classes with specific price multipliers.
* **Path Selection:** Adds a surcharge for Express or Non-stop routes.
* **Passenger Calculation:** Computes total cost for multiple adults and children.
* **Highway Toll:** Adds specific costs for highway usage.

##  Pin Description
| Signal Name | Direction | Width | Description |
| :--- | :--- | :--- | :--- |
| `clk` | Input | 1-bit | Clock signal (Implicit in logic) |
| `rd` | Input | 1-bit | **Reset**: Clears all costs to 0 when High. |
| `path` | Input | 3-bit | Selects route: `001` (Non-stop), `010` (Express), `100` (Local). |
| `journey_type` | Input | 2-bit | `00` (Sitting), `01` (Sleeper), `10` (AC Sleeper). |
| `distance` | Input | 8-bit | Total distance of the journey in km. |
| `highway_dist` | Input | 8-bit | Distance covered on the highway in km. |
| `num_adults` | Input | 8-bit | Number of adult passengers. |
| `num_children` | Input | 8-bit | Number of child passengers. |
| `total_cost` | Output | 16-bit | The final calculated fare. |

##  Calculation Logic
The module calculates the cost in **6 Steps**:

1.  **Base Rate Calculation:**
    * 0-10 km: **₹2/km**
    * 11-35 km: **₹1.5/km**
    * 35+ km: **₹1/km**
2.  **Path Surcharge:**
    * Non-stop (`001`): **+5%**
    * Express (`010`): **+10%**
    * Local (`100`): **0%**
3.  **Highway Cost:** Adds **₹1 per km** traveled on the highway.
4.  **Journey Type Multiplier:**
    * Sitting: **1x** (No extra charge)
    * Sleeper: **1.9x**
    * AC Sleeper: **2.5x**
5.  **Final Total:**
    * `(Cost Per Person) * (Adults + Children)`
