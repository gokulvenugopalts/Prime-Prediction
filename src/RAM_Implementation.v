// RAM Implementation Module
// This module is used to store the high score of the players in the RAM Memory.
// Here there are 5 inputs and 2 outputs.

module RAM_Imp (Player_Won, Highest_Score, Personel_Best, Clk, Reset, enable, Player_ID, Current_Score);
input Clk, Reset, enable;
input [2:0] Player_ID; // This input is used to identify the player
input [6:0] Current_Score;
output reg [2:0] Player_Won;
output reg [6:0] Highest_Score, Personel_Best;
reg [3:0] State;
reg [6:0] RAM [6:0]; // This will crreate a set of 7x7 registers. This is similar to 7x7 Matix.
parameter Initial = 4'b0000, Personel_High_Score = 4'b0001, Overall_High_Score = 4'b0010;

always@ (posedge Clk)
begin
	if(Reset == 0)
		begin
			State <= Initial;
			RAM[0] <= 7'b0000000; // Stores the individual High Score of Player 1 
			RAM[1] <= 7'b0000000; // Stores the individual High Score of Player 2 
			RAM[2] <= 7'b0000000; // Stores the individual High Score of Player 3 
			RAM[3] <= 7'b0000000; // Stores the individual High Score of Player 4 
			RAM[4] <= 7'b0000000; // Stores the individual High Score of Player 5 
			RAM[5] <= 7'b0000000; // Stores the Highest Score among all the Players
			RAM[6] <= 7'b0000000; // Stores the Player with the Highest Score
			Player_Won <= 7'b0000000;
			Highest_Score <= 7'b0000000;
			Personel_Best <= 7'b0000000;
		end
	else
		begin
			case(State)
				Initial: begin
						if(enable == 1)
							begin
								State <= Personel_High_Score;
							end
						else
							begin
								State <= Initial;
							end
				end
				
				Personel_High_Score: begin
					if(Player_ID == 3'b000)
						begin 
								if(RAM[0] < Current_Score)
									begin
										RAM[0] <= Current_Score;
										Personel_Best <= RAM[0];
										if(RAM[5] < Current_Score)
											begin
												RAM[5] <= Current_Score;
												RAM[6] <= Player_ID;
												Player_Won <= RAM[6];
												Highest_Score <= RAM[5];
											end
																				
									end
										State <= Overall_High_Score;	
						end	
						
					else if(Player_ID == 3'b001)
						begin 
								if(RAM[1] < Current_Score)
									begin
										RAM[1] <= Current_Score;
										Personel_Best <= RAM[1];
										if(RAM[5] < Current_Score)
											begin
												RAM[5] <= Current_Score;
												RAM[6] <= Player_ID;
												Player_Won <= RAM[6];
												Highest_Score <= RAM[5];
											end
											
									end
										State <= Overall_High_Score;
						end
					else if(Player_ID == 3'b010)
						begin 
								if(RAM[2] < Current_Score)
									begin
										RAM[2] <= Current_Score;
										Personel_Best <= RAM[2];
										if(RAM[5] < Current_Score)
											begin
												RAM[5] <= Current_Score;
												RAM[6] <= Player_ID;
												Player_Won <= RAM[6];
												Highest_Score <= RAM[5];
											end
											
									end
										State <= Overall_High_Score;
						end
					else if(Player_ID == 3'b011)
						begin 
								if(RAM[3] < Current_Score)
									begin
										RAM[3] <= Current_Score;
										Personel_Best <= RAM[3];
										if(RAM[5] < Current_Score)
											begin
												RAM[5] <= Current_Score;
												RAM[6] <= Player_ID;
												Player_Won <= RAM[6];
												Highest_Score <= RAM[5];
											end
											
									end
										State <= Overall_High_Score;
						end
					else if(Player_ID == 3'b001)
						begin 
								if(RAM[4] < Current_Score)
									begin
										RAM[4] <= Current_Score;
										Personel_Best <= RAM[4];
										if(RAM[5] < Current_Score)
											begin
												RAM[5] <= Current_Score;
												RAM[6] <= Player_ID;
												Player_Won <= RAM[6];
												Highest_Score <= RAM[5];
											end
											
									end
										State <= Overall_High_Score;
						end
						
				end
				
				Overall_High_Score: begin
							Player_Won <= RAM[6];
							Highest_Score <= RAM[5];
							State <= Initial;
				end
				
				
				default: begin
				
					State <= Initial;
					RAM[0] <= 7'b0000000; // Stores the individual High Score of Player 1 
					RAM[1] <= 7'b0000000; // Stores the individual High Score of Player 2 
					RAM[2] <= 7'b0000000; // Stores the individual High Score of Player 3 
					RAM[3] <= 7'b0000000; // Stores the individual High Score of Player 4 
					RAM[4] <= 7'b0000000; // Stores the individual High Score of Player 5 
					RAM[5] <= 7'b0000000; // Stores the Highest Score among all the Players
					RAM[6] <= 7'b0000000; // Stores the Player with the Highest Score
					Player_Won <= 7'b0000000;
					Highest_Score <= 7'b0000000;
					Personel_Best <= 7'b0000000;
				
				end
				
			endcase
		end
end
endmodule