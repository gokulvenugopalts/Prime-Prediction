// ECE6370
// Homework 8
// Author:JOY REBELLO 4719
// Random number generator
// button_press -- push button input
// button_press_inv -- inverting the input
// rst -- reset 
// clk -- clock
// gen_out -- random number generator output 4 bit
// Main Module

module Random_Num_Gen(button_press,rst,clk,gen_out);

input button_press;
input rst,clk;
output [3:0] gen_out;
reg [3:0] gen_out;
reg [3:0]count;

assign button_press_inv = ~button_press; // input inverted before counting

always@(posedge clk) 
	begin
		if(rst==0)
			begin
			gen_out<=0;
			count<=0;
			end
		else
			begin
			if(button_press_inv==1) // button pressed -- strart counter
				begin
					if(count==16)
						begin
						count<=0;
						end
					else
						begin  
						count<=count+4'b0001;
						end
				end
			else
				gen_out<=count;  // button not pressed --- load output with current count
		end
	end
endmodule
