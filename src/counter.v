
module counter( clk, reset, begin_count, count);
input clk, reset;
input begin_count;
output [3:0] count;
reg [3:0] count;



always @ (posedge clk)
begin
	if (reset == 0)
		begin
			count <= 0;
		end

	else if((count == 15) | (count > 15))
		begin
			count <= 0;
		end
	else
		begin
			begin
				if (begin_count == 1 )
					begin
						count <= count + 1;
					end
			end
		end
end 
endmodule
