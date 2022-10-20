module arithmetic(output reg  [15:0]Y,input [7:0]A,B,input [1:0]P,input enable_low);
always@(A,B,P,enable_low)
begin 
    if(enable_low==0)
	 begin

//$display("opcode came in arithmetic block %b  data came %d %d",P,A,B);
//
    			case(P)                                                                    				// p1 p0 from opcode as selction lines
     				 2'b00:begin Y=A/B; $display("division"); end						 // division performed here for opcode 0001
  	    			2'b01:begin Y=A+B; $display("addtion"); end 						// addition done here for opcode 0010

  	    			2'b10:
					begin 

					if((A>B)|(A==B))
					begin
					Y=A-B; 
					//signflag=1'b0;
 					end
					else
					begin
					Y=B-A;
					//signflag=1'b1;
					end
																		//$display("subtraction"); 
 					end 													// subtraction done here for opcode 0011
 	    			 2'b11:begin Y=A*B; $display("multiplication");  end							 // multiplication done here for opcode 0100
				default : begin Y=16'bz; end     
    			endcase
    	end
    else
	 begin
		Y=16'bz;
					//$display("y in else arithmetic  %b %d ",Y,Y); 

	end

end

endmodule
                 

