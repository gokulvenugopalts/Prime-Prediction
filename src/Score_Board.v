//4791

module Score_Board(clk,rst,verify_Out,score_Out1,score_Out2,score_reset);
input clk,rst,verify_Out;
output reg [3:0] score_Out1,score_Out2;
input score_reset;


always @(posedge clk)
 begin
  if(rst==0)
   begin
     score_Out1<=4'b0000;
     score_Out2<=4'b0000;
   end
  else	
   begin
		   if (score_reset==1)
				begin
				     score_Out1<=4'b0000;
						score_Out2<=4'b0000;		
				end
			
			else 
			
			begin
			
    if(verify_Out==1)
     begin
      if(score_Out2==4'b1001)
        begin
         score_Out1<=score_Out1+4'b0001;
	  score_Out2<=4'b0000;
	end
     else
      score_Out2<=score_Out2+4'b0001;
      end  // verify out
    end // score reset
end	//reset 
 end // always
endmodule
