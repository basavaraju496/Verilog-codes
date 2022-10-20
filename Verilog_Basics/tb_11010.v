module tb_11010;
reg clk_in,reset_in,sequence_in;
wire detector_out;

Sequence_Detector_11010_MOORE_Verilog DUT(clk_in,reset_in,sequence_in,detector_out); 


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
 forever #3 clk_in = ~clk_in;
 end
endtask

task reset_gen;

begin
	reset_in=1'b0;
#5 reset_in=1'b1;

 end
endtask
task operation_flow;
integer i;
 begin
 sequence_in=1'b1;
			for (i=0; i<30; i=i+1)
						begin
							#6 sequence_in=$random;
						end
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
$monitor("clk=%b reset=%b sequence_in=%b detected_output=%b ",clk_in,reset_in,sequence_in,detector_out); 

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
