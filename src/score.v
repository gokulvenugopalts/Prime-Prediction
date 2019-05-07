// Score Updater
// This module is used to update the score
// Here there are 4 inputs and 3 outputs.
module score(clk,reset,checker,game_timeout, Player_Won, Highest_Score, Personel_Best, tg1, tg2, ssd_score_10s,ssd_score_1s, Current_Score);
	input clk,reset,checker, game_timeout, tg1, tg2;
	input [2:0] Player_Won;
	input [6:0] Highest_Score, Personel_Best;
	output reg [3:0] ssd_score_10s, ssd_score_1s;
	output reg [6:0] Current_Score;
	reg [6:0] counter;
	assign red=~checker;
		always @(posedge clk)
	begin
		if (reset == 0)
		begin
			counter<=0;
			ssd_score_1s <= 0;
			ssd_score_10s <= 0;
		end
		else
		
		
		begin
			if(game_timeout==1)
				begin
					counter<=0;
					if (tg1 == 0 && tg2 == 1)
						begin
								ssd_score_1s <= Personel_Best%10;
								ssd_score_10s <= Personel_Best/10;
						end
					else if (tg1 == 1 && tg2 == 0)
						begin
								ssd_score_1s <= Highest_Score%10;
								ssd_score_10s <= Highest_Score/10;
						end
					else if (tg1 == 1 && tg2 == 1)
						begin
								ssd_score_1s <= Player_Won%10;
								ssd_score_10s <= Player_Won/10;
						end
				end
			else
				begin
					if (tg1 == 0 && tg2 == 0)
					begin
					Current_Score <= counter;
					ssd_score_1s <= counter%10;
					ssd_score_10s <= counter/10;
					if (red == 0)
						begin
							counter <= counter + 1;
						end
					else
						begin
							counter <= counter;
						end
					end	
				end
		end
	end

endmodule 