// Code your design here
module codeconvertor(output reg  [7:0]Y,output reg fdone,input [7:0]B,input enable_low);
wire [3:0]w1;
assign w1={B[7],B[6],B[5],B[4]};
wire [1:0]w2;
assign w2={B[1],B[0]};
  always@(*)
    begin 
    	if(enable_low==0)
	 begin
    		case(w2)  // b1 b0  from vector b  as selction lines
      			2'b01:begin Y=binarytogray(w1); fdone=1'b1 ; end		 // binary to gray performed here for opcode 00
	    		2'b10:begin Y=binarytoxs3(w1);  fdone=1'b1  ; end 		// binary to xs-3  done here for opcode 10
		      	2'b11:begin Y=binarytoxs5(w1); fdone=1'b1   ; end 		// binary to xs-5  done here for opcode 11
      			2'b00:begin Y=binarytobcd(w1);  fdone=1'b1  ; end 		// binary to BCD  done here for opcode 00
			default : begin Y=8'b0; end      
    		endcase
   	 end
    	else
		 begin
			Y=8'b0;
		end
  	  end
// functions 
	function [3:0]binarytogray;                                    //binary to gray block 		
	input [3:0]B;
	begin
	binarytogray={B[3],B[3]^B[2],B[2]^B[1],B[1]^B[0]};
	end
	endfunction
			function [7:0]binarytoxs3;                                    //binary to xs 3 block 
			
			input [3:0]B;
							//		reg [4:0]tmp;

			begin
			if(B<9)
				begin
					binarytoxs3=B+8'd3;
 				end
				else
				begin
					binarytoxs3=B+8'd57;
				end
			
		
						 								   //   tmp=binarytobcd(B);
													//$display("temp=%b binary = %b",tmp,B);
														//	binarytoxs3=tmp+3'b011;
			end
			endfunction
	function [7:0]binarytoxs5;                                    //binary to xs 5 block 
			
	input [3:0]B;
    													   // reg	[4:0]tmp;
        begin	
										 //tmp=binarytobcd(B);

												//binarytoxs5=tmp+3'b101;
	if(B<10)
		begin
			binarytoxs5=B+8'd5;
 		end
		else
		begin
			binarytoxs5=B+8'd91;
		end
	end
	endfunction
			function [7:0]binarytobcd;                                    //binary to bcd block 
			
			input [3:0]B;
			begin
			binarytobcd=(B<4'b1010)?B:B+3'b110;
			end
			
			endfunction

endmodule
