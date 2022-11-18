module mux8to1(input [7:0]data_in,input [2:0]selection_in,output reg mux_out,input clk);

// ------------------------ input is 8bit data  ----------------------------//
// ------------------------selection is for selecting which data to transmit ---------------------------------//
always@(posedge clk)
		  begin
					mux_out=data_in[selection_in];

		  end
endmodule


