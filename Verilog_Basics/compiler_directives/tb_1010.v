module tb_FSM_4;
reg reset_in,enable_in,clk_in,start_in,stop_in;


fsm_4 DUT(reset_in,enable_in,clk_in,start_in,stop_in);



initial
 begin
 main;
 end
task main;
 fork
 clock_gen;
 reset_gen;
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

task reset_gen;

begin
	reset_in=1'b0;
#6 reset_in=1'b1;

 end
endtask
task operation_flow;
//integer i;
 begin

enable_in=1'b0;
start_in=1'b0;	

#25 stop_in=1'b0;


	//	for (i=0; i<5; i=i+1)
					//	begin
						/*	@(posedge clk_in) sequence_in=1'b0;
							@(posedge clk_in) sequence_in=1'b1;
							@(posedge clk_in) sequence_in=1'b0;
							@(posedge clk_in) sequence_in=1'b1;
							@(posedge clk_in) sequence_in=1'b0;
							@(posedge clk_in) sequence_in=1'b1;
							@(posedge clk_in) sequence_in=1'b1;
							@(posedge clk_in) sequence_in=1'b1;
*/

					//	end
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
$monitor($time,"reset=%b enable=%b clk=%b start=%b stop=%b ",reset_in,enable_in,clk_in,start_in,stop_in);
 end
endtask
task endsimulation;
 begin
 #100
 $display("-------------- THE SIMUALTION END ------------");
 $finish;
 end
endtask
    

endmodule
