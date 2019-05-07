// course: ece 6370
// author: 8626 
// design and simulation of access controller
// this module is used to test the access control module
// here the inputs are represented as reset, clk, load1, load2, push and pin
// here the output is represented as load_p1, load_p2, r_led, g_led and pin_reg
`timescale 1ns/10ps

module tb_RAM_Imp();
	reg clk, reset, enable;
	reg [2:0] Player_ID; // This input is used to identify the player
	reg [6:0] Current_Score;
	wire [2:0] Player_Won;
	wire [6:0] Highest_Score, Personel_Best;

	RAM_Imp DUT_RAM_Imp(Clk, Reset, enable, Player_ID, Current_Score, Player_Won, Highest_Score, Personel_Best);

	always begin
	     #10 clk <= 1;
	     #10 clk <= 0;
	end
// The pin is 8626
	initial begin
            reset <= 1;
			@(posedge clk);
            reset <= 0;
			@(posedge clk);
            reset <= 1;
			enable <= 1;
			@(posedge clk);
			Player_ID <= 3'b001;
			Current_Score <= 7'b0000011;
			enable <= 0;
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);					
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);			
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);			
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);			
			enable <= 1;
			@(posedge clk);
			Player_ID <= 3'b010;			
			Current_Score <= 7'b0011111;
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);			
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);			
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);			
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);			
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);		
			@(posedge clk);
			enable <= 0;			
			@(posedge clk);
			@(posedge clk);
			enable <= 1;
			@(posedge clk);			
			Player_ID <= 3'b001;
			@(posedge clk);
			Current_Score <= 7'b0000111;
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);			
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);			
         end
endmodule






