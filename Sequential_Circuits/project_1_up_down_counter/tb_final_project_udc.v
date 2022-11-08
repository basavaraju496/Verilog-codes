`include "final_project_udc.v"

module tb_final_project_udc;
reg clk;
reg reset;
reg ncs,nrd,nwr,start,a0,a1;
wire [7:0]wire_din;   // 
wire err,ec,dir;
reg [7:0]reg_din;         
wire [7:0] count;

assign wire_din =(nwr==0 && ncs==0 )?reg_din:8'bz;  // register values given to wire din

up_down_counter255 dut(wire_din,clk,ncs,nrd,nwr,start,reset,a0,a1,count,err,ec,dir);



// ======= Initial Conditions =======================//
initial
	 begin
 		clk = 1'b0;
	    	//	$dumpfile("dump.vcd"); $dumpvars;    // for EDA
		end

initial
	 begin
		 main;  // calling main task at zero simulation time
	 end

task main;
	 fork
		 clock_gen;
		 operation_flow;
		 debug_output;
		 endsimulation;
 	join
endtask
//====================clock generation====================//
task clock_gen;
 		begin
			 forever #1 clk = ~clk; // clock period = 2ns
		 end
endtask
//===================== Generating Test Vectors ==========//

task operation_flow;
 begin//{

   //=============RESET OPERATION ========================//

//======================= #0  ===========================//
@(negedge clk) ncs=0; reset=0; 


$display(" start pulse applied ");

@(negedge clk)  start=1;                // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle

//======================== #1 ==============================//
@(negedge clk) ncs=0; reset=1; 

$display(" start pulse applied ");

@(negedge clk)  start=1;                // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle


//======================= #2 ==============================//



@(negedge clk) ncs=1; reset=0; 

$display(" start pulse applied ");

@(negedge clk)  start=1;                // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle

//======================= #3 ==============================//

@(negedge clk) ncs=1; reset=1; 
$display(" start pulse applied ");

@(negedge clk)  start=1;                // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle



//======================= #123.1 ==============================//
//========== #5.1 basic read operation before writing =======================//

$display("basic read operation");

@(negedge clk) a0=0; a1=0; nrd=0; nwr=1;  // plr reading
@(negedge clk) a0=0; a1=1;    // reading ulr
@(negedge clk) a0=1; a1=1;    // reading llr
@(negedge clk) a0=1; a1=0;    // reading clr



//============= #5 basic write operation=======================//

$display("basic write operation");

ncs=0; reset=1; nwr=0;   nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=10; // plr
@(negedge clk) a0=1; a1=0; reg_din=15;    // ulr
@(negedge clk) a0=0; a1=1; reg_din=5;    // llr
@(negedge clk) a0=1; a1=1; reg_din=2;    //ccr    data loaded   reset data after writing


//========== #5.1 basic read operation after writing =======================//

$display("basic read operation");

@(negedge clk) a0=0; a1=0; ncs=0; reset=1; nrd=0; nwr=1;  // plr reading
@(negedge clk) a0=0; a1=1;    // reading ulr
@(negedge clk) a0=1; a1=1;    // reading llr
@(negedge clk) a0=1; a1=0;    // reading clr


//==================== #5.2 basic start ====================//
//================== # basic count starts here====================//

$display(" start pulse applied ");

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle


//====================count ends ==============================//




//============== DATA combinations ===========================//

//~~~~~~~~~~~~~~~~~ #1 PLR=ULR=LLR ~~~~~~~~~~~~~~~~~~~~~~~~//


nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=5; // plr
@(negedge clk) a0=1; a1=0; reg_din=5;    // ulr
@(negedge clk) a0=0; a1=1; reg_din=5;    // llr
@(negedge clk) a0=1; a1=1; reg_din=2;    //ccr reg_din=0;  reg_din=3; reg_din=5;  CHANGE CCR

$display(" start pulse applied ");

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle


//~~~~~~~~~~~~~~~~~ #2 PLR=ULR > LLR  ~~~~~~~~~~~~~~~~~~~~~~~~//


nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=5; // plr
@(negedge clk) a0=1; a1=0; reg_din=5;    // ulr
@(negedge clk) a0=0; a1=1; reg_din=2;    // llr
@(negedge clk) a0=1; a1=1; reg_din=2;    //ccr reg_din=0;  reg_din=3; reg_din=5;  CHANGE CCR

$display(" start pulse applied ");

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle


//~~~~~~~~~~~~~~~~~ #3 PLR=ULR < LLR  ~~~~~~~~~~~~~~~~~~~~~~~~//


nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=5; // plr
@(negedge clk) a0=1; a1=0; reg_din=5;    // ulr
@(negedge clk) a0=0; a1=1; reg_din=7;    // llr
@(negedge clk) a0=1; a1=1; reg_din=2;    //ccr reg_din=0;  reg_din=3; reg_din=5;  CHANGE CCR

$display(" start pulse applied ");

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle



//~~~~~~~~~~~~~~~~~ #4 PLR=LLR > ULR ~~~~~~~~~~~~~~~~~~~~~~~~//


nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=5; // plr
@(negedge clk) a0=1; a1=0; reg_din=2;    // ulr
@(negedge clk) a0=0; a1=1; reg_din=5;    // llr
@(negedge clk) a0=1; a1=1; reg_din=2;    //ccr reg_din=0;  reg_din=3; reg_din=5;  CHANGE CCR

$display(" start pulse applied ");

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle



//~~~~~~~~~~~~~~~~~ #5 PLR=LLR < ULR ~~~~~~~~~~~~~~~~~~~~~~~~//


nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=5; // plr
@(negedge clk) a0=1; a1=0; reg_din=10;    // ulr
@(negedge clk) a0=0; a1=1; reg_din=5;    // llr
@(negedge clk) a0=1; a1=1; reg_din=2;    //ccr reg_din=0;  reg_din=3; reg_din=5;  CHANGE CCR
$display(" start pulse applied ");

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle



//~~~~~~~~~~~~~~~~~ #6 ULR=LLR > PLR ~~~~~~~~~~~~~~~~~~~~~~~~//


nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=2; // plr
@(negedge clk) a0=1; a1=0; reg_din=5;    // ulr
@(negedge clk) a0=0; a1=1; reg_din=5;    // llr
@(negedge clk) a0=1; a1=1; reg_din=2;    //ccr reg_din=0;  reg_din=3; reg_din=5;  CHANGE CCR

$display(" start pulse applied ");

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle


//~~~~~~~~~~~~~~~~~ #7 ULR=LLR <PLR ~~~~~~~~~~~~~~~~~~~~~~~~//


nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=10; // plr
@(negedge clk) a0=1; a1=0; reg_din=5;    // ulr
@(negedge clk) a0=0; a1=1; reg_din=5;    // llr
@(negedge clk) a0=1; a1=1; reg_din=2;    //ccr reg_din=0;  reg_din=3; reg_din=5;  CHANGE CCR

$display(" start pulse applied ");

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle




//~~~~~~~~~~~~~~~~~ #1 PLR<ULR<LLR ~~~~~~~~~~~~~~~~~~~~~~~~//


nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=5; // plr
@(negedge clk) a0=1; a1=0; reg_din=10;    // ulr
@(negedge clk) a0=0; a1=1; reg_din=15;    // llr
@(negedge clk) a0=1; a1=1; reg_din=2;    //ccr reg_din=0;  reg_din=3; reg_din=5;  CHANGE CCR

$display(" start pulse applied ");

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle



//~~~~~~~~~~~~~~~~~ #2 PLR<ULR>LLR ~~~~~~~~~~~~~~~~~~~~~~~~//



nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=5; // plr
@(negedge clk) a0=1; a1=0; reg_din=10;    // ulr
@(negedge clk) a0=0; a1=1; reg_din=2;    // llr
@(negedge clk) a0=1; a1=1; reg_din=2;    //ccr reg_din=0;  reg_din=3; reg_din=5;  CHANGE CCR

$display(" start pulse applied ");

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle


//~~~~~~~~~~~~~~~~~ #3 PLR>ULR<LLR ~~~~~~~~~~~~~~~~~~~~~~~~//


nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=15; // plr
@(negedge clk) a0=1; a1=0; reg_din=10;    // ulr
@(negedge clk) a0=0; a1=1; reg_din=20;    // llr
@(negedge clk) a0=1; a1=1; reg_din=2;    //ccr reg_din=0;  reg_din=3; reg_din=5;  CHANGE CCR

$display(" start pulse applied ");

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle


//~~~~~~~~~~~~~~~~~ #4 PLR>ULR>LLR ~~~~~~~~~~~~~~~~~~~~~~~~//


nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=15; // plr
@(negedge clk) a0=1; a1=0; reg_din=10;    // ulr
@(negedge clk) a0=0; a1=1; reg_din=5;    // llr
@(negedge clk) a0=1; a1=1; reg_din=2;    //ccr reg_din=0;  reg_din=3; reg_din=5;  CHANGE CCR

$display(" start pulse applied ");

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle



//~~~~~~~~~~~~~~~~~~~~~ #8 MIDDLE START ~~~~~~~~~~~~~~~~~~~~~~~~~//


nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=10; // plr
@(negedge clk) a0=1; a1=0; reg_din=15;    // ulr
@(negedge clk) a0=0; a1=1; reg_din=5;    // llr
@(negedge clk) a0=1; a1=1; reg_din=2;    //ccr reg_din=0;  reg_din=3; reg_din=5;  CHANGE CCR

$display(" start pulse applied ");

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle

@(negedge clk)   // counting happening here
@(negedge clk)
@(negedge clk)
@(negedge clk)
@(negedge clk)
@(negedge clk)
@(negedge clk)
@(negedge clk)

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle


//~~~~~~~~~~~~~~~~~~~~~#9 MIDDLE NCS ~~~~~~~~~~~~~~~~~~~~~~~~~//

nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=10; // plr
@(negedge clk) a0=1; a1=0; reg_din=15;    // ulr
@(negedge clk) a0=0; a1=1; reg_din=5;    // llr
@(negedge clk) a0=1; a1=1; reg_din=2;    //ccr reg_din=0;  reg_din=3; reg_din=5;  CHANGE CCR

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle

@(negedge clk)   // counting happening here
@(negedge clk)
@(negedge clk)
@(negedge clk)
@(negedge clk)
@(negedge clk)
@(negedge clk)
@(negedge clk)

@(negedge clk) ncs=1; nwr=1; start=1;   nrd=1;            





@(negedge clk) ncs=1; nwr=0; start=1;   nrd=1;            

//~~~~~~~~~~~~~~~~~~~~~#10 MIDDLE RESET ~~~~~~~~~~~~~~~~~~~~~~~~~//

nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=5; // plr
@(negedge clk) a0=1; a1=0; reg_din=5;    // ulr
@(negedge clk) a0=0; a1=1; reg_din=5;    // llr
@(negedge clk) a0=1; a1=1; reg_din=2;    //ccr reg_din=0;  reg_din=3; reg_din=5;  CHANGE CCR

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle

@(negedge clk)   // counting happening here
@(negedge clk)
@(negedge clk)
@(negedge clk)
@(negedge clk)
@(negedge clk)
@(negedge clk)
@(negedge clk)

//~~~~~~~~~~~~~~~~~~~~~#11 MIDDLE NWR ~~~~~~~~~~~~~~~~~~~~~~~~~//
nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=5; // plr
@(negedge clk) a0=1; a1=0; reg_din=5;    // ulr
@(negedge clk) a0=0; a1=1; reg_din=5;    // llr
@(negedge clk) a0=1; a1=1; reg_din=2;    //ccr reg_din=0;  reg_din=3; reg_din=5;  CHANGE CCR

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle

@(negedge clk)   // counting happening here
@(negedge clk)
@(negedge clk)
@(negedge clk)
@(negedge clk)
@(negedge clk)
@(negedge clk)
@(negedge clk)

@(negedge clk) ncs=1; nwr=0; start=1;   nrd=1;   {a1,a0}=0 reg_din=20;         //plr

@(negedge clk) ncs=1; nwr=0; start=1;   nrd=1;   {a1,a0}=1; reg_din=30;         // ulr
@(negedge clk) ncs=1; nwr=0; start=1;   nrd=1;   {a1,a0}=2; reg_din=15;         // llr
@(negedge clk) ncs=1; nwr=0; start=1;   nrd=1;   {a1,a0}=3; reg_din=2;         //ccr


//~~~~~~~~~~~~~~~~~~~~~#12 MIDDLE NRD ~~~~~~~~~~~~~~~~~~~~~~~~~//

nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=5; // plr
@(negedge clk) a0=1; a1=0; reg_din=5;    // ulr
@(negedge clk) a0=0; a1=1; reg_din=5;    // llr
@(negedge clk) a0=1; a1=1; reg_din=2;    //ccr reg_din=0;  reg_din=3; reg_din=5;  CHANGE CCR

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse given at negedge of clock
@(negedge clk )  start=0;                  // start pulse duration is one clock cycle

@(negedge clk)   // counting happening here
@(negedge clk)
@(negedge clk)
@(negedge clk)
@(negedge clk)
@(negedge clk)
@(negedge clk)
@(negedge clk)
@(negedge clk) ncs=1; nwr=1; start=1;   nrd=0;   {a1,a0}=0;
@(negedge clk) ncs=1; nwr=1; start=1;   nrd=0;   {a1,a0}=1;
@(negedge clk) ncs=1; nwr=1; start=1;   nrd=0;   {a1,a0}=2;
@(negedge clk) ncs=1; nwr=1; start=1;   nrd=0;   {a1,a0}=3;









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
#500
 $display("-------------- THE SIMUALTION END ------------");
 $finish;
 end
endtask
    
endmodule
