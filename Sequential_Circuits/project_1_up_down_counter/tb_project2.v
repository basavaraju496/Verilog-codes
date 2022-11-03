`include"project2.v"





module tb_project2;




// 5. DUT Input regs
reg clk;
reg reset;
reg ncs,nrd,nwr,start,A0,A1;
wire [7:0]wire_din;   // 

// 6. DUT Output wires
wire err,ec,dir;
reg [7:0]reg_din;         
wire [7:0] count;
//assign wire_din=din;
// 7. DUT Instantiation
assign wire_din =(nwr==0)?reg_din:8'bz;
up_down_counter dut(wire_din,clk,ncs,nrd,nwr,start,reset,A0,A1,count,err,ec,dir);

// 8. Initial Conditions
initial
	 begin
 		clk = 1'b0;
	    ncs=0;
		reset = 1'b0;
	#3 reset=1;
	end

	// 9. Generating Test Vectors
initial
	 begin
		 main;
	 end
task main;
	 fork
		 clock_gen;
		 //reset_gen;
		 operation_flow;
		 debug_output;
		 endsimulation;
 	join
endtask
task clock_gen;
 		begin
			 forever #1 clk = ~clk;
		 end
endtask
/*task reset_gen;
 begin
 reset = 0;
 # 5
 reset= 1;
 end
endtask
*/

task operation_flow;
 begin

$display("******RESET AND WRITING DATA******");
@(negedge clk) reg_din=100; A1=0; A0=0;   nwr=0;           // plr=10
@(negedge clk) reg_din=8'd20; A1=0; A0=0; nwr=0;   //plr=10
@(negedge clk) reg_din=8'd15; A1=0; A0=1; nwr=0;   // ulr=15
@(negedge clk) reg_din=8'd5; A1=1; A0=0; nwr=0;   // llr=5
@(negedge clk) reg_din=8'd2; A1=1; A0=1; nwr=0;   // ccr= 2


$display("******RANDOM ***********");
@(negedge clk) A1=0; A0=0; nrd=1;  nwr=1;
@(negedge clk) A1=0; A0=0; nrd=1;  nwr=0;


$display("******READING DATA******");
@(negedge clk) A1=0; A0=0; nrd=0;  nwr=1;
@(negedge clk)  A1=0; A0=1; nrd=0;  nwr=1;
@(negedge clk)  A1=1; A0=0; nrd=0; nwr=1;
@(negedge clk)  A1=0; A0=0; nrd=0; nwr=1;

@(negedge clk) A1=0; A0=0; nrd=0;  nwr=1;
@(negedge clk) A1=0; A0=0; nrd=0;  nwr=1;

@(negedge clk) A1=0; A0=0; nrd=1;  nwr=1;
//@(negedge clk) A0=0; A1=0; nrd=1;  nwr=1;

/*
@(negedge clk) reg_din=8'd10; A0=0; A1=0; nwr=0;  // writing into PLR 
@(negedge clk) reg_din=8'd0; A0=0; A1=1; nwr=0;   // writing into ulr
@(negedge clk) reg_din=8'd2; A0=1; A1=0; nwr=0;    // WRITING INTO llR
@(negedge clk) reg_din=8'd2; A0=1; A1=1; nwr=0;    // writing into ccr
$display("ERROR SIGNAL CHECKING");

*/
@(negedge clk)nrd=1; nwr=1; ncs=0;  


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
$monitor("TIME = %0d, reset = %b, ncs = %b, nwr=%b reg_din=%0d  nrd = %b, start = %d A0=%b A1=%b err=%b ec=%b dir=%b count=%b",$time,reset,ncs,nwr,reg_din,nrd,start,A0,A1,err,ec,dir,count);
	 end
endtask

//12.END SIMULATION
task endsimulation;
 begin
 
#100
 $display("-------------- THE SIMUALTION END ------------");
 $finish;
 end
endtask
    
endmodule
