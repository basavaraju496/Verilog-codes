module fsm_mealy_110(input reset,enable,clk,datain,output reg detected_out);

localparam IDLE=2'd0,GOT1=2'd1,GOT11=2'd2,GOT110=2'd3;   // naming states 

reg [1:0]state_p,state_next; // state handling registers

// ps logic

always@(posedge clk,negedge reset)
begin
		if(reset==0)
			begin
	  			state_p<=IDLE; detected_out=1'b0;
			end
		else
			begin
				state_p<=state_next;
			end

end
// ns logic 

always@(*)
begin
		if(enable==0)
				begin 
				state_next=state_p;
					case(state_p)
						IDLE: begin state_next=(datain==1'b1)?GOT1:IDLE; detected_out=1'b0; end
						GOT1: begin state_next=(datain==1'b1)?GOT11:IDLE; detected_out=1'b0; end
						GOT11: begin {state_next,detected_out}=(datain==1'b0)?({IDLE,1'b1}):({GOT11,1'b0});  end
					//	GOT110: begin state_next=(datain==1'b0)?IDLE:GOT1; detected_out=1'b1; end
						default: begin state_next=IDLE; detected_out=1'b0; end


					endcase
				end
		else
			 begin
				state_next=state_p;
			end
end
// op logic

//assign detected_out=1'b1;




endmodule 

