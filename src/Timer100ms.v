

module Timer100ms(clk, reset, enable, timeOut);
input clk, reset;
input enable; 
output timeOut;
//reg timeOut;
wire count;

Timer1ms Timer1ms_1(clk, reset, enable, count);
CountTo100 CountTo100_1(clk, reset, count, timeOut);

endmodule

