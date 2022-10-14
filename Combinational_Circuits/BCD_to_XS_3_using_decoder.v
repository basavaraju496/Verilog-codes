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


// Code your design here
module BCDtoXS3(output [3:0]X,input [3:0]B);

  wire [15:0]M;
  wire [3:0]w5;
  assign w5=({B[3],B[2],B[1],B[0]});

  decoder4to16df getxs3min(.y(M[15:0]),.A((w5)));
 assign X[0]=(M[0]|M[2]|M[4]|M[6]|M[8]);
  or g4(X[1],M[0],M[3],M[4],M[7],M[8]);
//  or g1(X[0],M[0],M[2],M[4],M[6],M[8]);
  or g2(X[2],M[1],M[3],M[2],M[4],M[9]);
  or g3(X[3],M[7],M[6],M[5],M[9],M[8]);
   // or g5(X[1],M[0],M[3],M[4],M[7],M[8]);
endmodule



// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
module tb_BCDtoXS3;
  reg [3:0]B;
  wire [3:0]X;
  //decoder4to16df DUT(y,A);
  BCDtoXS3 DUT(X,B);
  initial begin
    //el=1'b0;
//    el=1'b1;
      B=4'b0000;
    #5 B=4'b0001;
    #5 B=4'b0010;
    #5 B=4'b0011;
    #5 B=4'b0100;
    #5 B=4'b0101;
    #5 B=4'b0110;
    #5 B=4'b0111;
    #5 B=4'b1000;
    #5 B=4'b1001;
    #5 B=4'b1010;
    #5 B=4'b1011;
    #5 B=4'b1100;
    #5 B=4'b1101;
    #5 B=4'b1110;
    #5 B=4'b1111;
  end
  initial begin
    $monitor($time," BINARY  is %b and converted as XS-3  %b",B,X);
  end
endmodule
