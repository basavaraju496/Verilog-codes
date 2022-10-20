module fsm_moore_11010(input clk_in,reset_in,data_in,output detected_out);
localparam idle_state=3'd1,got1_state=3'd2,g11_state=3'd3,got11_state=3'd3,got110_state=3'd4,got1101_state=3'd5,got11010_state=3'd6;
//ps logic creation of FF
reg[2:0]state_p,state_next;
always@(posedge clk_in negedge reset)
begin
		if(reset==1'b0)
		begin
			state_p<=idle_state;
		end
		else
			begin
				state_p=state_next;
		 	end
end
always@(*)
begin





end
endmodule
