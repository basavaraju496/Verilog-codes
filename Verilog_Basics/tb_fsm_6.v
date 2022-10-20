module tb_fsm_6;
reg clk_in,reset_in,PIR_in;
reg [4:0]PS_in;
wire [3:0]led_out;
wire buzzer_out;

led_sequence DUT(clk_in,reset_in,PIR_in,PS_in,led_out,buzzer_out); 


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
#5 reset_in=1'b1;

 end
endtask
task operation_flow;
integer i;
 begin
PIR_in=1'b0;
PS_in=4'd11;
			for (i=0; i<30; i=i+1)
						begin
							#3 PIR_in=$random; PS_in=$random;
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
$monitor("clk_in = %b reset_in = %b ,PIR_in =%b ,PS_in =%b ,led_out =%b ,buzzer_out = %b ",clk_in,reset_in,PIR_in,PS_in,led_out,buzzer_out); 

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



