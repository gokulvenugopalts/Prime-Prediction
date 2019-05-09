//4791
`timescale 1ns/1ns

module CountTo100_tb();
reg clk,rst,count_pulse;
wire time_out;

CountTo100 DUT_CountTo100(clk,rst,count_pulse,time_out);

always 

  begin // generate a clock with cycle 20ns -- 50 Mhz
    clk<=1;    #10
    clk<=0;    #10 ;
  end


initial

begin
@(posedge clk)
rst<=0;
@(posedge clk)
rst<=1;
count_pulse<=1;
end
endmodule
