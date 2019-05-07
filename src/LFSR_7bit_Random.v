// Author:JOY REBELLO 4719
//Final Project
// LFSR_7bit_Random
// This module is a one to many LFSR used to generate random number between 0 to 127

module LFSR_7bit_Random(clk,rst,enable,Q,FindPrime);

  input clk,rst,enable;
  reg [6:0] count;
  output reg [6:0] Q;
  output reg FindPrime;
  reg generate_number;
  reg [6:0] LFSR;
  wire feedback = LFSR[6];

always @(posedge clk)
begin
  if (rst==0)
		begin
		count<=0;
		LFSR<=7'b0000000;
		end
  else // reset
		begin
			if(enable == 1)
				begin
				generate_number <= 1;
				LFSR<=7'b0000000;
				end
			
			else
			
			if (generate_number ==1)
			begin
				count<=count+1;
				LFSR[0] <= feedback;
				LFSR[1] <= LFSR[0] ~^ feedback;
				LFSR[2] <= LFSR[1];
				LFSR[3] <= LFSR[2] ~^ feedback;
				LFSR[4] <= LFSR[3];
				LFSR[5] <= LFSR[4];
				LFSR[6] <= LFSR[5] ~^ feedback;
				if(count==127)
					begin
						Q<=LFSR;
						// once randomnumber is generated send signal to the next module to find prime number
						FindPrime <= 1; 
						generate_number <=0;
						count <=0;
					end
				else // count
					begin
					Q<=LFSR;
					FindPrime <= 0;end
			end// enable
		end // reset
end//main module
endmodule
