module tb_fsm_VM;
reg clk_in,reset_in;
reg enable_in,s1,s2,s3,s4,rupees10,rupees20,cancel_in;
wire [7:0]change_out,return_out;
wire product_out;

vending_machine DUT(clk_in,reset_in,enable_in,s1,s2,s3,s4,rupees10,rupees20,cancel_in,change_out,return_out,product_out); 


				initial
 					begin
 						main;
					 end
task main;
				 fork
				 clock_gen;
 				 operation_flow;
				 debug_output;
				 endsimulation;
				 join
endtask

task clock_gen; 
			 begin
				clk_in=1'b0;
 				forever #1 clk_in = ~clk_in;
			  end
endtask

/*task reset_gen;

begin
	reset_in=1'b0; enable_in=1'b1;
#5 reset_in=1'b1; enable_in=1'b0;

 end
endtask*/
task operation_flow;
begin
enable_in=1'b0;
reset_in=1'b0;
cancel_in=0;
@(negedge clk_in) reset_in=1'b1; s1=1'b1;
@(negedge clk_in) rupees10=1'b1; 
@(negedge clk_in) rupees20=1'b1; rupees10=1'b0;
//@(negedge clk_in) 

end
endtask

task debug_output;
				begin
					 $display("------------");
					 $display("------------------  ");
					 $display("----------- SIMULATION RESULT ----------------");
					 $display("--------------             -------------------");
					 $display("----------------         ---------------------");
					 $display("----------------------------------------------");
					 $monitor($time,"  reset_in = %b ,enable_in =%b ,s1_in =%b s2=%b s3=%b s4=%b rs10=%b ,rs20=%b change_out =%b return_out=%b ,product_out = %b ",reset_in,enable_in,s1,s2,s3,s4,rupees10,rupees20,change_out,return_out,product_out); 

end
endtask
task endsimulation;
begin
 #20
 $display("-------------- THE SIMUALTION END ------------");
 $finish;
end
endtask
endmodule

