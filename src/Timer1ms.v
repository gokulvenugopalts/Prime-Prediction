
module Timer1ms(clk, reset, enable, timeOut);
input clk, reset;
input enable;
output timeOut;
reg timeOut;
reg [15:0] counter;
always @ (posedge clk)
begin

	if (reset == 0)
	begin
		timeOut <= 0;
		counter <= 0;
	end
	
	else
	begin
		if(enable == 0)
			begin
				counter <=0;
				timeOut <=0;
			end
			
		else
			begin
				if (counter >50000)
					begin
						counter<=0;
					end
				else if(counter == 50000)
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

