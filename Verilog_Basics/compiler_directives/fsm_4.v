module fsm_4(input reset_in,enable_in,clk_in,start_in,stop_in);

localparam IDLE=3'b001,	// states		
	   OPEN=3'b010,
	   CLOSE=3'b100;

reg [2:0]present_state,next_state; // state handling registers
reg [9:0]next_count,present_count; // count handling DFF


// ps logic

always@(posedge clk_in,negedge clk_in,negedge reset_in)
begin
		if(reset_in==0)
			begin
			//	dout_present<=1'b0;
	  			present_state<=IDLE;
				present_count<=10'b0;
	 		end
		else
			begin
				present_state<=next_state;
				present_count<=next_count;

			//	dout_present<=dout_next;				
			end

end
// ns logic comb logic

always@(*)
begin
		if(enable_in==0)
				begin
				next_state=present_state; next_count=present_count;
					case(present_state)
						IDLE: begin next_state=(start_in==1'b0)?OPEN:IDLE;  $display("i am in idle state");     end
						OPEN: begin
								$display("i am in open state ");
								if(present_count==9)
								begin
									next_state=CLOSE; next_count=10'b0;
								end
								else
									begin
										next_count=present_count+1'b1;	next_state=OPEN; $display("count value is %d",present_count);											
									end
							 end
						CLOSE: begin
								$display("i am in close state ");
								if(stop_in==0)
								begin
									next_state=IDLE;
								end
								else if(present_count==9)
								begin
									next_state=OPEN; next_count=10'b0;
								end
								else
									begin
										next_count=present_count+1'b1;	next_state=CLOSE;											
									end
							 end

						default: begin next_state=IDLE;  end


					endcase
				end
		else
			 begin
				next_state=present_state;
			end
end
// op logic
/*always@(present_state)
begin
	case(present_state)
			IDLE : dout_next=1'b0;
			GOT1 : dout_next=1'b0;
			GOT10 : dout_next=1'b0;
			GOT101 : dout_next=1'b0;
			GOT1010 : dout_next=1'b1;
	endcase
end
*/

//assign detected_out=dout_present;


endmodule 

