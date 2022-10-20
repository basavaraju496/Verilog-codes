module logical(input [7:0]a,b,input [2:0]P,input el,output reg [7:0]A,B,C,D,E,F);

always@(*)
begin
//$display("logical block execution ");
   	if(el==0) begin
		case(P)
		3'b101: begin A=a&b; $display("and operation"); end
		3'b110: begin B=a|b; $display("or operation");  end
		3'b111: begin C=~a; $display("not operation");  end
		3'b000: begin D=~(a&b); $display("nand operation");  end
		3'b001: begin E=~(a|b); $display("nor operation");  end
		3'b010: begin F=(a^b); $display("xor operation %b",F);  end
		default : begin A=8'bzzz; B=8'bzz;  C=8'bzz; D=8'bzz; E=8'bzz; F=8'bzz;  end
		endcase
	end
	else 
		begin 
			A=8'bzz; B=8'bzz;  C=8'bzz; D=8'bzz; E=8'bzz; F=8'bzz;

		end
end
endmodule

