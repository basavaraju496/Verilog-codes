// Code your design here
module mux8to1(output y,input [2:0]s,input el,input [7:0]D);
  assign y = ((~el)&(((~s[2])&(~s[1])&(~s[0])&(D[0]))|
              ((~s[2])&(~s[1])&(s[0])&(D[1]))|
                     ((~s[2])&(s[1])&(~s[0])&(D[2]))|
              ((~s[2])&(s[1])&(s[0])&(D[3]))|
              ((s[2])&(~s[1])&(~s[0])&(D[4]))|
              ((s[2])&(~s[1])&(s[0])&(D[5]))|
              ((s[2])&(s[1])&(~s[0])&(D[6]))|
                     ((s[2])&(s[1])&(s[0])&(D[7]))));
endmodule


module BCDtoXS_3(output [3:0]X,input [3:0]B,input el);
      wire [7:0]w0,w1,w2,w3;
  wire [2:0]w4;
   
   assign w0={~B[3],~B[3],~B[3],1'B0,1'B0,1'B0,B[3],B[3]};
   assign w1={1'B0,1'B0,1'B0,~B[3],~B[3],~B[3],1'B1,1'B0};
   assign w2={~B[3],1'B0,1'B0,~B[3],~B[3],1'B0,1'B0,1'B1};
   assign w3={1'B0,~B[3],1'B0,~B[3],1'B0,~B[3],1'B0,1'B1};
  assign w4=B[2:0];
  mux8to1 forx0(X[0],w4,el,w3);
  mux8to1 forx1(X[1],w4,el,w2);
  mux8to1 forx2(X[2],w4,el,w1);
  mux8to1 forx3(X[3],w4,el,w0);
  
endmodule
  

// Code your testbench here
// or browse Examples
module tb_BCDtoXS_3;
  reg [3:0]B;
  reg el;
  wire [3:0]X;
  BCDtoXS_3 DUT(X,B,el);
  initial begin
        // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1);
    el=1'b0;
    B=0; 
    #5 B=0;
    #5 B=4'b0010;
    #5 B=4'b0011;
    #5 B=4'b0100;
    #5 B=4'b0101;
    #5 B=4'b0110;
    #5 B=4'b0111;
    #5 B=4'b1000;
    #5 B=4'b1001;
    #5 B=4'b1010;
  end
  initial begin
    $monitor($time," BCD value is %b  and XS3 value is %b",B,X);
  end
endmodule
