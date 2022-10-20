module decoder_4x16 (output reg [15:0]d_out,input [3:0]opcode_in,input init_l);   // active low decoder
 parameter tmp = 16'b0000_0000_0000_0001;
 	 always@(opcode_in,init_l) 
	begin
 	   if(init_l==0)
		 begin 
     		 d_out=16'bz;    // init like reset active low gives zzzz
   		 end
	   else
		 begin	
//$display("opcode in decoder  %3d",opcode_in);
			case(opcode_in)
			4'b0000: begin 	 d_out = 16'hffff;   end   
			4'b0001: begin 	 d_out = ~(tmp<<1);   end
			4'b0010: begin 	 d_out = ~(tmp<<2);  end
			4'b0011: begin 	 d_out = ~(tmp<<3);   end
			4'b0100: begin 	 d_out = ~(tmp<<4);   end
			4'b0101: begin 	 d_out = ~(tmp<<5);   end
			4'b0110: begin 	 d_out = ~(tmp<<6);   end
			4'b0111: begin 	 d_out = ~(tmp<<7);   end
			4'b1000: begin 	 d_out = ~(tmp<<8);   end
			4'b1001: begin 	 d_out = ~(tmp<<9);   end
			4'b1010: begin 	 d_out = ~(tmp<<10);   end
			4'b1011: begin 	 d_out = ~(tmp<<11);   end
			4'b1100: begin 	 d_out = ~(tmp<<12);   end
			4'b1101: begin 	 d_out = ~(tmp<<13);    end
			4'b1110: begin 	 d_out = ~(tmp<<14);   end
			4'b1111: begin 	 d_out = ~(tmp<<15);   end

			default:          d_out = 16'bxxxx_xxxx_xxxx_xxxx;
		endcase
		end
	end
endmodule
