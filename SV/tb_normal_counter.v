`include"counter_mod10.v"

module tb_normal_counter;

reg reset,enable;
reg clk=0;
wire [3:0]counter_out;

counter_mod10 DUT_normal(clk,reset,enable,counter_out);

always #5 clk=~clk;

initial
	begin
	reset=0; enable=0;
#20  reset=1; enable=1;
#20  reset=1; enable=0;
	
$monitor("counter_out=%0d",counter_out);
	end
	initial begin
	
#200 $finish;
	end
endmodule
