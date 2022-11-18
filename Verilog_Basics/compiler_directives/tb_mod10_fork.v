`include"counter_mod10.v"

`define DATA_WIDTH 4

`define ADDR_WIDTH 256

module tb_mod10_fork;

reg clk_in=0; // initialising clk_in


// ------------------declaring signals----------------------//


reg reset_in_tb;
reg enable_in_tb;

wire [3:0]design_count_out;  // DESIGN OP

reg [3:0]checker_count_out;  // for checking new op

// ----------- module instantiation ---------------//

counter_mod10 dut_instance(clk_in,reset_in_tb,enable_in_tb,design_count_out);

// ----------------- clock generation------------------//
always #5 clk_in=~clk_in;


// declaring memory for storing the readed values

reg [3:0]DUT_MEMORY[0:`ADDR_WIDTH-1];
reg [3:0]CHECKER_MEMORY[0:`ADDR_WIDTH-1];

//=====================FILES CREATION====================//
	integer fd_DUT, fd_CHECKER;  // file descriptors
	initial begin
		fd_DUT = $fopen("DUT_mod10_op.txt","w");
		fd_CHECKER = $fopen("CHECKER_mod10_op.txt","w");
	end


initial begin

		fork 
			task_checker;
		//	task_compare;
			task_write_into_file;
			task_memory_write;
//			task_write_into_file;
		join


end


initial 
begin
reset_in_tb=0;
enable_in_tb=0;
#20 reset_in_tb=1; enable_in_tb=0;
//#20 reset_in_tb=1; enable_in_tb=1;
//#20 reset_in_tb=0; 


end

// --------------checker op getting ----------------------//

task task_checker;
begin
forever@(posedge clk_in)
begin//{
	
				checker_count_out<=((reset_in_tb==0) || (checker_count_out==10) )?(4'b0):((enable_in_tb==0)?(checker_count_out+1'b1):(checker_count_out));



end //}

end
endtask

// -------------comparing DUT vs TB --------------------// 

task task_compare;
		begin
		forever@(negedge clk_in)

		begin
		if(design_count_out==checker_count_out)
		begin
			$display($time," reset =%b enable=%b   design_count_out=%b ::: check_counter_out=%b ::: both are equal ",reset_in_tb,enable_in_tb,design_count_out,checker_count_out);
		end
		else
			$display($time," reset =%b enable=%b   design_count_out=%b ::: check_counter_out=%b ::: both are NOT equal ",reset_in_tb,enable_in_tb,design_count_out,checker_count_out);
		begin
		
		end


end
end
endtask

	//============= pushing op data into memory ============//
	integer i; // looping iterator 
	task task_memory_write;   // for writing data into files
	begin
		for(i=0;i<`ADDR_WIDTH;i=i+1)begin
			@(negedge clk_in)
			DUT_MEMORY[i]=design_count_out;   // writing counter op to the memory
			CHECKER_MEMORY[i]=checker_count_out;     // writing checker op to memory
			$display("%d %d",DUT_MEMORY[i],CHECKER_MEMORY[i]);
		end
	end
	endtask


	//============= writing memory data to the respectve op files ============//
	task task_write_into_file;
	begin
		forever@(negedge clk_in) begin
			$fwrite(fd_DUT,"%d\n",design_count_out);
			$fwrite(fd_CHECKER,"%d\n",checker_count_out);
		end
	end
	endtask


//----------------- finishing simulation --------------//

initial #2000 $finish;

endmodule

