
//4791
// gameboard controller

module Game_controller(button_push,enable,recon_bit,rst,clk,rng_b,ld2,rngOut,ld2Out,time_Out,timer_reset,score_reset,access_allowed,logout_from_game_controller);

//Inputs and outputs
     input button_push;
	  input access_allowed;
     input rst,clk,rng_b,ld2,time_Out;
     output reg rngOut,ld2Out;
     output reg enable,recon_bit,logout_from_game_controller;
	 // output reg DonotB_Out;
     reg okflag;
	  reg start_button_timer, one_sec_wait,check_for_3press;
	  wire Time_out_button_timer;
	  output reg timer_reset,score_reset;
	  reg one_sec_reset;
     
     

 //register to store state
reg [1:0] state;
parameter S0=0,S1=1,S2=2,S3=3;


//modules
 TimerOneSecond T1_ACCESS (clk,rst,start_button_timer,Time_out_button_timer,one_sec_reset);	 ///timer module
			

always@(posedge clk) 
begin
if(rst==0)
begin
        state<=S0;
		  timer_reset<=0;
		  score_reset<=0;
        rngOut<=0;
        ld2Out<=0;
        enable<=0; // game
        recon_bit<=0; // game 
end
else
  begin
  
			
case (state)

   
//wait for button to reconfigure timer
S0: begin  
			timer_reset<=0;
			score_reset<=0;
			logout_from_game_controller<=0;
         if (button_push==1 && access_allowed == 1) 
          begin
				recon_bit<=1;
				state<= S1;
           end                
           else
state<=S0;
end


S1: begin // timer recomfigured and waiting for button input
		score_reset <=0; // score reset was done if coming from 2 button press within one second
      recon_bit<=0;
      if(button_push==1) // start game / timer
			begin
			if (check_for_3press==0 ) // start if not third press in one second
				begin
					one_sec_wait <=0;
					enable<=1;
					start_button_timer <= 0; ///stop timer 1 sec
					state<=S2;
				end

			else if (check_for_3press==1 && one_sec_wait == 0) // check if third press within one second //  LOGOUT
				begin
					one_sec_wait <=0;
					check_for_3press <=0;
					start_button_timer <= 0; ///stop timer 1 sec 
					//logout 
					enable<=0;
					ld2Out<=0;
					rngOut<=0;
					timer_reset<=1;
					score_reset<=1;
					logout_from_game_controller<=1;
					state<=S0;
				end
				
			else if (check_for_3press==1 && one_sec_wait == 1) // after 1 second 
				begin
					one_sec_wait <=0;
					enable<=1;
					start_button_timer <= 0; ///stop timer 1 sec
					state<=S2;
				end
				
			end
								
		else // button not pressed check for the timer out 1 second
				begin
				state<=S1;
				if (Time_out_button_timer == 1 )  // pulse to signal // check the pusle from 1 sec internal timer //check 3rd press
				begin
				one_sec_wait <= 1;
				check_for_3press<=0;
				end 
				end
		 
		
   end
	
         
S2: begin // timer rugging state  state 7
     if(time_Out==1) // wait for time out of game  // LOGOUT
      begin
      enable<=0;
      ld2Out<=0;
      rngOut<=0;
		logout_from_game_controller<=1;
      state<=S0;

    end
	 
	 else if (button_push==1) // go to wait state s 8
		begin
			one_sec_reset <=1; // reset the one second internal timer and enter wait state
			state<=S3;
		end
	 
    
	 else
       begin
          state<=S2;
          ld2Out<=ld2;
          rngOut<=~rng_b;
       end
    end
      
		
	////
S3: begin  // pause / wait 1 second  state 

		one_sec_reset <=0; // stop reset signal of  1 sec timer
     if(button_push==1 && one_sec_wait ==1)  // go back to s7 // button press after 1 sec
       begin
			enable<=1;
			ld2Out<=ld2;
         rngOut<=~rng_b;
			start_button_timer<=0;  //stop timer 1sec
			one_sec_wait <= 0;
         state<=S2;
			
       end
		 
		 else if (button_push==1 && one_sec_wait==0)  // timer reconfigured and waiting for game start // need to reset score
		 
		 begin
		  recon_bit<=1;
		  check_for_3press <=1;
		  score_reset <=1;
        state<=S1;
		  
		 end
		 
		 
      else  // stay paused
       begin
		 		
		 	start_button_timer<=1; // start wait 1 second timer	
		 	enable<=0;
			ld2Out<=0;
			rngOut<=0;
				if (Time_out_button_timer == 1 )  // pulse to signal //  // check the pusle from 1 sec internal timer  // second press in 1 sec
				begin one_sec_wait = 1; end  
			state<=S3; 

       end
    end
          
default:
  begin
    state<=S0;
  end
 endcase

end
end
endmodule

   