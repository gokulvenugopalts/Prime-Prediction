//4791
// verified on board
module access_controller_ROM(button_push,toggle_switch,rst,clk,psd,green_LED,red_LED,access_allowed,logout_from_game_controller);

//Inputs and outputs
     input button_push;
	  input logout_from_game_controller;
     input [3:0] toggle_switch;
     input rst,clk;
     output [3:0] psd;
     reg [3:0] psd;
     output reg green_LED,red_LED, access_allowed;
	 // output reg DonotB_Out;
     reg okflag;
     
	  	reg[2:0] address = 3'b111;
		wire[3:0] rom_data;
     

 //register to store state
reg [4:0] state;
parameter s_INIT_S0=0,DELAY_1_S1=1,DELAY_2_s2=2,DIGIT_1_S3=3,
			 DIGIT_2_S4=4,DELAY_1_S5=5,DELAY_2_s6=6,DIGIT_2_S7=7,
			 DIGIT_3_S8=8,DELAY_1_S9=9,DELAY_2_s10=10,DIGIT_3_S11=11,
			 DIGIT_4_S12=12,DELAY_1_S13=13,DELAY_2_S14=14,DIGIT_4_S15=15,
			 CHECK_S16=16;

//modules
 ROM_lab_access DUT_ROM_1(address, clk, rom_data);
			

always@(posedge clk) 
			begin
			if(rst==0)
			begin
				  state<=s_INIT_S0;
				  okflag<=0;
				  red_LED<=1;
				  access_allowed<=0;
				  green_LED<=0;
				  psd<=4'b0000;
				  address <= 3'b111;
			end
else
begin
  				
case (state)
//starting authentication // wait for password input == 4
 s_INIT_S0: begin 
         okflag<=1;
         red_LED<=1;
         green_LED<=0;
         if (button_push==1) 
          begin
            psd<= toggle_switch ;
            state<= DELAY_1_S1;
				address <= address + 1;
           end                
           else
			state<=s_INIT_S0;

end

DELAY_1_S1: begin
				state <= DELAY_2_s2;
				end

DELAY_2_s2: begin
				state <= DIGIT_1_S3;
				end

DIGIT_1_S3: begin
				if(toggle_switch!= rom_data)
				begin	
				okflag<=0;	
				end
				state <= DIGIT_2_S4;	
				end
				

// wait for password input == 7
DIGIT_2_S4: begin 
				red_LED<=1;
				green_LED<=0;	
				if (button_push==1) 
					begin
						psd<= toggle_switch ;
						state<= DELAY_1_S5;
						address <= address + 1; 
					 end
						else 
					  state<=DIGIT_2_S4;   				  
				 end

DELAY_1_S5: begin
				state <= DELAY_2_s6;
				end

DELAY_2_s6: begin
				state <= DIGIT_2_S7;
				end
				
DIGIT_2_S7: begin
				if(toggle_switch!= rom_data) 
				begin	
					okflag<=0;
				end
				state <= DIGIT_3_S8;			
				end
				
				
		
				 
// wait for password input == 9
 DIGIT_3_S8: begin
				  red_LED<=1;
				  green_LED<=0;
				  if (button_push==1) 
					begin
						  psd<= toggle_switch ;
						  state<= DELAY_1_S9;
						  address <= address + 1;
					 end 
					else   
					state<=DIGIT_3_S8;
						  
				 end
				 
				 
DELAY_1_S9: begin
				state <= DELAY_2_s10;
				end

DELAY_2_s10: begin
				state <= DIGIT_3_S11;
				end
				
DIGIT_3_S11: begin
				if(toggle_switch!= rom_data) 
				begin	
					okflag<=0;
				end
				state <= DIGIT_4_S12;		
				end
				
				
// wait for password input == 1
DIGIT_4_S12: begin
				 red_LED<=1;
				 green_LED<=0;
				 if (button_push==1) 
				  begin
					 psd<= toggle_switch ;
					 state<= DELAY_1_S13;
					 address <= address + 1;
				  end
				 else   
				  state<=DIGIT_4_S12;
				end
				
DELAY_1_S13: begin
				state <= DELAY_2_S14;
				end

DELAY_2_S14: begin
				state <= DIGIT_4_S15;
				end
				
DIGIT_4_S15: begin
				if(toggle_switch!= rom_data) 
				begin	
					okflag<=0;
				end
				state <= CHECK_S16;			
				end
				
  
CHECK_S16: begin
      if(okflag==1 && logout_from_game_controller==0)  // access flag chanegs
        begin
         green_LED<=1;
         red_LED<=0;
			access_allowed=1; // access falg 
			 psd<= 4'b1110 ; /// 
        end
      else 
        begin
          green_LED<=0;
          red_LED<=1;
			 access_allowed=0;
          state<=s_INIT_S0;
        end
     end

          
default:
  begin
    state<=s_INIT_S0;
  end
 endcase

end
end
endmodule