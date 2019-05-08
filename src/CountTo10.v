//4014

module CountTo10(clk, reset, count, timeOut);
input clk, reset;
input count;
output timeOut;
reg timeOut;
reg [0:3] counter;
always @ (posedge clk)
begin

	if (reset == 0)
	begin
		timeOut <= 0;
		counter <= 0;
	end
	
	else
	begin
		if(count == 0)
			begin
				counter <= counter;
				timeOut <= 0;
			end
		else 
			begin
				if(counter >10)
					begin
						counter<=0;
					end
				else if(counter == 10)
					begin
						counter <= 0;
						timeOut <= 1;
					end
			
				else
					begin 
						timeOut <= 0;
						counter <= counter + 1;
					end 
		     end
		end
end
endmodule

