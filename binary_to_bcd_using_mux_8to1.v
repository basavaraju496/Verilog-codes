// Code your design here
module mux_8to1(output y,
                input d0,d1,d2,d3,d4,d5,d6,d7,s2,s1,s0,El);
  assign y = (~El)&(((~s2)&(~s1)&(~s0)&d0)|((~s2)&(~s1)&(s0)&d1)|((~s2)&(s1)&(~s0)&d2)|((~s2)&(s1)&(s0)&d3)|((s2)&(~s1)&(~s0)&d4)|((s2)&(~s1)&(s0)&d5)|((s2)&(s1)&(~s0)&d6)|((s2)&(s1)&(s0)&d7));
endmodule

module BinarytoBCD(output [4:0]D,input El,input [3:0]B);
  
  mux_8to1 forBCD0(D[0],1'b0,1'b1,1'b0,1'b1,1'b0,1'b1,1'b0,1'b1,B[2],B[1],B[0],El);
  mux_8to1 forBCD1(D[1],1'b0,1'b0,(~B[3]),(~B[3]),1'b0,1'b0,(~B[3]),(~B[3]),B[2],B[1],B[0],El);
  mux_8to1 forBCD2(D[2],1'b0,1'b0,1'b0,1'b0,(~B[3]),(~B[3]),1'B1,1'B1,B[2],B[1],B[0],El);
  mux_8to1 forBCD3(D[3],B[3],B[3],1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,B[2],B[1],B[0],El);
  mux_8to1 forBCD4(D[4],1'b0,1'b0,B[3],B[3],B[3],B[3],B[3],B[3],B[2],B[1],B[0],El);
endmodule
//B[3]



// Code your testbench here
// or browse Examples
module tb_BinarytoBCD;
  reg [3:0]B;
  reg El;
  wire [4:0]D;
  BinarytoBCD DUT(D,El,B);
  initial begin
        // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1);
    El=1'b0;
    B=0; 
    #5 B=5;
    #5 B=1'b0101;
    #5 B=4'b0010;
    #5 B=4'b0011;
    #5 B=4'b0100;
    #5 B=4'b0101;
    #5 B=4'b0110;
    #5 B=4'b0111;
    #5 B=4'b1000;
    #5 B=4'b1001;
    #5 B=4'b1010;
    #5 B=4'b1111;
    #5 B=5'b11110;
  end
  initial begin
    $monitor($time," binary value is %b decimal is %d and BCD value is %b",B,B,D);
  end
endmodule
