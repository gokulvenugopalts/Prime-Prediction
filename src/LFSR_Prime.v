// Author:JOY REBELLO 4719
//Final Project
// Module LFSR_Prime
// This module generates a random prime number between 0 to 127
// module expects a pulse as enable input and will generate output as Q_out

module LFSR_Prime(clk,rst,enable,Q_out);

input clk,rst,enable;
output [6:0]Q_out;
wire [6:0] Q_wire;
wire FindPrime;


//instantiate module
LFSR_7bit_Random LFSR1(clk,rst,enable,Q_wire,FindPrime);
Next_Prime NR1(clk,rst,Q_wire,Q_out,FindPrime);

endmodule




