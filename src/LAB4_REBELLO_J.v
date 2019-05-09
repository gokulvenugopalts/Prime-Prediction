//4791

module LAB4_REBELLO_J(button_press_password,rng_b,load2_p2,clk,rst,P2_In,toggle_switches_4bit_ones,toggle_switches_4bit_tens,tg1, tg2, toggle_password_4bit,green_LED,red_LED,adder_green_LED,adder_red_LED,sevenseg1,sevenseg2,sevenseg3,sevenseg4,sevenseg5,sevenseg6,sevenseg7,sevenseg8);

input button_press_password,rng_b,load2_p2,clk,rst, tg1, tg2;
input [3:0]toggle_switches_4bit_ones,toggle_switches_4bit_tens,toggle_password_4bit;


output green_LED,red_LED,adder_green_LED,adder_red_LED;
output [6:0] sevenseg1,sevenseg2,sevenseg3,sevenseg4,sevenseg5,sevenseg6,sevenseg7,sevenseg8;

wire [3:0] pd,timer_4bitOut_ones,timer_4bitOut_tens,scor_Out1,scor_Out2;
wire ENABLE,recon_bit,Donot_BIn_ones,tm_out_one_second,verifyier_Out,button_Out_password,ld2_Out,load2_Out_p2,rand_num_input_signal;

//////
wire [2:0] Player_Won;
wire [6:0] Highest_Score, Personel_Best, Current_Score;
wire [6:0] P2_Out;
wire [2:0] userUniqueID;
input [6:0] P2_In;
wire two_digit_reset, score_reset,access_allowed;
wire equal;

wire [6:0] rand_num_out_signal;
//button shaper
Button_Shaper BUT1( button_press_password, clk,rst, button_Out_password);
Button_Shaper BUT2( load2_p2, clk,rst, load2_Out_p2);

//random number generator
//Random_Num_Gen RANDOM1(rand_num_input_signal,rst,clk,rand_num_out_signal);

LFSR_Prime LP1(clk,rst,rand_num_input_signal,rand_num_out_signal, 7'b0000000);

//access controller
//access_controller_ROM AC1(button_Out_password,toggle_password_4bit,rst,clk,pd,green_LED,red_LED,access_allowed,logout_from_game_controller);
checkPassword AC1(clk,rst,button_Out_password,logout_from_game_controller,toggle_password_4bit,green_LED,red_LED, access_allowed, userUniqueID);
assign pd = toggle_password_4bit;
// initial red led

// game controller

//Game_controller GC1(button_Out_password,ENABLE,recon_bit,rst,clk,rng_b,load2_Out_p2,rand_num_input_signal,ld2_Out,Donot_BIn_ones,two_digit_reset,score_reset,access_allowed,logout_from_game_controller);

Game_controller GC1(button_Out_password,ENABLE,recon_bit,rst,clk,rng_b,load2_Out_p2,rand_num_input_signal,ld2_Out,Donot_BIn_ones,two_digit_reset,score_reset,access_allowed,logout_from_game_controller);
//adder
//Adder_Mathgame ADD1(rand_num_out_signal,P2_Out,sum,adder_green_LED,adder_red_LED);
random_mathgame RAND1(rand_num_out_signal,P2_Out,equal,adder_green_LED,adder_red_LED);

//load register
Load_Reg LOAD_P2(P2_In,P2_Out,clk,rst,ld2_Out);

//Scoreboard
Score_Board S1(clk,rst,verifyier_Out,scor_Out1,scor_Out2,score_reset);

//score 15 checker
Verify_15 V1(clk,rst,rand_num_input_signal,ld2_Out,equal,verifyier_Out);

//One second timer
TimerOneSecond T1(clk,rst,ENABLE,tm_out_one_second,1'b0);

//Two Digit timer
Two_digit TD1(tm_out_one_second, clk,rst, recon_bit,4'b0000, toggle_switches_4bit_tens,timer_4bitOut_ones, timer_4bitOut_tens,Donot_BIn_ones,Next_Timer_Decrement_outhanging,two_digit_reset);

LCD_Decoder D1(P2_Out,sevenseg1);
//LCD_Decoder D2(P2_Out[7:4],sevenseg2);
//LCD_Decoder D3(sum,sevenseg3);
LCD_Decoder D4(pd,sevenseg4);
LCD_Decoder D5(scor_Out2,sevenseg5);
LCD_Decoder D6(scor_Out1,sevenseg6);
LCD_Decoder D7(timer_4bitOut_ones,sevenseg7);
LCD_Decoder D8(timer_4bitOut_tens,sevenseg8);


RAM_Imp R_I(clk, rst, logout_from_game_controller, userUniqueID, Current_Score, Player_Won, Highest_Score, Personel_Best);
//score scr(clk,rst,verifier_Out,logout_from_game_controllert, Player_Won, Highest_Score, Personel_Best, tg1, tg2, scor_Out1,scor_Out2, Current_Score);



endmodule

