
module countDownToZero(clk, reset, reconfig, setDigit_tens, setDigit_units, decrement, reset_timer, do_not_borrow_currentDigit, digit_tens, digit_units);//, makeit0, makeit1);
input clk, reset;
input reconfig;
input decrement;
input [3:0] setDigit_units;
input [3:0] setDigit_tens;
input reset_timer;
//input makeit0, makeit1;
output do_not_borrow_currentDigit;
output [3:0] digit_units;
output [3:0] digit_tens;
wire borrow;
wire do_not_borrow;
//parameter makeit0 = 0, makeit1 = 1;
wire makeit1 ;
assign makeit1 = 1'b1;
wire makeit0;
timer TimerTens(clk, reset, reconfig, setDigit_tens, borrow, makeit1,reset_timer, do_not_borrow, makeit0, digit_tens);
timer TimerUnits(clk, reset, reconfig, setDigit_units, decrement, do_not_borrow, reset_timer, do_not_borrow_currentDigit, borrow, digit_units);

endmodule



