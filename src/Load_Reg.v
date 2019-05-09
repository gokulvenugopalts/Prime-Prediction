// ECE6370
// Lab2
// Author:JOY REBELLO 4719
// Load_Reg
// Used to load the data on load signal
// Load_Reg

module Load_Reg(in,q,clk,rst,load);
 	input[6:0] in;
	input clk,rst,load;
	output [6:0] q;
 	reg [6:0]q;
 	
	always @(posedge clk)
	
	begin
		if(rst==0) 
  			q<=7'b000000;
  		else 
 			begin
	  			if(load==1)
	  			q<=in;
	  		end
	end
endmodule
