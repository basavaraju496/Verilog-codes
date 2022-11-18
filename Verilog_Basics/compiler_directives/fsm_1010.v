module fsm_moore_1010(input reset_in,enable_in,clk_in,sequence_in,output detected_out);

localparam IDLE=5'b00001,			
	   GOT1=5'b00010,
	   GOT10=5'b00100,
	   GOT101=5'b01000,
	   GOT1010=5'b10000;   // naming states 

reg [4:0]present_state,next_state; // state handling registers
reg dout_next,dout_present; // output handling DFF


// ps logic

always@(posedge clk_in,negedge reset_in)
begin
		if(reset_in==0)
			begin
				dout_present<=1'b0;
	  			present_state<=IDLE; 		end
		else
			begin
				present_state<=next_state;
				dout_present<=dout_next;				
			end

end
// ns logic comb logic

always@(*)
begin
		if(enable_in==0)
				begin
				next_state=present_state;
					case(present_state)
						IDLE: begin next_state=(sequence_in==1'b1)?GOT1:IDLE;  end
						GOT1: begin next_state=(sequence_in==1'b0)?GOT10:IDLE; end
						GOT10: begin next_state=(sequence_in==1'b1)?GOT101:IDLE; end
						GOT101: begin next_state=(sequence_in==1'b0)?GOT1010:IDLE;  end
						GOT1010: begin next_state=(sequence_in==1'b0)?IDLE:GOT1;  end

						default: begin next_state=IDLE;  end


					endcase
				end
		else
			 begin
				next_state=present_state;
			end
end
// op logic
always@(present_state)
begin
	case(present_state)
			IDLE : dout_next=1'b0;
			GOT1 : dout_next=1'b0;
			GOT10 : dout_next=1'b0;
			GOT101 : dout_next=1'b0;
			GOT1010 : dout_next=1'b1;
	endcase
end


assign detected_out=dout_present;


endmodule 

