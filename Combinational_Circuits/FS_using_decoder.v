// Code your design here
module decoder3to8df(output [7:0]Y,input el,input [2:0]B);
  assign Y[0]=(~el)&(~(B[2])&(~B[1])&(~B[0]));
    assign Y[1]=(~el)&(~(B[2])&(~B[1])&(B[0]));
      assign Y[2]=(~el)&(~(B[2])&(B[1])&(~B[0]));
      assign Y[3]=(~el)&(~(B[2])&(B[1])&(B[0]));
      assign Y[4]=(~el)&((B[2])&(~B[1])&(~B[0]));
      assign Y[5]=(~el)&((B[2])&(~B[1])&(B[0]));
      assign Y[6]=(~el)&((B[2])&(B[1])&(~B[0]));
      assign Y[7]=(~el)&((B[2])&(B[1])&(B[0]));
endmodule

module FSusingdecoder3to8(output D,bi1,input A,B,bi,el);              
  wire[7:0]M;
  decoder3to8df fsdecoderusing(M,el,{A,B,bi});
  or g1(D,M[1],M[2],M[4],M[7]);
  or g2(bi1,M[1],M[2],M[3],M[7]);
endmodule
             

// Code your testbench here
// or browse Examples
module tb_FSusingdecoder3to8;
  reg A,B,bi,el;
  wire D,bi1;
  FSusingdecoder3to8 DUT(D,bi1,A,B,bi,el);              
  
    initial begin
      el=0;
      A=1'b0;   B=1'b0;  bi=1'b0;
      #5 A=1'b0;   B=1'b0;  bi=1'b1;
      #5 A=1'b0;   B=1'b1;  bi=1'b0;
      #5 A=1'b0;   B=1'b1;  bi=1'b1;
      #5 A=1'b1;   B=1'b0;  bi=1'b0;
      #5 A=1'b1;   B=1'b0;  bi=1'b1;
      #5 A=1'b1;   B=1'b1;  bi=1'b0;
            #5 A=1'b1;   B=1'b1;  bi=1'b1;

     // #5 A=1'b0;   B=1'b0;  bi=1'b1;
     // #5 A=1'b0;   B=1'b0;  bi=1'b0;


  end
  initial
    begin
      $monitor($time,"   inputs are %B %b %b difference is %b borrow is %b  ",A,B,bi,D,bi1);
      
    end
  
endmodule
