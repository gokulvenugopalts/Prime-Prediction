module MultiUserPassword (clk, reset, accessGranted, accessDenied, userInp, userBtn);
	input clk, reset, userBtn;
	input [3:0] userInp;
	output accessGranted, accessDenied;

	// register to store the value of the people soft id from the user.
	reg [15:0] usrInputPSID;
	reg accessGranted, accessDenied;
	wire [15:0] PSID;
	reg [2:0] address, cntr;
	
	// instantiate the 1-port ROM to read the user ID that the user
	// inputs.
	multiID instMultipleID (
				.address (address)
				, .clock (clk)
				, .q (PSID)
			);

	// Logic to get the value of the input provided by the user
	always @ (posedge clk)
	begin
 		if (reset == 1'b0) 
		begin
			accessDenied <= 1'b0;
			accessGranted <= 1'b0;
			cntr <= 0;
		end
		else
		begin
			if (userBtn == 1'b1)
			begin
				address <= 0;	
				cntr <= 0;
			end
			cntr <= cntr + 1;
			if (cntr == 2) 
			begin
				if (userInp == PSID)
					accessGranted <= 1'b1;
				else
					accessDenied <= 1'b1;
			end
		end
	end
endmodule
