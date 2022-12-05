
/////////dut////////////////////////
module adder(in1,in2,rst,clk,out);
// input 
	input [7:0] in1,in2;
	input rst,clk;
	output reg [7:0] out;

	always@(posedge clk)
	begin
	$display("inside dut");
		if(rst)  // active high reset
			out <= 0;
		else
			out <= in1 + in2;
		end

endmodule



