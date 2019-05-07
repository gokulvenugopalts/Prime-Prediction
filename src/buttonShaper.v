//Course: ECE6370
//Author: Adithya Sekar
//Title: Button Shaper
//Description:  This module will sense if the push button from
//		the FPGA is pressed by asserting the output. The 
//		push button signal is a mechanical switch which 
//		gets sensed at the positive edge of the clock. 
//		Whenever the reset signal is asserted, the output 
//		signal gets de-asserted.
// -------------------------Change Log --------------------
// v0.1 - 02/13/2019 - Added the initial logic
//
module buttonShaper(clk, reset, btnSense, dout);
	// btnSense - 1-bit input from the FPGA. Gets de-asserted when the switch is pressed.
	// clk - Clock from the FPGA; reset - 1-bit reset signal from FPGA.
	// dout - 1-bit output that generates a high-output pulse whenever switch is pressed.
	input btnSense, clk, reset;
	output dout;
	reg dout;
	reg[1:0] state, stateNext;

	parameter s_INIT = 2'b00;
	parameter s_PULSE = 2'b01;
	parameter s_WAIT = 2'b10;

	// Combinational logic
	always @ (state, btnSense)
        //always@(*)
	begin
		case (state)
			s_INIT: begin
						// Set the default value for the output
						dout = 1'b0;
						if (btnSense == 1'b0) 
						begin
							stateNext = s_PULSE;
						end
						else if (btnSense == 1'b1)
						begin
							stateNext = s_INIT;
						end
				end
			s_PULSE: begin
					dout = 1'b1;
					if (btnSense == 1'b0)
					begin
						stateNext = s_WAIT;
					end
				end
			s_WAIT: begin
					dout = 1'b0;
					if (btnSense == 1'b1)
					begin
						stateNext = s_INIT;
					end
					else if (btnSense == 1'b0)
					begin
						stateNext = s_WAIT;
					end
				end
			default: begin
					stateNext <= s_INIT;
				end
		endcase
	end
	// Sense the input during the positive edge of the clock cycle.
	always @(posedge clk)
	begin
		if (reset == 1'b0)
		begin
			state <= s_INIT;
		end
		else
		begin
			state <= stateNext;
		end
	end
endmodule