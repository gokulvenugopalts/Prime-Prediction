//4791
//Signals
// input
// Timer_Setvalue -- setvalue of the timer
// Timer_Decrement_In -- decrements the counter 
// Timer_Out_7seg -- timer out to 7 seg decoder
// Donotborrow_In -- signal from other digit indicating that there should be no borrow request
// Donotborrow_Out -- signal from digit timer to other digit timer indicating that minimum value has reached

module Digit_Timer(Timer_Decrement_In, Timer_Setvalue, Timer_Out_7seg, clk, rst, Donotborrow_In, Donotborrow_Out, Reconfig_Button, Next_Timer_Decrement, timer_reset);
	
	input[3:0] Timer_Setvalue;
	input clk,rst, Timer_Decrement_In, Donotborrow_In, Reconfig_Button;
	output reg[3:0] Timer_Out_7seg ;
	output reg Donotborrow_Out, Next_Timer_Decrement;
	input timer_reset;
	
	always@(posedge clk)
	begin
		if(rst==0) // check if timer is reset
			begin
			Timer_Out_7seg<= 0;
			Donotborrow_Out<= 0;
			Next_Timer_Decrement<= 0;
			end
		else // no reset
		/////////////
			if(timer_reset == 1) // reset timer
				begin Timer_Out_7seg<=4'b0000; end 
		
			else // do not reset timer
				begin 
	///////////////////
	
			if(Reconfig_Button==1) // reconfiguration check of the timer
			begin
				if (Timer_Setvalue >= 4'b1001) // to set max timer to 99 
				begin Timer_Out_7seg<=4'b1001; end
				else	
			begin Timer_Out_7seg<=Timer_Setvalue; end
			
			if (Donotborrow_In==1 && Timer_Setvalue==0) // to avoid reset for less than 09 timer value 
				begin Donotborrow_Out<=1; end
			else 
				begin Donotborrow_Out<=0; end
				Next_Timer_Decrement<= 0;
			end
		else
			begin
				if(Timer_Decrement_In==1) // DECREMENT SIGNAL
					begin
						if(Timer_Out_7seg == 0) // check if digit is 0 already
							begin
								if(Donotborrow_In == 0) // check borrow signal of next digit before borrowing
									begin
									Timer_Out_7seg<=4'b1001;  // output is 9 (transition 0 to 9)
									//Next_Timer_Decrement<=0;
									Next_Timer_Decrement<=1;
									Donotborrow_Out<=0;
									end
								else
									begin  // do not borrow in = 1 then dont do anything
									Timer_Out_7seg<=4'b0000;
									Next_Timer_Decrement<=0;
									Donotborrow_Out<=1; /// 
									end
							end
						
						else
							begin // timer is not 0 so we can decrement the same timer
								Timer_Out_7seg<=Timer_Out_7seg-4'b001;
								if(Timer_Out_7seg == 4'b0001)  /// if digit is 1 signal not to borrow 
										begin
										if(Donotborrow_In == 0) 
										begin	Donotborrow_Out <= 0; end
										else 
										begin	Donotborrow_Out <= 1; end
											Next_Timer_Decrement<= 0;
											//Next_Timer_Decrement<=1;
										end
								else
										begin
											Next_Timer_Decrement<= 0;
											Donotborrow_Out <= 0;
										end
							end
					end  // decrement signal
				else
					begin  // Do Not Decrement if no decrement signal Timer_Decrement_In==0
						Next_Timer_Decrement<= 0;
						Timer_Out_7seg<= Timer_Out_7seg ;
					end
			 end
			end 
	end// always
endmodule
