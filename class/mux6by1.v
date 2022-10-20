module mux6by1  (input [7:0]A,B,C,D,E,F ,input [2:0]sel,input el,output reg [7:0]Y);

always@(*)
begin
		if(el==0) 
		begin

			case(sel)
				3'b101: Y=A;
				3'b110: Y=B;
				3'b111: Y=C;
				3'b000: Y=D;
				3'b001: Y=E;
				3'b010: begin Y=F;

// $display("xor in mux is %b %b",F,Y);

 end
				default : Y=8'Bz;
			endcase
	
		end
		else
			Y=8'bz;
		end

endmodule
