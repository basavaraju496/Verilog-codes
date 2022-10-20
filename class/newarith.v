`include"nbitdemux.v"
`include"arithmetic.v"
//module arithmetic(output reg  [15:0]Y,input [7:0]A,B,input [1:0]P,input enable_low);

module new_arithmetic(input [7:0]A,B,input el,input [1:0]sel,output [15:0]y1,y2,y3,y4);
//nbitdemux demuxing(Y,P,enable_low,y1,y2,y3,y4);
wire [15:0]y;

arithmetic arithmeticblock(y,A,B,sel,el);
//module  nbitdemux(input [15:0]i,input [1:0]sel,input el,output reg [15:0]y1,y2,y3,y4);
//initial $display("output in new arith %d",y);

nbitdemux demuxing(y,sel,el,y1,y2,y3,y4);
//initial
//$display("output in new arith %d %d %d %d %d",y,y1,y2,y3,y4);

endmodule






