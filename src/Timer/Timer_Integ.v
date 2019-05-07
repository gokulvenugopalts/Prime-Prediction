// Course: ECE 6370
// Author:8626 
// Design a Timer Integration
// This module used to integrate the digit timer
// Here there are 9 inputs and 2 outputs.
module Timer_Integ(clk,reset,one_sec_in,DNB_in_10s,game_timeout, reconfig,ten_d_out,one_d_out);
input clk, reset, reconfig, one_sec_in, DNB_in_10s;
output[3:0] ten_d_out,one_d_out;
output game_timeout;
wire DNB_out_10s,tens_timer_in,h_timer_in;
one_digit_timer ones_digit(clk, reset, one_sec_in, DNB_out_10s, reconfig, game_timeout, tens_timer_in, one_d_out);
Two_digit_timer tens_digit(clk, reset, tens_timer_in, DNB_in_10s, reconfig, DNB_out_10s, h_timer_in, ten_d_out);
endmodule



