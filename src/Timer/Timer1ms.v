// Course: ECE 6370
// Author: 8626 
// Design and Simulation of 1ms timer
// This module will count up and generate a One Cycle Timeout Pulse when is is Enabled
// Here the inputs are represented as reset, clk and enable
// Here the output is represented as timeout

module timer1ms(clk, reset, enable, timeout);
	input clk, reset, enable;
	output timeout;
	reg[15:0] count;
	reg timeout;

	always@(posedge clk)
	  begin
		if(reset==0)
		  begin
			timeout <= 0;
			count <= 0;
		  end
		else
		
		  begin
			if(enable==1)
			  begin
				count<=count+1;
				if(count == 49999)
				  begin
					timeout <= 1;
					count <= 0;
				  end
			else
			  begin
				timeout <= 0;				
			  end
		  end
		end  
		  
	  end
endmodule

		  

	
