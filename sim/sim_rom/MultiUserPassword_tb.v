`timescale 1ns/1ns;
module MultiUserPassword_tb;
	reg clock, reset, btn;
	reg [3:0] usrInp;
	wire greenLED, redLED;
	
	MultiUserPassword inst_MultiUserPswd (
		 .clk (clock)
		 , .reset (reset)
		 , .accessGranted (greenLED)
		 , .accessDenied (redLED)
		 , .userInp (usrInp)
		 , .userBtn (btn)
	);

	initial begin
		clock <= 1'b0;
		reset <= 1'b1;
		#1; usrInp = 5;
		#2; btn = 1'b1;
		#1; btn = 1'b0;
		#50; $finish;
	end

	always begin
		#1; clock = ~clock;
	end
endmodule
