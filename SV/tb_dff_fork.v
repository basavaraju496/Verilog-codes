`include"dff.v"
module tb_dff_fork;

reg clk_in=0; // initialising clk_in


// ------------------declaring signals----------------------//
reg din_tb;

reg reset_in_tb;
reg enable_in_tb;
wire design_q_out;  // DESIGN OP

reg check_q_out;  // for checking new op

// ----------- module instantiation ---------------//

dff dut_instance(clk_in,reset_in_tb,enable_in_tb,din_tb,design_q_out);

// ----------------- clock generation------------------//
always #5 clk_in=~clk_in;


initial 
	begin 
			fork
			task_stimulus;
			task_checker;
			task_compare;
			join
	end











// --------stimulus input ------------------//

//always@(negedge clk_in) 
task task_stimulus;
		begin
			forever @(negedge clk_in) din_tb=$random;
		end // task_stimulus end
endtask

initial 
begin
	reset_in_tb=0;   enable_in_tb=1;

#20 reset_in_tb=1'b1;  enable_in_tb=0;
//#10 enable_in_tb=0;



end

// --------------checker op getting ----------------------//

//always@(posedge clk_in or negedge reset_in_tb)
task task_checker;
begin
forever @(posedge clk_in or negedge reset_in_tb) 
			begin//{
					if(reset_in_tb==0)
							begin
							check_q_out<=0;
					end
					else if (enable_in_tb==0)
							begin
							check_q_out<=din_tb;
				
							end
					else
							begin
							check_q_out<=check_q_out;
							end

			end //}
end
endtask


// -------------comparing DUT vs TB --------------------// 

//always@(negedge clk_in )
task task_compare;
begin
forever @(negedge clk_in)
	begin
		if(design_q_out==check_q_out)
		begin
			$display($time," reset =%b enable=%b data = %b  design_q_out=%b ::: check_q_out=%b ::: both are equal ",reset_in_tb,enable_in_tb,din_tb,design_q_out,check_q_out);
		end
		else
		begin
		
			$display($time,"reset=%b enable=%b data = %b  design_q_out=%b ::: check_q_out=%b ::: both are NOT equal ",reset_in_tb,enable_in_tb,din_tb,design_q_out,check_q_out);
		end

		end
end
endtask

//----------------- finishing simulation --------------//

initial #1000 $finish;

endmodule

