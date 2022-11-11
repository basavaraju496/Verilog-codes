// Code your testbench here
// or browse Examples
`include "tester.v"

module tb_tester;
reg clk;
reg reset;
reg ncs,nrd,nwr,start,a0,a1;
wire [7:0]wire_din;   // 
wire err,ec,dir;
reg [7:0]reg_din;         
wire [7:0] count;

assign wire_din =(nwr==0 && ncs==0 )?reg_din:8'bz;  // register values given to wire din

up_down_counter255_tester DUT(wire_din,clk,ncs,nrd,nwr,start,reset,a0,a1,count,err,ec,dir);



// ======= Initial Conditions =======================//
initial
	 begin
 		clk = 1'b0;
  //     $dumpfile("dump.vcd"); $dumpvars();
		end

initial
	 begin
		 main;  // calling main task at zero simulation time
	 end

task main;
	 fork
		 clock_gen;
		// operation_flow;
        now_testing;
		 debug_output;
		 endsimulation;
#96 start=1;
#98 start=0;
 	join
endtask


//====================clock generation====================//
task clock_gen;
 		begin
			 forever #1 clk = ~clk; // clock period = 2ns
		 end
endtask
//===================== Generating Test Vectors ==========//

task now_testing;
begin

//@(negedge clk) ncs=1; reset=1;  nwr=0; {a0,a1}=1; nrd=
@(negedge clk) ncs=0; reset=0;  nwr=0;   nrd=0;
  @(negedge clk) a0=0; a1=0; reset=1;  reg_din=10; // plr
  @(negedge clk) a0=1; a1=0; reg_din=15;    // ulr
  @(negedge clk) a0=0; a1=1; reg_din=5;    // llr
  @(negedge clk) a0=1; a1=1; reg_din=2;    //ccr    data loaded   reset data af5er writing


$display(" start pulse applied ");
@(negedge clk)  start=1;   nwr=1;              // start pulse given at negedge of clock
  
 @(negedge clk )  start=0;                  // start pulse duration is one clock cycle

  
//  #10
  
  //@(negedge clk)  start=1;   nwr=1; nrd=0;              // start pulse given at negedge of clock
//@(negedge clk )  start=0; 
  
  
  
end
endtask





task operation_flow;
 begin//{

   //=============RESET OPERATION ========================//




end
endtask
// ========== Debug output========================================//
task debug_output;
	 begin
 		$display("----------------------------------------------");
        $display("------------------     -----------------------");
 		$display("----------- SIMULATION RESULT ----------------");
	    $display("--------------             -------------------");
		$display("----------------         ---------------------");
		$display("----------------------------------------------");
$monitor("TIME = %0d,clk=%b reset = %b, ncs = %b, nwr=%b reg_din=%0d  nrd = %b, start = %d ao=%b a1=%b err=%b ec=%b dir=%b count=%0d",$time,clk,reset,ncs,nwr,reg_din,nrd,start,a0,a1,err,ec,dir,count);
	 end
endtask

//================END SIMULATION ==================================//
task endsimulation;
 begin
#1100
 $display("-------------- THE SIMUALTION END ------------");
 $finish;
 end
endtask
    
endmodule


