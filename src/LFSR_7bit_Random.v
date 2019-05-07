// Author:JOY REBELLO 4719
//Final Project
// LFSR_7bit_Random
// This module is a one to many LFSR used to generate random number between 0 to 127

module LFSR_7bit_Random(clk,rst,enable,primeNumber,findPrimeEnable);

  input clk,rst,enable;
  output reg [6:0] primeNumber;
  output reg findPrimeEnable;
  reg generate_number;
  reg [6:0] LFSR;
  wire feedback = LFSR[6];

	always @(posedge clk)
		begin
		  if (rst==0)
				begin
					LFSR<=7'b0000000;
					primeNumber <= 0;
					findPrimeEnable <= 0;
				end
		  else // reset
				begin
					LFSR[0] <= feedback;
					LFSR[1] <= LFSR[0] ~^ feedback;
					LFSR[2] <= LFSR[1];
					LFSR[3] <= LFSR[2] ~^ feedback;
					LFSR[4] <= LFSR[3];
					LFSR[5] <= LFSR[4];
					LFSR[6] <= LFSR[5] ~^ feedback;
					if(enable == 1)
						begin
							generate_number <= 1;
							primeNumber<=LFSR;
						end
					else
						begin
							if (generate_number ==1)
								begin
									// once randomnumber is generated send signal to the next module to find prime number
									findPrimeEnable <= 1; 
									generate_number <=0;
								end
							else  // generate_number =0
								begin
									findPrimeEnable <= 0;
									//primeNumber<=0;
								end
						end// enable
				end // reset
		end//main module
endmodule
