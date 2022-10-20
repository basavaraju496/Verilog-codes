module tb_shifter;
reg [7:0]A,B;
reg el;
wire [7:0]Y;
wire sf;
shifter DUT(A,B,Y,sf,el);
	initial 
		begin
			el=1'b0;
			A=8'B1111_0000;
			B=8'B0010_0000;
		#5	B=8'B0010_0001;
		#5	B=8'B0010_0010;
		#3	B=8'B0010_0011;

	 	end
	initial		$monitor($time," input data =%b  output data =%b sflag=%b ",A,Y,sf);
 
endmodule
