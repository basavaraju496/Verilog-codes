// Code your design here
module FA(output reg Sum, output reg Cout,input A,B,Cin);
  always@(A,B,Cin)
    begin
      case ({A,B,Cin})
        3'b000 : begin Sum=1'b0; Cout=1'b0; end
          3'b001 : begin Sum=1'b1; Cout=1'b0; end
          3'b010 : begin Sum=1'b1; Cout=1'b0; end
          3'b011 : begin Sum=1'b0; Cout=1'b1; end
          3'b100 : begin Sum=1'b1; Cout=1'b0; end
          3'b101 : begin Sum=1'b0; Cout=1'b1; end
          3'b110 : begin Sum=1'b0; Cout=1'b1; end
          3'b111 : begin Sum=1'b1; Cout=1'b1; end
        default :begin Sum=1'b0; Cout=1'b0; end
      endcase
     end
endmodule


module RCA(input [3:0]A,B,input Cin,output Cout,output [3:0]S);
  wire [2:0]C;
  FA fors0(S[0],C[0],A[0],B[0],Cin);
  FA fors1(S[1],C[1],A[1],B[1],C[0]);
  FA fors2(S[2],C[2],A[2],B[2],C[1]);
  FA fors3(S[3],Cout,A[3],B[3],C[2]);
endmodule



// Code your testbench here
// or browse Examples
module tb;
  reg [3:0]A,B;
  reg Cin;
  wire [3:0]S;
  wire Cout;
  RCA DUT(A,B,Cin,Cout,S);
 initial begin
   Cin=1'b0;
   A=4'b0000;
   #5 A=4'b0000; B=4'b0000;
   #5 A=4'b0000; B=4'b0001;
   #5 A=4'b0000; B=4'b0010;
   #5 A=4'b1000; B=4'b1000;
 end
 initial #200  $finish; 
   initial begin
     $monitor($time," a %b is b is %b sum is %b carry is %b ",A,B,S,Cout);
   end
  endmodule
  
  
