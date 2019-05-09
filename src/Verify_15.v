module Verify_15(clk,rst,rng,ply2,adder,verifier_Out);

input clk,rst,ply2,rng;
input  adder;
output reg verifier_Out;
reg [2:0] state;
parameter s_init=0,s1=1,s2=2;

always@(posedge clk)
 begin
  if(rst==0)
    begin
     verifier_Out<=0;
     state<=s_init;
    end
  else
    begin
     case(state)
s_init: 
    begin
	 verifier_Out<=0;
     if(ply2==1)
	 state<=s1;
     else
	  state<=s_init;
    end
s1:
  begin
     if(adder==1)
        begin
          verifier_Out<=1;
	  state<=s_init;
        end
      else
         begin
           state<=s2;
         end
      end  
s2:
  begin
     verifier_Out<=0;
	if(rng==1)
	 state<=s_init;
   end
endcase
end
end
endmodule