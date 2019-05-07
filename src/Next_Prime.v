// Author:JOY REBELLO 4719
//Final Project
// Next_Random
// finds next prime number after the input 7 digit number.

module Next_Prime(clk,rst,primeNumberInput,primeNumberOutput,findPrimeEnable);
	input clk,rst,findPrimeEnable;
	input [6:0] primeNumberInput;
	reg [6:0] primeNumberInput_temp,count;
	output reg [6:0] primeNumberOutput;
	reg[6:0] factor;

	always @(posedge clk)
		begin
			if (rst==0)
				begin
					count<=0;
					primeNumberInput_temp<=0;
					primeNumberOutput<=0;
					factor <= 2;
				end
			else
				begin
					if (findPrimeEnable == 1) 	// NEW NUMBER 
						begin
							if(primeNumberInput <=2)
								begin
									primeNumberInput_temp <= 2;
								end
							else
								begin
									primeNumberInput_temp<=primeNumberInput;
								end
							count <=2; // set counter to 2
							factor <= 2;
						end
					else // NOT A NEW NUMBER
						begin
							if(factor >= primeNumberInput_temp && count == 2)
								begin
									primeNumberOutput <= primeNumberInput_temp;
								end
							else
								begin
									if(count <=2)
										begin
											if(primeNumberInput_temp%factor == 0)
												begin
													count <= count + 1;
												end
											else
												begin
													factor <= factor + 1;
												end
										end
									else
										begin
											factor <= 2;
											count <= 2;
											if(primeNumberInput_temp > 99)
												begin
													primeNumberInput_temp <= 2;
												end
											else
												begin
													primeNumberInput_temp <= primeNumberInput_temp + 1;
												end
										end
									
								end
						
						
							// if number less than 2 then output is 2	// corner case
						/*	if(primeNumberInput_temp<=2)
								begin
									primeNumberOutput<=2;  
								end
							else if (count < primeNumberInput_temp)
								begin
							// is not prime 
									if (primeNumberInput_temp%count==0)
									begin
									primeNumberInput_temp<=primeNumberInput_temp+1;
									count =2; //set counter to 2 and start checking again
									end	
								end
							/// not prime then increase count till count < Q_temp
							else	
								begin
									if(count == primeNumberInput_temp-1) // if counter reached maximum value and number is still not divisible
										begin 
											primeNumberOutput <=primeNumberInput_temp; 
										end
									else
										begin 
											count <= count+1; 
										end // increase counter
								end	*/
						end 
				end // reset 
		end
endmodule

