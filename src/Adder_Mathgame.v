// ECE6370
// Lab2
// Author:JOY REBELLO  4719
// Adder_Mathgame
// Adder for Math Game calculation, numbers from both players are added using this module to display result

module random_mathgame(rand,a,equal,adder_green_LED,adder_red_LED);
	input [6:0]a;
	input [6:0]rand;
	output reg equal ;
	output adder_red_LED, adder_green_LED;
	reg adder_red_LED, adder_green_LED;

	always @ (a,rand)
		begin

		if (a>rand) // sum is 15 -- winning condition
			begin
				adder_green_LED = 1; 
				adder_red_LED = 0;
				equal =0;
			end
			
		
		else
			begin  // not winning condition LED RED indication
				adder_green_LED = 0;
				adder_red_LED = 1;
				if (a == rand)
				begin equal = 1;end
				else 
				begin equal =0; end
			end

	end   

endmodule