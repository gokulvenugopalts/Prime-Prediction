//4791


module Button_Shaper ( BUTTON_INPUT, CLK, RESET, SHAPER_OUTPUT);

	input BUTTON_INPUT, CLK, RESET;
	output SHAPER_OUTPUT;
	reg SHAPER_OUTPUT;

// State Initialization
	parameter START= 2'b00, H_PULSE = 2'b01, WAIT = 2'b10;
	reg [1:0] Current_State, Next_State;

//Combinational Logic
always@ (Current_State, BUTTON_INPUT)
  begin
		case (Current_State)
			
			START :				// START state
			  begin
				SHAPER_OUTPUT = 1'b0;		// In start state the output needs to be low
				if (BUTTON_INPUT == 0)		// If Button is pressed move to next state  
				  begin
					Next_State = H_PULSE;
				  end
				else
				  begin
					Next_State = START;		// Else stay in the same state
				  end 
			  end
			  
			H_PULSE : 				// H_PULSE state
			  begin
				SHAPER_OUTPUT = 1'b1;		// Output is set high
				Next_State = WAIT;
			  end
			  
			WAIT : 				// WAIT state
			  begin
				SHAPER_OUTPUT = 1'b0;		// In wait state make the output go low
				if (BUTTON_INPUT == 1)		// Check for BUTTON_INPUT if released move to start state
				  begin
					Next_State = START;
				  end
				else
				  begin
					Next_State = WAIT;		// Else be in wait state with output low;
				  end 
			  end
			  
			default :				// default state (In case we moved to a unknown state)
			  begin
				SHAPER_OUTPUT = 1'b0;
				Next_State = START;
			  end
			  
		endcase
  end

//State Registers
always @ (posedge CLK)			// Always check on positive edge of the clock pulse
  begin
    if (RESET == 0)			// Active low synchronous reset
      begin
        Current_State <= START;
      end 
    else			
      begin
        Current_State <= Next_State;
      end
  end

endmodule

