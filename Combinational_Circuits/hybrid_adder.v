module CLA(input [3:0]A,B,input Cin,output reg Cout,output reg [3:0]S);
   // generated carrydeclaration
  reg [3:0]P,G;
  reg [3:0]C;
  always@(A,B,Cin)
    begin
      G=A&B;
      P=A^B;
//       for(i=0; i<4: i=i+1) begin 
      C[0]=(G[0]|(P[0]&Cin));
      C[1]=(G[1]|(P[1]&C[0]));
      C[2]=(G[2]|(P[2]&C[1]));
      Cout=(G[3]|(P[3]&C[2]));
      S[3]=(P[3]^C[2]);
      S[2]=(P[2]^C[1]);
      S[1]=(P[1]^C[0]);
      S[0]=(P[0]^Cin);
    end
endmodule
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
module hybridadder32bit(input [31:0]A,B,input  Cin,output Cout,output reg [32:0]sum);
//   module CLA(input [3:0]A,B,input Cin,output reg Cout,output reg [3:0]S);
// module RCA(input [3:0]A,B,input Cin,output Cout,output [3:0]S);
  wire [6:0]w;

  always@(A,B,Cin) begin
    $display("A=%b B=%b Cin=%b",A,B,Cin);
  end
    
  
  RCA for0to3(A[3:0],B[3:0],Cin,w[0],sum[3:0]);
  CLA for4to7(A[7:4],B[7:4],w[0],w[1],sum[7:4]);
  
  RCA for8to11(A[11:8],B[11:8],w[1],w[2],sum[11:8]);
  CLA for12to15(A[15:12],B[15:12],w[2],w[3],sum[15:12]);
  
  RCA for16to19(A[19:16],B[19:16],w[3],w[4],sum[19:16]);
  CLA for20to23(A[23:20],B[23:20],w[4],w[5],sum[23:20]);
  
  RCA for24to27(A[27:24],B[27:24],w[5],w[6],sum[27:24]);
  CLA for28to31(A[31:28],B[31:28],w[6],Cout,sum[31:28]);

endmodule
  
  
  
  
  
  
module tb;
  reg [31:0]A,B;
  wire [31:0]sum;
  wire Cout;
  reg Cin;
  hybridadder32bit DUT(A,B,Cin,Cout,sum);
 //initial begin
   
 initial begin
   Cin=1'b0;
   A=32'd0001; B=32'd4294967295;
   #5    A=32'd0000; B=32'd0001;
 end
   initial begin
     $monitor($time," a %b is b is %b sum is %b carry is %b ",A,B,sum,Cout);
   end
  endmodule
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
