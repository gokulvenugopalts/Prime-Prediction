`timescale 1ns/1ns

module LFSR_Prime_tb();
	reg clk, rst, enable;
	reg[6:0] score;
	wire[6:0] primeNumberOutput;
	LFSR_Prime DUT_LFSR_Prime(clk,rst,enable,primeNumberOutput, score);
	
	always begin
		#5 clk = 1;
		#5 clk = 0;
	end
	
	initial
		begin
			rst = 0;
			enable = 0;
			@(posedge clk)
			@(posedge clk)
			@(posedge clk)
			rst = 1;
			@(posedge clk)
			@(posedge clk)
			enable = 1;
			score = 7'b0001111;
			@(posedge clk)
			enable = 0;
			#1000
			#500
			//rst = 0;
			@(posedge clk)
			@(posedge clk)
			//rst = 1;
			@(posedge clk)
			@(posedge clk)
			enable = 1;
			score = 7'b0011111;
			@(posedge clk)
			enable = 0;
			
		end
endmodule
