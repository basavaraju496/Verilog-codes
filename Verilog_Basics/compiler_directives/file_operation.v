`define DATA_WIDTH 8
`define ADDR_WIDTH 256


module file_operation();

reg [`DATA_WIDTH-1:0] mem[0:`ADDR_WIDTH-1];  // declaring memory of data width

integer file_handler,i;

initial begin
		fork
			task_file_open;
			task_memory_address;
			task_memory_write;
		join
		task_read;
end


task task_file_open;
begin
		file_handler=$fopen("memory_out.txt","w");
end
endtask

task task_memory_address;  // declaring memory address
begin  
		for(i=0;i<256;i=i+1) begin
			mem[i]=i;
			$display("************memory[%0d]=%0d************** ",mem[i],i);
			end
end
endtask

task task_memory_write;  // declaring memory address
begin  
		for(i=0;i<256;i=i+1)
			$fwrite(file_handler,"%s \n","new data");

		//	$fwrite(file_handler,"%s \n","*");
end
endtask



task task_read;
begin
//reg [`DATA_WIDTH:0] test_memory [0:`ADDR_WIDTH];
integer j;
				$display("Loading memory data ");
				$readmemh("file_operation.txt", test_memory);
														for(j=0;j<`ADDR_WIDTH;j=j+1)
																$display("test_memory[%0d]=%0d",j,test_memory[j]);
end
endtask













initial
begin

$monitor("mem[%0d]=%0d",i,i);

#1000 $finish;
end

endmodule
