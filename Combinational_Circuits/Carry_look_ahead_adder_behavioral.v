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


  



module tb;
  reg [3:0]A,B;
  reg Cin;
  wire [3:0]S;
  wire Cout;
  CLA DUT(A,B,Cin,Cout,S);
 initial begin
   Cin=1'b0;
   A=4'b0000;
   #5 A=4'b0011; B=4'b0111;
   #5 A=4'b0000; B=4'b0001;
   #5 A=4'b0000; B=4'b0010;
   #5 A=4'b1000; B=4'b1000;
 end
 initial #200  $finish; 
   initial begin
     $monitor($time," a %b is b is %b sum is %b carry is %b ",A,B,S,Cout);
   end
  endmodule
  
  
