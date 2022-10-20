module  nbitdemux(input [15:0]i,input [1:0]sel,input el,output [15:0]y1,y2,y3,y4);
always@(*)
begin 
	if(el==0)
	begin
		case(sel)
		begin
			2'b00: y1=i;
			2'b01: y2=i;
			2'b10: y3=i;
			2'b11: y4=i;
		default : y1=16'bz;  y2=16'bz; y3=16'bz; y4=16'bz; 
		end
	end
	else
		begin
			y1=16'bz;  y2=16'bz; y3=16'bz; y4=16'bz;
		end
end
endmodule
