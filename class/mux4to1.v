// Code your design here
module mux4to1(output reg  [15:0]Y,input [7:0]A,B,input [1:0]P,input enable_low);
  always@(A,B,P,enable_low)begin 
    if(enable_low==0) begin
    case(P)  // p1 p0 from opcode as selction lines
      2'b00:begin Y=A/B; end // division performed here for opcode 0001
      2'b01:begin Y=A+B; end // addition done here for opcode 0010
      2'b10:begin Y=A-B; end // subtraction done here for opcode 0011
      2'b11:begin Y=A*B; end // multiplication done here for opcode 0100
default : begin Y=16'bz; end      
    endcase
    end
    else begin
	Y=0;
	end
  end
endmodule
                 
             
