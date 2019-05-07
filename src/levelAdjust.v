module levelAdjust( clk, rst, score, primeNumberInput, levelAdjustEnable, primeNumberOutput, findPrimeEnable);
	input clk, rst, levelAdjustEnable;
	output reg findPrimeEnable;
	input[6:0] score, primeNumberInput;
	output reg[6:0] primeNumberOutput;
	
	always @ (posedge clk)
		begin
			if(rst == 0)
				begin
					primeNumberOutput <= 0;
					findPrimeEnable <= 0;
				end
			else
				begin
					if(levelAdjustEnable == 1)
						begin
							findPrimeEnable = 1;
							if(score < 25)
								begin
									primeNumberOutput <= primeNumberInput % 25;
								end
							else if(score < 50)
								begin
									primeNumberOutput <= primeNumberInput % 50;
								end
							else if(score < 75)
								begin
									primeNumberOutput <= primeNumberInput % 75;
								end
							else
								begin
									primeNumberOutput <= primeNumberInput % 100;
								end
						end
					else
						begin
							findPrimeEnable = 0;
						end
				end
		end
endmodule