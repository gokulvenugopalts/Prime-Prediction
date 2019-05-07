// Course: ECE 6370
// Author:8626 
// Design and Simulation of TimerOneSecond
// Here the inputs are represented as clk, reset, timer1ms_enable, count_to_10_count and count_to_100_count
// Here the output are represented as timer1ms_timeout, count_to_10_timeout and count_to_100_timeout

module TimerOneSecond(clk, reset, timer1ms_enable, count_to_10_timeout);
	input clk, reset, timer1ms_enable;
	output count_to_10_timeout;
	wire count_to_100_timeout;

	Timer100ms DUT_Timer100ms(clk, reset, timer1ms_enable, count_to_100_timeout); 
	count_to_10 DUT_count_to_10(clk, reset, count_to_100_timeout, count_to_10_timeout);
endmodule 