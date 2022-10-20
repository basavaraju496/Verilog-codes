module  nbitdemux(input [15:0]i,input [1:0]sel,input el,output reg [15:0]y1,y2,y3,y4);
always@(*)
begin 
	if(el==0)
	begin
//$display("sel=%b",sel);
	//	$display("data in demux =%b %d",i,i);

		case(sel)
			2'b00: begin  y4=i; end
			2'b01: begin y1=i; end
			2'b10: begin y2=i; end
			2'b11: begin y3=i; end
		default : begin y1=16'bz;  y2=16'bz; y3=16'bz; y4=16'bz; end 
		endcase
	end
	else
		begin
			y1=16'bz;  y2=16'bz; y3=16'bz; y4=16'bz;
		end
end
endmodule
