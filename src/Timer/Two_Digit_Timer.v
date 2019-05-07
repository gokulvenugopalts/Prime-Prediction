// Course: ECE 6370
// Author: 8626 
// Design a Ten's digit Timer
// This module used for the timer
// Here there are 6 inputs and 2 outputs.


module Two_digit_timer(clk, reset, tens_timer_in, DNB_in_10s, reconfig, DNB_out_10s, h_timer_in, ten_d_out);
 
  
   input clk,reset,tens_timer_in,DNB_in_10s,reconfig; 
   output reg[3:0] ten_d_out ;
   output reg DNB_out_10s,h_timer_in;
  


always@(posedge clk) 
  begin
   if(reset==0)
      begin
        ten_d_out<= 0;
        DNB_out_10s<= 0;
        h_timer_in<= 0;
      end
	  
   else
   
       if(reconfig==1)
          begin
             ten_d_out<=4'1001;
			 DNB_out_10s<=0;
          end
		  
       else
	   
          begin
             if(tens_timer_in==1)
                begin
                  if(ten_d_out== 0)
                     begin
                       DNB_out_10s<= 1; 
                      end
					  
                    else 
					
                      begin
                        ten_d_out<=ten_d_out-4'b0001;
                          if(ten_d_out==4'b0001)
                            begin
                              DNB_out_10s<= 1;
                            end
                          else
                            begin
                              h_timer_in<=0; 
                              DNB_out_10s<= 0;
                            end
                      end
                end
				
             else
			 
               begin
			      if(ten_d_out== 0)
                     begin
                       DNB_out_10s<= 1; 
                      end					
                  h_timer_in<= 0;
                  ten_d_out<= ten_d_out ;
               end
          end
 end
endmodule

