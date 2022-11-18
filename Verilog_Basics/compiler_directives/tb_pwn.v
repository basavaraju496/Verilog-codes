module tb_pwm;
reg clk_in,refresh;
reg enable_in
	 reg [1:0]selection;
wire clk_out;
//module pwm_generation(input clk_in,refresh,enable,input [1:0]selection, output clk_out);

pwm_generation DUT(clk_in,refresh,enable_in,selection,clk_out);


																	initial
															 					begin
																 						main;
																				 end
task main;
				 fork
				 clock_gen;
			//	 reset_gen;
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
enable_in=1'b1;
//#enable_in=1'b1

@(negedge clk_in) refresh=1'b0;
@(negedge clk_in) enable_in=1'b0;

@(negedge clk_in) refresh=1'b1;

@(negedge clk_in) selection=2'b01;

@(negedge clk_in) 

@(negedge clk_in) 

@(negedge clk_in) 

@(negedge clk_in) 

@(negedge clk_in) 

@(negedge clk_in) 

@(negedge clk_in) 

@(negedge clk_in) 

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
					 //$monitor(" =%b ,s1_in =%b s2=%b s3=%b s4=%b ,change_out =%b return_out=%b ,product_out = %b ",clk_in,reset_in,enable_in,s1,s2,s3,s4,change_out,return_out,product_out); 

end
endtask
task endsimulation;
begin
 #200
 $display("-------------- THE SIMUALTION END ------------");
 $finish;
end
endtask
endmodule

