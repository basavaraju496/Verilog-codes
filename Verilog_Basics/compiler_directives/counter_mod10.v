module counter_mod10(input clk,reset,enable,output reg [3:0]counter_out);


always@(posedge clk)
		begin//{
			if(reset==0 || counter_out==10)
					begin
						counter_out<=0;
					end
			else if(enable==0)
				begin
					counter_out<=counter_out+1;
					
				end
			else
				begin
					counter_out<=counter_out;
				end

		end//}


endmodule
