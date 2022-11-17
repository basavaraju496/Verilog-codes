/*// `define CLOCK_PERIOD 15.15  //  Frequency=33Mhz precision 2 required
// 1ns/1ps
`define CLOCK_PERIOD 4   // Frequency=250Mhz     precision 0 required
 `timescale 1ns/1ns            

`define CYCLES 10

module variable_tp_clk_generation();

reg clk;

initial 
	begin
			clk=0;
			clk_generation;
	end

task clk_generation;
begin

		repeat(2*`CYCLES)
			begin
					#`CLOCK_PERIOD clk=~clk;
			end

end
endtask

endmodule

*/

// 10ns/1ns = 10 power 1 ==> precision=1    1.55 ==> 1.6 (tool dependent)
// 100ns/1ns  = 100 == 10 power 2 ==>  precision=2  1.55 ==> 155
`timescale 100 ns / 1 ns
module variable_tp_clk_generation;
reg set;
parameter d = 1.55;
initial begin
#d set = 0;
#d set = 1;
end
endmodule
