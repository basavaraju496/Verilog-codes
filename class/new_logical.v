`include"logical.v"
`include"mux6by1.v"
module new_logical([7:0]A,B,input el,input [2:0]sel, output [7:0]logical_out);
//module logical(input [7:0]a,b,input [2:0]P,input el,output reg [7:0]A,B,C,D,E,F);
//
wire [7:0]w5,w6,w7,w8,w9,w10;
logical M1(A,B,sel,el,w5,w6,w7,w8,w9,w10);
								//module 6by1mux  (input [7:0]A,B,C,D,E,F ,input [2:0]sel,input el,output reg [7:0]Y);
mux6by1 m2(w5,w6,w7,w8,w9,w10,sel,el,logical_out);

endmodule
