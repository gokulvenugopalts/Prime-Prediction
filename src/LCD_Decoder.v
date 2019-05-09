//4791
// LCD_decoder
// This is a decoder used to decoder 4 bit to 7 bit for the LCD
// LCD decoder

module LCD_Decoder(inSignal,outSignal);

input [3:0]inSignal;
output [6:0]outSignal;
reg [6:0]outSignal;

always @(inSignal)
	begin
		case(inSignal)
 			4'b0000: begin outSignal =7'b1000000;end
 			4'b0001: begin outSignal =7'b1111001;end
 			4'b0010: begin outSignal =7'b0100100;end
 			4'b0011: begin outSignal =7'b0110000;end
 			4'b0100: begin outSignal =7'b0011001;end
 			4'b0101: begin outSignal =7'b0010010;end
 			4'b0110: begin outSignal =7'b0000010;end
 			4'b0111: begin outSignal =7'b1111000;end
 			4'b1000: begin outSignal =7'b0000000;end
 			4'b1001: begin outSignal =7'b0011000;end
 			4'b1010: begin outSignal =7'b0001000;end
 			4'b1011: begin outSignal =7'b0000011;end
 			4'b1100: begin outSignal =7'b1000110;end
 			4'b1101: begin outSignal =7'b0100001;end
 			4'b1110: begin outSignal =7'b0000110;end
 			4'b1111: begin outSignal =7'b0001110;end
 			default: begin outSignal =7'b1111111;end
		endcase	
	end
endmodule
