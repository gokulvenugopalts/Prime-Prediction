`timescale 1ns/1ns;
module checkPassword_tb;
	reg clock, reset, btn, logoutPulse;
	reg [3:0] usrInp;
	wire greenLED, redLED, anotherGreenLED;
	
	checkPassword inst_chkPswd (
		 .clk (clock)
		 , .rst (reset)
		 , .Load_Button_PSWD_Game_Control (btn)
		 , .Logout_Pulse (logoutPulse)
		 , .Authenticated (greenLED)
		 , .Logout_RED (redLED)
		 , .Login_Green (anotherGreenLED)
		 , .Data_in (usrInp)
	);

	initial begin
		clock <= 1'b0;
		reset <= 1'b1; btn = 1'b0;
		#2; usrInp = 4; logoutPulse = 0;
		#2; btn = 1'b1;
		#2; btn = 1'b0;
		#50;
		#2; usrInp = 6;
 		#2; btn = 1'b1;
		#2; btn = 1'b0;	
		#50;
		#2; usrInp = 9; 
		#2; btn = 1'b1;
		#2; btn = 1'b0;
		#50;
		#2; usrInp = 6;
		#2; btn = 1'b1;
		#2; btn = 1'b0;
		#100;
		#2; usrInp = 4;
		#2; btn = 1'b1;
		#2; btn = 1'b0;
		#100;
		#2; usrInp = 5;
		#2; btn = 1'b1;
		#2; btn = 1'b0;
		#100;
		#2; usrInp = 6;
		#2; btn = 1'b1;
		#2; btn = 1'b0;	
		#100;
		#2; usrInp = 7;
		#2; btn = 1'b1;
		#2; btn = 1'b0;
		#500;$finish;
	end

	always begin
		#1; clock = ~clock;
	end
endmodule	
