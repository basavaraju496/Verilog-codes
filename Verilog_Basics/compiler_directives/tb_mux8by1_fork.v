`include"mux8by1.v"

`define DATA_WIDTH 1


`define ADDR_WIDTH 256


module tb_mux8by1_fork;

reg clk=0;


// ------------------declaring signals----------------------//
reg [7:0]data_in_tb;

reg [2:0]selection_in_tb;

wire design_mux_out;

reg check_mux_out;
// declaring memory for storing the readed values

reg [`DATA_WIDTH-1:0]DUT_MEMORY[0:`ADDR_WIDTH-1];
reg [`DATA_WIDTH-1:0]CHECKER_MEMORY[0:`ADDR_WIDTH-1];


//=====================FILES CREATION====================//
	integer fd_DUT, fd_CHECKER;  // file descriptors
	initial begin
		fd_DUT = $fopen("DUT_mux_op.txt","w");
		fd_CHECKER = $fopen("CHECKER_mux_op.txt","w");
	end










// ----------- module instantiation ---------------//

mux8to1 dut_instance(data_in_tb,selection_in_tb,design_mux_out,clk);

// ----------------- clock generation------------------//
always #5 clk=~clk;

initial begin
fork
		task_compare;
		task_checker;
		task_stimulus;
		task_write_into_file;
		task_memory_write;


join


end




// --------stimulus input ------------------//

//always@(negedge clk) 
task task_stimulus;
begin
forever@(negedge clk)

begin
	data_in_tb=$random;
	selection_in_tb=$random;

end
end
endtask

// --------------checker op getting ----------------------//


task task_checker;
begin
forever@(posedge clk)

begin
	//check_mux_out=data_in_tb[selection_in_tb];    // mux virtual op in check 
	case(selection_in_tb)
	3'b000: begin check_mux_out=data_in_tb[0]; end 
	3'b001: begin check_mux_out=data_in_tb[1]; end 
	3'b010: begin check_mux_out=data_in_tb[2]; end 
	3'b011: begin check_mux_out=data_in_tb[3]; end 
	3'b100: begin check_mux_out=data_in_tb[4]; end 
	3'b101: begin check_mux_out=data_in_tb[5]; end 
	3'b110: begin check_mux_out=data_in_tb[6]; end 
	3'b111: begin check_mux_out=data_in_tb[7]; end 
	default : begin check_mux_out=8'bz; end

	endcase
end
end
endtask
// -------------comparing DUT vs TB --------------------// 

task task_compare;
begin
forever@(negedge clk)

		begin
		if(design_mux_out==check_mux_out)
		begin
			$display($time," data = %b sel=%b design_mux_out=%b ::: check_mux_out=%b ::: both are equal ",data_in_tb,selection_in_tb,design_mux_out,check_mux_out);
		end
		else
		begin
			$display($time,"data=%b sele=%b design_mux_out=%b ::: check_mux_out=%b ::: both are not equal ",data_in_tb,selection_in_tb,design_mux_out,check_mux_out);
		end

end
end
endtask

//

	//============= pushing op data into memory ============//
	integer i; // looping iterator 
	task task_memory_write;   // for writing data into files
	begin
		for(i=0;i<`ADDR_WIDTH;i=i+1)begin
			@(negedge clk)
			DUT_MEMORY[i]=design_mux_out;   // writing counter op to the memory
			CHECKER_MEMORY[i]=check_mux_out;     // writing checker op to memory
			$display("%d %d",DUT_MEMORY[i],CHECKER_MEMORY[i]);
		end
	end
	endtask


	//============= writing memory data to the respectve op files ============//
	task task_write_into_file;
	begin
		forever@(negedge clk) begin
			$fwrite(fd_DUT,"%d\n",design_mux_out);
			$fwrite(fd_CHECKER,"%d\n",check_mux_out);
		end
	end
	endtask

//----------------- finishing simulation --------------//



initial #1000 $finish;

endmodule
