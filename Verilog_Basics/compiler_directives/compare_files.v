
`ifdef COMPARE_MOD10
module compare_files;
  reg [31:0]read_DUT_memory[0:255]; // memory for DUT file
  reg [31:0]read_CHECKER_memory[0:255]; //memory for CHECKER file
	integer i=0;
	initial begin
      
	
	$readmemh("DUT_mod10_op.txt",read_DUT_memory); // reading data from file and storing into memory
		$readmemh("CHECKER_mod10_op.txt",read_CHECKER_memory);




		for(i=0;i<199;i=i+1) begin//{
          if(read_DUT_memory[i]==read_CHECKER_memory[i]) 
		begin
		$display("dut memory =%0d checker memory =%0d ----------PASSED-------",read_DUT_memory[i],read_CHECKER_memory[i]); //comparing data in both the files
		end
			else 
		begin
		$display("xxxxxxx---FAILED---ixxx");
		$display("dut memory =%0d checker memory =%0d ----------PASSED-------",read_DUT_memory[i],read_CHECKER_memory[i]); //comparing data in both the files
		
		end
		end//}
	end
endmodule

`endif



`ifdef  COMPARE_MUX
module compare_files;
  reg [31:0]read_DUT_memory[0:255]; // memory for DUT file
  reg [31:0]read_CHECKER_memory[0:255]; //memory for CHECKER file
	integer i=0;
	initial begin
      
	
	$readmemh("DUT_mux_op.txt",read_DUT_memory); // reading data from file and storing into memory
		$readmemh("CHECKER_mux_op.txt",read_CHECKER_memory);




		for(i=0;i<199;i=i+1) begin//{
          if(read_DUT_memory[i]==read_CHECKER_memory[i]) 
		begin
		$display("dut memory =%0d checker memory =%0d ----------PASSED-------",read_DUT_memory[i],read_CHECKER_memory[i]); //comparing data in both the files
		end
			else 
		begin
		$display("xxxxxxx---FAILED---ixxx");
		$display("dut memory =%0d checker memory =%0d ----------PASSED-------",read_DUT_memory[i],read_CHECKER_memory[i]); //comparing data in both the files
		
		end
		end//}
	end
endmodule

`endif
