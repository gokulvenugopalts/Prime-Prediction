// Course: ECE 6370
// Author: 8626 
// Design and Simulation of count to 100
// The module should count up when the "Count" input is a "1".
// Here the inputs are represented as reset, clk and count
// Here the output is represented as timeout

module count_to_100(clk, reset, count, timeout);
	input clk, reset, count;
	output timeout;
	reg[6:0] counter;
	reg timeout;
 
	always@(posedge clk)
	  begin
		if(reset==0)
		  begin
			timeout <= 0;
			counter <= 0;
		  end
		  
		else
		begin
			if(count==1)
			  begin
				counter <= counter + 1;
				if(counter == 99)
				  begin
					timeout <= 1;
					counter <= 0;
				  end
				else
				  begin
					timeout<=0;
				  end
			  end
		    else	  
			    begin
				timeout<=0;
				end			  
		end  
	  end
endmodule

		  

	
