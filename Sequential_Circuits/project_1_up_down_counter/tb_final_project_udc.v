`include "final_project_udc.v"

module tb_final_udc;
reg clk;
reg reset;
reg ncs,nrd,nwr,start,a0,a1;
wire [7:0]wire_din;   // 
wire err,ec,dir;
reg [7:0]reg_din;         
wire [7:0] count;
assign wire_din =(nwr==0 && ncs==0 )?reg_din:8'bz;
up_down_counter255 dut(wire_din,clk,ncs,nrd,nwr,start,reset,a0,a1,count,err,ec,dir);
integer i,j,k,l;
// 8. Initial Conditions
initial
	 begin
 		clk = 1'b0;
	    		
		end

	// 9. Generating Test Vectors
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
			 forever #1 clk = ~clk; // clock period = 2ns
		 end
endtask


task operation_flow;
 begin//{

$display("ncs reset nwr nrd cases");
/*
for (i =0 ;i<16 ;i=i+1 ) begin//{
	@(negedge clk) {ncs,reset,nwr,nrd}=i; 
			if(nwr==0)
			begin//{
				for ( j=0 ; j<4 ; j=j+1 ) begin//{
					@(negedge clk) {a1,a0}=j; reg_din=$random%10;   
					if(j==3) begin//{
						@(negedge clk)start=1;
						@(negedge clk) start=0;
						end//}
						else
						begin//{
						start=0;
						end//}
				end//}
			end//}
			else if(nrd==0)
		begin//{
				for ( l=0 ; l<4 ; l=l+1 ) begin//{
					@(negedge clk) {a1,a0}=l;    
					if(l==3) begin//{
						@(negedge clk)start=1;
						@(negedge clk) start=0;
						end//}
						else
						begin//{
						start=0;
						end//}


				end//}
				end//}
				end//}
				
				$display("start pulse test");

*/	


//write operation
nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=10;   // plr
@(negedge clk) a0=1; a1=0; reg_din=15;   // ulr
@(negedge clk) a0=0; a1=1; reg_din=10;    // llr
@(negedge clk) a0=1; a1=1; reg_din=2;    //ccr    data loaded
// read opeartion

@(negedge clk) a0=0; a1=0; nrd=0; nwr=1;  // plr reading
@(negedge clk) a0=0; a1=1;    // reading ulr
@(negedge clk) a0=1; a1=1;    // reading llr
@(negedge clk) a0=1; a1=0;    // reading clr

//plr<ulr and plr> llr

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse
@(negedge clk )  start=0;                  


//PLR=ULR=LLR


nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=5;

   // plr
@(negedge clk) a0=1; a1=0; reg_din=5;   // ulr
@(negedge clk) a0=0; a1=1; reg_din=5;    // llr
@(negedge clk) a0=1; a1=1; reg_din=5;    //ccr    data loaded


@(negedge clk) a0=0; a1=0; nrd=0; nwr=1;  // plr reading
@(negedge clk) a0=0; a1=1;    // reading ulr
@(negedge clk) a0=1; a1=1;    // reading llr
@(negedge clk) a0=1; a1=0;    // reading clr



@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse

@(negedge clk )  start=0;                  



//  plr>ulr && plr>llr.

nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=100;   // plr
@(negedge clk) a0=1; a1=0; reg_din=50;   // ulr
@(negedge clk) a0=0; a1=1; reg_din=20;    // llr
@(negedge clk) a0=1; a1=1; reg_din=1;    //ccr    data loaded

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse

@(negedge clk )  start=0;                  

//  plr<ulr&&plr<llr.

nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=10;   // plr
@(negedge clk) a0=1; a1=0; reg_din=20;   // ulr
@(negedge clk) a0=0; a1=1; reg_din=25;    // llr
@(negedge clk) a0=1; a1=1; reg_din=1;    //ccr    data loaded

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse

@(negedge clk )  start=0;                  

// plr=ulr&&plr>llr 

nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=10;   // plr
@(negedge clk) a0=1; a1=0; reg_din=10;   // ulr
@(negedge clk) a0=0; a1=1; reg_din=5;    // llr
@(negedge clk) a0=1; a1=1; reg_din=1;    //ccr    data loaded

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse

@(negedge clk )  start=0;           

//plr<ulr&&plr=llr

nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=10;   // plr
@(negedge clk) a0=1; a1=0; reg_din=15;   // ulr
@(negedge clk) a0=0; a1=1; reg_din=10;    // llr
@(negedge clk) a0=1; a1=1; reg_din=1;    //ccr    data loaded

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse

@(negedge clk )  start=0;                  

// plr<ulr&&llr>ulr

nwr=0; reset=1; ncs=0; nrd=1;
@(negedge clk) a0=0; a1=0; reg_din=10;   // plr
@(negedge clk) a0=1; a1=0; reg_din=15;   // ulr
@(negedge clk) a0=0; a1=1; reg_din=20;    // llr
@(negedge clk) a0=1; a1=1; reg_din=1;    //ccr    data loaded

@(negedge clk) nwr=1; start=1;   nrd=1;             // start pulse

@(negedge clk )  start=0;                  








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
	//	if(clk==1) begin
$monitor("TIME = %0d,clk=%b reset = %b, ncs = %b, nwr=%b reg_din=%0d  nrd = %b, start = %d ao=%b a1=%b err=%b ec=%b dir=%b count=%0d",$time,clk,reset,ncs,nwr,reg_din,nrd,start,a0,a1,err,ec,dir,count);
	 end
	// end
endtask

//12.END SIMULATION
task endsimulation;
 begin
 
#500
 $display("-------------- THE SIMUALTION END ------------");
 $finish;
 end
endtask
    
endmodule



