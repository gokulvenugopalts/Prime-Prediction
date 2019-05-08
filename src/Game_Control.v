
	module Game_Control(clk,rst,Load_Button_PSWD_Game_Control,Authenticated,Time_Out_Pulse,Time_Out_Pulse_Timer2,pushButtonLoad_RNG, pushButtonLoad2,load_sig_RNG, 
							load_sig_2,Enable_Timer1,Enable_Timer2,Logout,Reset_The_Game,Reconfig);
	input clk,rst;
// authenticated signal is from the Multi_Password_ROM and the Load_Button_PSWD_Game_Control is the push button from load register	
	input Authenticated,Load_Button_PSWD_Game_Control; 
// Time_Out_Pulse is the Time out pulse from the Digit Timer which count down to zero and Time_Out_Pulse_Timer2 is the time out which is used for play/resume, reload nad the logout feature
	input Time_Out_Pulse,Time_Out_Pulse_Timer2; 
// pushButtonLoad_RNG input from the push button to generate the random number and pushButtonLoad2 input for the player 
	input pushButtonLoad_RNG, pushButtonLoad2 ;   
// Enable_Timer1 siganl to enable the digit timer and Enable_Timer2 signal to enable the special feature
// Logout signal is output from the Game_Control module and input to the Multi_Password_ROM
// Reset_The_Game signal is to clear the timer display when it is logged out in between the game
// Reconfig is input to the Digit timer to configure the timer value	
	output reg Enable_Timer1,Enable_Timer2,Logout,Reset_The_Game,Reconfig;
	output reg load_sig_RNG, load_sig_2;	//load module to load the random number generator and player input
	
	reg flag;
	reg [3:0] state;
	reg [3:0]count_no_push;
	
	parameter Initial = 0, Load_Timer = 1, Start_Timer1 = 2,
				Game_Run_State = 3, no_of_Time_load_Button_pressed = 4,
				Select_Feature = 5, Pause_State = 6, Resume_State = 7,
				Reload_State = 8, Logout_State = 9, Time_Out_State = 10,Wait_State = 11;
	
	//reset condition
	always @(posedge clk) begin
		
		if (rst == 0) begin
			flag <=1;
			load_sig_RNG <= 1;     
			load_sig_2 <= 0;
			Logout <= 0;
			Reconfig <= 0;
			Enable_Timer1 <=0;
			Reset_The_Game <= 0;
			Enable_Timer2 <= 0;
			state <= Wait_State;
		end
		else begin
			case (state)
			
			Wait_State: begin
							state <= Initial;
							Logout <= 0;
			end
	// Waiting for the authenticated signal from the Multi_Password_ROM		
			Initial: begin
						if (Authenticated == 1) begin
							state <= Load_Timer;
							Enable_Timer1 <= 0;
							Reset_The_Game <= 0;
							Logout <= 0;
							Enable_Timer2 <= 0;
							Reconfig <= 0;
						end
						else begin
							state <= Initial;
						end
			end
			
			// In this stage we are loading the Digit timer timing
			Load_Timer: begin
							if (Load_Button_PSWD_Game_Control == 0) begin
								state <= Load_Timer;
								Reconfig <= 0;
							end
							else begin
								Reconfig <= 1;
								state <= Start_Timer1;
							end
			end
			
			// In  this stage we are enabling the timer1 one sec				
			Start_Timer1: begin
							Reconfig <= 0;
							if (Load_Button_PSWD_Game_Control == 0) begin
								state <= Start_Timer1;
							end
							else begin
								Enable_Timer1 <= 1;
								state <= Game_Run_State;
							end
			end
			
			//checking for the time out pulse also checking if the button is pressed. If button is pressed timer 2 will start.	
			Game_Run_State: begin
								load_sig_RNG <= pushButtonLoad_RNG;
								load_sig_2 <= pushButtonLoad2;
								Reset_The_Game <= 0;
								
								if (Time_Out_Pulse == 1) begin
									state <= Time_Out_State;
								end
								else if ((Time_Out_Pulse == 0) && (Load_Button_PSWD_Game_Control ==1)) begin
									state <= no_of_Time_load_Button_pressed;
									Enable_Timer2 <= 1;
								end
								else begin
									state <= Game_Run_State;
								end
			end	
			
			// waiting for timer 2 time out pulse
			no_of_Time_load_Button_pressed: begin
							if (Load_Button_PSWD_Game_Control == 1 && Time_Out_Pulse_Timer2 == 0) begin
								count_no_push <= count_no_push + 1; //to count how many time push button is pressed
								state <= no_of_Time_load_Button_pressed;
							end
							else if (Load_Button_PSWD_Game_Control == 0 && Time_Out_Pulse_Timer2 == 0) begin
								state <= no_of_Time_load_Button_pressed;
							end
							else if (Time_Out_Pulse_Timer2 == 1) begin
								Enable_Timer2 <= 0;
								state <= Select_Feature;
							end
			end
	
			// In this decision is made to which state is should go depending on how many times the button is pressed
			Select_Feature: begin
								if(count_no_push == 0) begin
									count_no_push <= 0;
									state <= Pause_State;
									//Enable_Timer1 <=0;   //added by me to pause the timer
								end
								else if (count_no_push == 1) begin
									state <= Reload_State; //reload digit timer state
									Reset_The_Game <= 1;
									count_no_push <= 0;
								end
								else if (count_no_push == 2) begin
									state <= Logout_State;
									count_no_push <= 0;
									Reset_The_Game <= 1;
								end
								else if (count_no_push >=2) begin
									state <= Game_Run_State;
									count_no_push <= 0;
									Reset_The_Game <= 0; 
								end	
			end
			
			// Pause the game state
			Pause_State: begin
							Enable_Timer1 <= 0;
							state <= Resume_State;
			end
			
			// Resume the game
			Resume_State: begin
							if(Load_Button_PSWD_Game_Control == 0) begin
								state <= Resume_State;
							end
							else begin
								Enable_Timer1 <= 1;
								state <= Game_Run_State;
							end
            end	
			
			//reload timer state
			Reload_State: begin
							state <= Wait_State;
							Enable_Timer1 <= 0;
							Reset_The_Game <= 0;
			end	
				
			//Logout from the game 
			Logout_State: begin
							Logout <= 1;
							Enable_Timer1 <= 0;
							state <= Wait_State;
			end				

			// When the Time_Out_Pulse occurs it will jump to this state
			Time_Out_State: begin
								Enable_Timer1 <= 0;
								load_sig_RNG <= 0;
								load_sig_2 <= 0;
								if (Load_Button_PSWD_Game_Control == 0) begin
									state <= Time_Out_Pulse;
								end
								else begin
									state <= Wait_State;
								end
			end					
			//					s8:
	    //begin
			//enable <= 0;//to check
			//reset_timer <= 0;
		
			default: begin
						state <= Wait_State;
			end
			endcase
		end
	end
	endmodule

