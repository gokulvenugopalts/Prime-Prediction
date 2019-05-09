//4791
module Two_digit(Timer_Decrement_1sec, clk,rst, Reconfig_Button,Timer_Setvalue_Digit1, Timer_Setvalue_Digit2,Timer_Out_7seg_1, Timer_Out_7seg_2,Donotborrow_Out_digit1_access,Next_Timer_Decrement_outhanging,timer_reset);

input Timer_Decrement_1sec, clk,rst, Reconfig_Button;
input[3:0] Timer_Setvalue_Digit1, Timer_Setvalue_Digit2;

output Donotborrow_Out_digit1_access;
output Next_Timer_Decrement_outhanging;
output[3:0] Timer_Out_7seg_1, Timer_Out_7seg_2 ;

wire Donotborrow_Out_digit2, Timer_Decrement_2nd_digit;
input timer_reset;

Digit_Timer Digit1 (Timer_Decrement_1sec, Timer_Setvalue_Digit1, Timer_Out_7seg_1, clk, rst, Donotborrow_Out_digit2, Donotborrow_Out_digit1_access, Reconfig_Button, Timer_Decrement_2nd_digit,timer_reset);
Digit_Timer Digit2 (Timer_Decrement_2nd_digit, Timer_Setvalue_Digit2, Timer_Out_7seg_2, clk, rst, 1'b1, Donotborrow_Out_digit2 , Reconfig_Button, Next_Timer_Decrement_outhanging,timer_reset);

endmodule
