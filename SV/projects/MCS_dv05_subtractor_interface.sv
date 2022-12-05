interface adder_intf(input clk);
//recieve clk from top
	logic [7:0] in1,in2;
	logic rst;
	logic [7:0] out;

	clocking cb_driver@(posedge clk);
		output in1,in2,rst;     // default #0 delay
		input out;    // default #1 delay
	//	inside_interface_display;
	endclocking

	clocking cb_monitor@(posedge clk);
		input#0 in1,in2,rst;
		input#0 out;
	endclocking


	/*task inside_interface_display();
				$display("inside interface in1=%0d in2=%0d out=%0d",in1,in2,rst);
	endtask*/

endinterface

