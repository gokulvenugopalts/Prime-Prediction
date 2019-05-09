//4791

module Lab4_REBELLO_J(button_press_password,rng_b,load2_p2,clk,rst,P2_In,toggle_switch_ones,toggle_switch_tens,toggle_switch,green_LED,red_LED,adder_green_LED,adder_red_LED,sevenseg1,sevenseg2,sevenseg3,sevenseg4,sevenseg5,sevenseg6,sevenseg7,sevenseg8);

input button_press_password,rng_b,load2_p2,clk,rst;
input [3:0] P2_In,toggle_switch_ones,toggle_switch_tens,toggle_switch;

output green_LED,red_LED,adder_green_LED,adder_red_LED;
output [6:0] sevenseg1,sevenseg2,sevenseg3,sevenseg4,sevenseg5,sevenseg6,sevenseg7,sevenseg8;

wire [3:0] rand_num_out_signal,P2_Out,sum,pd,timer_4bitOut_ones,timer_4bitOut_tens,scor_Out1,scor_Out2;
wire ENABLE,recon_bit,time_Out,Donot_BIn_ones,tm_out_one_second,verifyier_Out,button_Out_password,ld2_Out,load2_Out_p2,rand_num_input_signal;

wire two_digit_reset, score_reset;


//button shaper
Button_Shaper BUT1( button_press_password, clk,rst, button_Out_password);
Button_Shaper BUT2( load2_p2, clk,rst, load2_Out_p2);

//random number generator
Random_Num_Gen RANDOM1(rand_num_input_signal,rst,clk,rand_num_out_signal);

//access controller
access_controller AC1(button_Out_password,ENABLE,recon_bit,toggle_switch,rst,clk,pd,green_LED,red_LED,rng_b,load2_Out_p2,rand_num_input_signal,ld2_Out,Donot_BIn_ones,two_digit_reset,score_reset);
// initial red led

//adder
Adder_Mathgame ADD1(rand_num_out_signal,P2_Out,sum,adder_green_LED,adder_red_LED);

//load register
Load_Reg LOAD_P2(P2_In,P2_Out,clk,rst,ld2_Out);

//Scoreboard
Score_Board S1(clk,rst,verifyier_Out,scor_Out1,scor_Out2,score_reset);

//score 15 checker
Verify_15 V1(clk,rst,rand_num_input_signal,ld2_Out,sum,verifyier_Out);

//One second timer
TimerOneSecond T1(clk,rst,ENABLE,tm_out_one_second,1'b0);

//Two Digit timer
Two_digit TD1(tm_out_one_second, clk,rst, recon_bit,toggle_switch_ones, toggle_switch_tens,timer_4bitOut_ones, timer_4bitOut_tens,Donot_BIn_ones,Next_Timer_Decrement_outhanging,two_digit_reset);

//seven segment display
LCD_Decoder D1(rand_num_out_signal,sevenseg1);
LCD_Decoder D2(P2_Out,sevenseg2);
LCD_Decoder D3(sum,sevenseg3);
LCD_Decoder D4(pd,sevenseg4);
LCD_Decoder D5(scor_Out1,sevenseg5);
LCD_Decoder D6(scor_Out2,sevenseg6);
LCD_Decoder D7(timer_4bitOut_ones,sevenseg7);
LCD_Decoder D8(timer_4bitOut_tens,sevenseg8);

endmodule

