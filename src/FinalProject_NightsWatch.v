module FinalProject_NightsWatch(clk, reset, accessGranted, accessDenied, LessThanLED, GreaterThanLED, digit, data_inp, btn_pswdLoad);
	input clk, reset, btn_pswdLoad;
	input [3:0] data_inp;

	output[6:0] digit;
	output LessThanLED, GreaterThanLED, accessDenied, accessGranted;
	wire [1:0] gameLevel;
	
	wire[6:0] digit;
	wire gameWon, logoutPulse,w_btnPswd;
	reg decr;

	// TO-DO : remove the bottom definition
	assign logoutPulse = 1'b0;
	
	// Initialize the password check module to ensure that the user has
	// logged in.
	
	checkPassword inst_chkPswd (
		 .clk (clk)
		 , .rst (reset)
		 , .Load_Button_PSWD_Game_Control (w_btnPswd)
		 , .Logout_Pulse (logoutPulse)
		 , .Authenticated (accessGranted)
		 , .Logout_RED (accessDenied)
		 , .Data_in (data_inp)
	);
	
	// Instantiate the button shaper to generate a single pulse for push button to register
	// the password and other digit inputs
	buttonShaper instBtnShaper(
		.clk (clk)
		, .reset (reset)
		, .btnSense (btn_pswdLoad)
		, .dout (w_btnPswd)
	);
	
	// Initialize the count-down timer to start counting down the timer
	// from 99 to 0. The player is supposed to guess the prime number
//	// within this range.
//	countDownToZero inst_cntDwnTimer(
//		.clk (clk)
//		, .reset (reset)
//		, .reconfig
//		, .setDigit_tens
//		, .setDigit_units
//		, .decrement (decr)
//		, .reset_timer
//		, .do_not_borrow_currentDigit
//		, .digit_tens
//		, .digit_units
//	);
//	// Instantitate the LFSR based random prime number generator to start
//	// the game. The player now has to guess this prime number being
//	// generated.
//	gameController inst_GameControl (
//		.clk (clk)
//		, .reset (reset)
//		, .enable (enable)
//		, .gameLevel (gameLevel)
//		, .userWon (gameWon)
//		, .signalLess (LessThanLED)
//		, .signalGreater (GreaterThanLED)
//	);
endmodule

