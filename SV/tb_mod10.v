`include"counter_mod10.v"
module tb_mod10;

reg clk_in=0; // initialising clk_in


// ------------------declaring signals----------------------//


reg reset_in_tb;
reg enable_in_tb;

wire design_count_out;  // DESIGN OP

reg checker_count_out;  // for checking new op

// ----------- module instantiation ---------------//

counter_mod10 dut_instance(clk_in,reset_in_tb,enable_in_tb,design_count_out);

// ----------------- clock generation------------------//
always #5 clk_in=~clk_in;

// --------stimulus input ------------------//

/*always@(negedge clk_in) 
begin
	
end
*/
initial 
begin
reset_in_tb=0;
enable_in_tb=0;
#20 reset_in_tb=1; enable_in_tb=0;
#20 reset_in_tb=1; enable_in_tb=1;
#20 reset_in_tb=0; 


end

// --------------checker op getting ----------------------//

always@(posedge clk_in)
begin//{
				if(reset_in_tb==0)
					begin
						checker_count_out=0;
					end
			else if(enable_in_tb==0)
				begin
					if(checker_count_out<10)
						checker_count_out=checker_count_out+1;
					else 
					checker_count_out=0;
					
				end
			else
				begin
					checker_count_out=checker_count_out;
				end

end //}



// -------------comparing DUT vs TB --------------------// 

always@(negedge clk_in )
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


//----------------- finishing simulation --------------//

initial #1000 $finish;

endmodule

