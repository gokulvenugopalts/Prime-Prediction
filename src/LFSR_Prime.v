// Author:JOY REBELLO 4719
//Final Project
// Module LFSR_Prime
// This module generates a random prime number between 0 to 127
// module expects a pulse as enable input and will generate output as Q_out

module LFSR_Prime(clk,rst,enable,primeNumberOutput, score);
	input clk,rst,enable;
	input [6:0] score;
	output [6:0] primeNumberOutput;
	wire [6:0] primeNumberInput, randomNumber;
	wire findPrimeEnable, levelAdjustEnable;
	//instantiate module
	LFSR_7bit_Random DUT_LFSR_7bit_Random(clk,rst,enable,randomNumber,levelAdjustEnable);
	Next_Prime DUT_Next_Prime(clk,rst,primeNumberInput,primeNumberOutput,findPrimeEnable);
	levelAdjust DUT_levelAdjust(clk, rst, score, randomNumber, levelAdjustEnable, primeNumberInput, findPrimeEnable);
endmodule




