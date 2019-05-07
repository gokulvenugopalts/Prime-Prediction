// Course: ECE 6370
// Author: 8626 
// Design a One's digit Timer
// This module used for the timer
// Here there are 6 inputs and 2 outputs.


module one_digit_timer(clk, reset, one_sec_in, DNB_out_10s, reconfig, game_timeout, tens_timer_in, one_d_out); 
   
   input clk,reset,one_sec_in,DNB_out_10s,reconfig; 
   output reg[3:0] one_d_out ;
   output reg game_timeout,tens_timer_in;
 


always@(posedge clk) 
  begin
   if(reset==0)
      begin
        one_d_out<= 0;
        game_timeout<= 0;
        tens_timer_in<= 0;
      end
	  
   else
	   begin
   
   
       if(reconfig==1)
          begin
             one_d_out<=4'1001;
			 game_timeout <= 0;
          end
       else
          begin
             if(one_sec_in==1)
			 begin
				 begin
  
					if(one_d_out == 4'b0000 && DNB_out_10s == 1 ) 
						begin
							game_timeout <= 1;
						end	       
                  else if(one_d_out == 0)
                     begin
                       if(DNB_out_10s == 0)
                          begin
                             one_d_out<=4'b1001;
                             tens_timer_in<= 1; 
                          end
                       else 
                          begin
                             one_d_out<=4'b0000;
                             tens_timer_in<=0; 
							
                          end
                      end
					  
					  
					  
                    else 
                      begin
                        one_d_out<=one_d_out-4'b001;
                        tens_timer_in<= 0;
						
                      end
                end
					 end
             else
               begin
                  tens_timer_in<= 0;
                  one_d_out<= one_d_out ;
               end
          end
			 
	end
 end
endmodule

