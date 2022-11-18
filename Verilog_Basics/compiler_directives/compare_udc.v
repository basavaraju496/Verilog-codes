module compare_udc;
  reg [31:0]read_DUT_memory[0:255]; // memory for DUT file
  reg [31:0]read_CHECKER_memory[0:255]; //memory for CHECKER file
	integer i,fd;
	initial begin
      
	
	$readmemh("DUT_UDC_op.txt",read_DUT_memory); // reading data from file and storing into memory
		$readmemh("CHECKER_UDC_op.txt",read_CHECKER_memory);

fd=$fopen("UDC_result.txt","w");


		for(i=0;i<255;i=i+1) begin//{
          if(read_DUT_memory[i]==read_CHECKER_memory[i]) 
		begin
		$display("dut memory =%0d checker memory =%0d ----------PASSED-------",read_DUT_memory[i],read_CHECKER_memory[i]); //comparing data in both the files
		$fwrite(fd,"%s %d %d \n","both are equal",read_CHECKER_memory[i],read_DUT_memory[i]);
		end
			else 
		begin
		$display("xxxxxxx---FAILED---ixxx");
		$display("dut memory =%0d checker memory =%0d ----------PASSED-------",read_DUT_memory[i],read_CHECKER_memory[i]); //comparing data in both the files
		$fwrite(fd,"%s %0d %0d \n","both are not equal",read_CHECKER_memory[i],read_DUT_memory[i]);
		
		end
		end//}
	end
endmodule
