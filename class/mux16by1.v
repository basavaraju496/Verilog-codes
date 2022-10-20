module mux16by1(input  [15:0]y0,y1,y2,y3,y4,input  [7:0]y5,y6,y7,y8,y9,y10,y11,y12,y13,y14,y15,input [3:0]sel,output reg [15:0]mux2_out,input el);
always@(*)
begin

if(el==0)
begin

		case(sel)
		4'b0000: begin mux2_out=y0; end 
		4'b0001: begin mux2_out=y1; end 
		4'b0010: begin mux2_out=y2; end 
		4'b0011: begin mux2_out=y3; end 
		4'b0100: begin mux2_out=y4; end 
		4'b0101: begin mux2_out=y5; end 
		4'b0110: begin mux2_out=y6; end 
		4'b0111: begin mux2_out=y7; end 
		4'b1000: begin mux2_out=y8; end 
		4'b1001: begin mux2_out=y9; end 
		4'b1010: begin mux2_out=y10; end 
		4'b1011: begin mux2_out=y11; end 
		4'b1100: begin mux2_out=y12; end 
		4'b1101: begin mux2_out=y13;  end 
		4'b1110: begin mux2_out=y14; end 
		4'b1111: begin mux2_out=y15; end 
		default :begin mux2_out=16'bz; end



		endcase
end
		else 
			begin
			mux2_out=16'bz; 
			end
end
endmodule
