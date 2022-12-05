//////////////////////1.top//////////////////////
module top;

	bit clk;
	always #5 clk++;         // generating clk 
	
	adder_intf h_intf(clk);  // creating handle and sending clk ip to the intf
	test h_test;              // handle for test

	adder dut(.in1(h_intf.in1),.in2(h_intf.in2),.rst(h_intf.rst),.clk(h_intf.clk),.out(h_intf.out));  // dut module instantiation

	initial
	begin
		h_test = new(h_intf); // asiigning memory for the h_test and sending the vintf(includes clk,data(not given now,given in dut))
		h_test.run(); // calls the run method in test and that method calls the run method in environment that method calls the run method i all classes
	end

	initial
	begin
		#200;
		$finish;
	end

endmodule
///////////////////////////////////////////////////////
