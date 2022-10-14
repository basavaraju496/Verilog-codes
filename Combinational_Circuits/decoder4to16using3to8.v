// Code your design here
// Code your design here
module decoder3to8df(output [7:0]Y,input el,input [2:0]B);
  assign Y[0]=(~el)&(~(B[2])&(~B[1])&(~B[0])),
    Y[1]=(~el)&(~el)&(~(B[2])&(~B[1])&(B[0])),
    Y[2]=(~el)&(~(B[2])&(B[1])&(~B[0])),
    Y[3]=(~el)&(~(B[2])&(B[1])&(B[0])),
    Y[4]=(~el)&((B[2])&(~B[1])&(~B[0])),
    Y[5]=(~el)&((B[2])&(~B[1])&(B[0])),
    Y[6]=(~el)&((B[2])&(B[1])&(~B[0])),
    Y[7]=(~el)&((B[2])&(B[1])&(B[0]));
endmodule


module decoder4to16df(output [15:0]y,input [3:0]A);
  wire [2:0]w2;

  assign w2={A[2],A[1],A[0]};
//   assign w3=y[7:0];
//   assign w1=;
  decoder3to8df formsb(.Y(y[15:8]),.el(~A[3]),.B(w2));
  decoder3to8df forlsb(.Y(y[7:0]),.el((A[3])),.B(w2));
endmodule


// Code your testbench here
// or browse Examples
module tb_decoder4to16df;
  reg [3:0]A;
  wire [15:0]y;
  decoder4to16df DUT(y,A);
  initial begin
    //el=1'b0;
//    el=1'b1;
    #1
    A[3] = 0 ; A[2] = 0; A[1] = 0 ; A[0] = 0;
    #1
    A[3] = 0 ; A[2] = 0; A[1] = 0 ; A[0] = 1;
    #1
    A[3] = 0 ; A[2] = 0; A[1] = 1 ; A[0] = 0;
    #1
    A[3] = 0 ; A[2] = 1; A[1] = 0 ; A[0] = 0;
 //   A=4'b0000;
    #5 A=4'b0001;
    #5 A=4'b0010;
    #5 A=4'b0011;
    #5 A=4'b0100;
    #5 A=4'b0101;
    #5 A=4'b0110;
    #5 A=4'b0111;
    #5 A=4'b1000;
    #5 A=4'b1001;
    #5 A=4'b1010;
    #5 A=4'b1011;
    #5 A=4'b1100;
    #5 A=4'b1101;
    #5 A=4'b1110;
    #5 A=4'b1111;
    
    
  end
  initial begin
    $monitor($time," Address is %b and decoded as %b location  ",A,y);
  end
endmodule
