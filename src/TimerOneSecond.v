
module TimerOneSecond(clk, reset, enable, timeOut);
input clk, reset;
input enable; 
output timeOut;
//reg timeOut;
wire count1;

Timer100ms Timer100ms_2(clk, reset, enable, count1);
CountTo10 CountTo10_2(clk, reset, count1, timeOut);


endmodule


