module dff(input clk_in,reset_in,enable_in,d_in,output reg q_out);

/*always@(posedge clk_in)
		begin//{
			if(reset_in==0)
					begin//{
							q_out=0;
					end//}
			else
					begin//{
							q_out=d_in;
				
			end//}

		end //}

*/

reg present_q,next_q;   // op handling registers

// ps logic

always@(posedge clk_in, negedge reset_in)
	begin//{
   			if(reset_in==0)
			begin
				present_q<=0;
			//	$display("reset block");
			end
			else 
			begin
				present_q<=next_q;
			end
	end//}
// ns logic 

always@(*)
		begin//{
			next_q=present_q;
			if(enable_in==0)
				begin
					next_q=d_in;
				end
			else
				begin
						next_q=present_q;	
				//		$display("present = %b ",present_q);
				end
		end//}

// op logic
always@(*)
		begin
			q_out=present_q;
		end



endmodule
