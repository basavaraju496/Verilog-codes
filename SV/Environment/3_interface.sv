interface mux_intf(input clk);

logic [7:0]data_in;

logic [1:0]selection_in;

logic mux_out;

clocking cb_driver@(posedge clk)   // for driver 
			input    mux_out;    // #1 delay 
			output   data_in,selection_in;   // #0 delay 
		endclocking

clocking cb_monitor@(posedge clk)   // for ip monitor  , op monitor

			input    #0 mux_out;  
			input    #0 data_in,selection_in;  

		endclocking


endinterface
