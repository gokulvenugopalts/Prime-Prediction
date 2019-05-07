//8626 
module Timer100ms(clk, reset, timer1ms_enable, count_to_100_timeout);
	input clk, reset, timer1ms_enable;
	output count_to_100_timeout;
	wire timer1ms_timeout;

	timer1ms DUT_timer1ms(clk, reset, timer1ms_enable, timer1ms_timeout);
	count_to_100 DUT_count_to_100(clk, reset, timer1ms_timeout, count_to_100_timeout);
endmodule 


