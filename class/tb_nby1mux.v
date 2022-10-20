module tb_nby1mux;
parameter N=8;
reg [N-1:0]D;
reg el;
reg [$clog2(N)-1:0]sel;
wire Y;
integer i;
nby1mux #(N) DUT(D,sel,el,Y);   
	initial 
		begin
			el=1'b0;
		#5	D=8'b1111_0000;      // giving input data
		#1	sel=3'b000;  // giving selection 

for(i=0; i<N; i=i+1)
#5 sel=i;


	 	end
	initial		$monitor($time," input data =%b SEL=%b  output data =%b ",D,sel,Y);
 
endmodule
