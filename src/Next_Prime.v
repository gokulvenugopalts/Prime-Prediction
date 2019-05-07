// Author:JOY REBELLO 4719
//Final Project
// Next_Random
// finds next prime number after the input 7 digit number.

module Next_Prime(clk,rst,Q_in,Q_out,FindPrime);
  input clk,rst,FindPrime;
  input [6:0] Q_in;
  reg [6:0] Q_in_temp,count;
  output reg [6:0] Q_out;


 always @(posedge clk)
 begin
  if (rst==0)
  begin
  count<=0;
  Q_in_temp<=0;
  Q_out<=0;
  end
  
  else
	begin
	if (FindPrime == 1) 	// NEW NUMBER 
	begin
		Q_in_temp<=Q_in;
		count <=2; // set counter to 2
	end
	
	else // NOT A NEW NUMBER
	begin
		// if number less than 2 then output is 2	// corner case
		if(Q_in_temp<=2)
		begin
		Q_out<=2;  
		end
		
		else if (count < Q_in_temp)
			begin
		// is not prime 
				if (Q_in_temp%count==0)
				begin
				Q_in_temp<=Q_in_temp+1;
				count =2; //set counter to 2 and start checking again
				end	
		/// not prime then increase count till count < Q_temp
			else	
				begin
					if(count == Q_in_temp-1) // if counter reached maximum value and number is still not divisible
						begin Q_out <=Q_in_temp; end
					else
						begin count <= count+1; end // increase counter
				end	
		end	

	 end 
	 
   end // reset 
end
endmodule

