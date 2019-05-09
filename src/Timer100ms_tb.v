//4791
`timescale 1ns/1ns

module Timer100ms_tb();
reg clk,rst,enable;
wire time_out_100ms;

Timer100ms DUT_Timer100ms(clk,rst,enable,time_out_100ms);

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
enable<=1;
end
endmodule
