`include"up_down_counter.v"
`timescale 10 ns/ 1 ps
// 2. Preprocessor Directives
`define DELAY 1
module tb_project2;
// 4. Parameter definitions
parameter ENDTIME  = 400;
// 5. DUT Input regs
//integer count, count1, a;ñ
reg clk;
reg reset;
reg ncs,nrd,nwr,start,A0,A1;
wire [7:0] count;
reg [7:0]din;
// 6. DUT Output wires
wire err,ec,dir;

// 7. DUT Instantiation
up_down_counter dut(din,clk,ncs,nrd,nwr,start,reset,A0,A1,count,err,ec,dir);

// 8. Initial Conditions
initial
 begin
 clk = 1'b0;
 ncs=0;
 reset = 1'b0;
 end
// 9. Generating Test Vectors
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
 forever #`DELAY clk = !clk;
 end
endtask

task reset_gen;
 begin
 reset = 0;
 # 5
 reset= 1;
 end
endtask
task operation_flow;
 begin


@(negedge clk) din=10; A0=0; A1=0;
 #5
@(negedge clk) din=10; A0=0; A1=0; nwr=0;
@(negedge clk) din=10; A0=0; A1=1; nwr=0;
@(negedge clk) din=15; A0=1; A1=0; nwr=0;
@(negedge clk) din=2; A0=1; A1=1; nwr=0;
@(negedge clk) din=10; A0=0; A1=0; nrd=0; nwr=1;
@(negedge clk) din=10; A0=0; A1=1; nrd=0;
@(negedge clk) din=10; A0=1; A1=0; nrd=0;
@(negedge clk) din=10; A0=1; A1=1; nrd=0;
@(negedge clk) din=10; A0=0; A1=0; start=1; nrd=1;
@(negedge clk) din=10; A0=0; A1=0;
@(negedge clk) din=10; A0=0; A1=0;
@(negedge clk) din=10; A0=0; A1=0;
 end
endtask
// 10. Debug output
task debug_output;
 begin
 $display("----------------------------------------------");
        $display("------------------     -----------------------");
 $display("----------- SIMULATION RESULT ----------------");
 $display("--------------             -------------------");
 $display("----------------         ---------------------");
 $display("----------------------------------------------");
 $monitor("TIME = %d, reset = %b, ncs = %b, nwr=%b nrd = %b, start = %d A0=%b A1=%b err=%b ec=%b dir=%b count=%b",$time,reset,ncs,nwr,nrd,start,A0,A1,err,ec,dir,count);
 end
endtask

//12. Determines the simulation limit
task endsimulation;
 begin
 #ENDTIME
 $display("-------------- THE SIMUALTION END ------------");
 $finish;
 end
endtask
    
endmodule
