//`include"tester.v"
`define ENDTIME 250

module tb_checker;
//========================DUT and checker  inputs and DUT outputs========//
// inputs
reg clk;       
reg reset_in;     
reg ncs_in,nrd_in,nwr_in,start_in,a0,a1;        


//outputs
wire [7:0]wire_din;   //   for giving ip to dut  and checker  inout is wire

wire err_design_out,ec_design_out,dir_design_out;   // for dut op

reg [7:0]reg_design_din;       // taking op from dut

wire [7:0] count_design_out;                  // for design op

//======================== checker ops =================//
//
reg [7:0] cout_checker_out;  // for checker op

reg err_checker_out,ec_checker_out,dir_checker_out;   // for checker op

//reg up_flag,down_flag,preload_flag;

integer i;

reg [7:0]PLR,LLR,ULR,CCR;

reg plr_flag,ulr_flag,llr_flag,ccr_flag; // flags to prevent overwrite

reg start_in_flag;    // to start_in cout_checker_outing

integer pulse_counter;

//eg [7:0]temp2;

//=============  assigning values ========================//

assign wire_din =(nwr_in==0 && ncs_in==0 )? reg_design_din:8'bz;  // register values given to wire din

reg [7:0]checker_read;   // store the read result from checker


//--------------------------------module instatiation---------------------//

up_down_counter255_tester DUT(wire_din,clk,ncs_in,nrd_in,nwr_in,start_in,reset_in,a0,a1,count_design_out,err_design_out,ec_design_out,dir_design_out);
//module up_down_counter255_tester (inout [7:0]Din,input clk,ncs,nrd,nwr,start_in,reset,A0,A1 ,output reg [7:0]cout_checker_out,output reg err,ec_checker_out,dir);


//==========================INITIAL VALUES =================================//
initial
	 begin

 		clk = 1'b0;
		pulse_counter=0;
		end
//=============================CALLING MAIN TASK ==================================//
  
initial
	 begin
         $dumpfile("dump.vcd");
       
       $dumpvars();
		 main;  // calling main task at zero simulation time
		 end

//================================= main task definition ===========================// 


task main;
fork               // all task executes at same time

	task_checker;
				//	task_compare_design;

								task_compare_cout_checker_out;
								task_compare_dir;
								task_compare_err;
								task_compare_ec;
	task_stimulus;
	task_clk_generation;
	task_end_simulation;

join
endtask


//~~~~~~~~~~~~~~~~~~~~~~~~``task stimulus ~~~~~~~~~~~~~`//

task task_stimulus;
	begin//{


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//									WRITING		
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~		
		ncs_in=0;
		reset_in=0;
  @(negedge clk) ncs_in=0; reset_in=1;  nwr_in=0;  // nrd=0;
  @(negedge clk) a0=0; a1=0; reset_in=1;  reg_design_din=10; // plr
  @(negedge clk) a0=1; a1=0; reg_design_din=10;    // ulr
  @(negedge clk) a0=0; a1=1; reg_design_din=5;    // llr
  @(negedge clk) a0=1; a1=1; reg_design_din=3;    //ccr    data loaded   reset data af5er writing



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//									READING	
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
/*
  @(negedge clk) ncs_in=0; reset_in=1;  nwr_in=0;   nrd_in=0;
  @(negedge clk) a0=0; a1=0; reset_in=1;  // plr
  @(negedge clk) a0=1; a1=0;    // ulr
  @(negedge clk) a0=0; a1=1;   // llr
  @(negedge clk) a0=1; a1=1;   //ccr    data loaded   reset data af5er writing
*/
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//									START 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	

$display(" start pulse applied ");
@(negedge clk)  start_in=1;   nwr_in=1;              // start pulse given at negedge of clock
  
 @(negedge clk )  start_in=0;  
		
	//	end//}



#79



 //		ncs_in=0;
//		reset_in=0;
  @(negedge clk) ncs_in=0; reset_in=0;  nwr_in=0;  // nrd=0;
  @(negedge clk) a0=0; a1=0; reset_in=1; nwr_in=0; reg_design_din=10; // plr
  @(negedge clk) a0=1; a1=0; reg_design_din=15;    // ulr
  @(negedge clk) a0=0; a1=1; reg_design_din=5;    // llr
  @(negedge clk) a0=1; a1=1; reg_design_din=2;    //ccr    data loaded   reset data af5er writing

$display(" start pulse applied ");
@(negedge clk)  start_in=1;   nwr_in=1;              // start pulse given at negedge of clock
  
 @(negedge clk )  start_in=0;  	
	end//}








endtask

















//========================= task checker ==================// 
task task_checker;
	begin//{
	fork
	 task_ncs;
	 task_reset;
	 task_write;
	 task_read;
	 task_error;
	 task_ec;
	 task_start1;
	 task_start2;

	


	join
		end//}
		endtask
// =============================chip select =================//
//
task task_ncs;
begin
forever@(posedge clk)
begin//{

case(ncs_in)
1'b1:	begin //{    ncs==1 case retain previous
					cout_checker_out=cout_checker_out;
                    PLR=PLR;
                    LLR=LLR;
                    CCR=CCR;
                    ULR=ULR;
                    start_in_flag=start_in_flag;
               //     temp2=temp2;
                    err_checker_out=err_checker_out;
                    dir_checker_out=dir_checker_out;
                    ec_checker_out=ec_checker_out;
                    cout_checker_out=cout_checker_out;
	end//}
	default: begin  // save previous
		//PLR=PLR;
        cout_checker_out=cout_checker_out;
                    PLR=PLR;
                    LLR=LLR;
                    CCR=CCR;
                    ULR=ULR;
                    start_in_flag=start_in_flag;
                 //   temp2=temp2;
                    err_checker_out=err_checker_out;
                    dir_checker_out=dir_checker_out;
                    ec_checker_out=ec_checker_out;
                    cout_checker_out=cout_checker_out;
end
						endcase
					end//} 1st forever end
end
endtask
//=======================RESET BLOCK ======================//
task task_reset;
begin
forever@(posedge clk)
begin//{
					case(reset_in)
						1'b0:
								begin//{
									case(ncs_in)
										1'b0: begin//{
														PLR=1;
														LLR=0;
														CCR=0;
														ULR=8'd255;  
														ec_checker_out=1'b0;  // initiallly zero
														err_checker_out=1'bz;
                                    			        dir_checker_out=1'bz;      
                                    			        start_in_flag=1'bz; 
														pulse_counter=0;
                                    			  //      temp2=8'bz;
														cout_checker_out=8'bz;
														plr_flag=0;
														llr_flag=0;
														ulr_flag=0;
														ccr_flag=0;
												end//}
										default: begin//{
										pulse_counter=pulse_counter;
												end//}
										endcase
									end//}
						default: begin//{  // save 
						pulse_counter=pulse_counter;
									end//}
						endcase
					end//} 1st forever end
end
endtask
task task_write;
begin
// ======================= write =============================//
forever@(posedge clk)
					begin//{
if(a1==0 && a0==0)
		begin
                    PLR= (ncs_in)? (PLR) :(nwr_in)?(PLR): ((plr_flag)? PLR:reg_design_din);			
		end

else if(a1==0 && a0==1)
		begin
                    ULR=(ncs_in)? (ULR) :(nwr_in)?(ULR): ((ulr_flag)? ULR:reg_design_din);			
                 
		end

else if(a1==1 && a0==0)
		begin
                    LLR=(ncs_in)? (LLR) :(nwr_in)?(LLR): ((llr_flag)? LLR:reg_design_din);			
          
		end

else if(a1==1 && a0==1)
		begin
                    CCR=(ncs_in)? (CCR) :(nwr_in)?(CCR): ((ulr_flag)? CCR:reg_design_din);			
               
		end
		else
				begin

                    PLR=PLR;
                    LLR=LLR;
                    CCR=CCR;
                    ULR=ULR;
                    plr_flag=plr_flag;
                    llr_flag=llr_flag;
                    ccr_flag=ccr_flag;
                    ulr_flag=ulr_flag;
					end
					end//}
					end
					endtask

//====================== for reading ===========================//
task task_read;
begin
forever@(posedge clk)
		begin//{
		case({ncs_in,reset_in,nwr_in,nrd_in})
		4'b0110 : begin
		if(a1==0 && a0==0)
		begin
			checker_read=PLR;
		end		
		else if(a1==0 && a0==1)
		begin
			checker_read=ULR;
		end
		else if(a1==1 && a0==0)
		begin
			checker_read=LLR;
		end		
		else if(a1==1 && a0==1)
		begin
			checker_read=CCR;
		end			
		end
		default: begin
		checker_read=8'bz;

		end
		endcase
					end//}

end
endtask



					
//~~~~~~~~~~~~~~~~~~~~~~error block~~~~~~~~~~~~~~~~//					
task task_error;
begin
forever@(posedge clk)
					begin//{

err_checker_out=(PLR<LLR || PLR>ULR)?1:0;

					end//}
					end
endtask


//~~~~~~~~~~~~~~~~~~` start_in block 1 ~~~~~~~~~~~~~~~`//

task task_start1;
begin//{
forever@(posedge clk)
begin

case({start_in,ncs_in,reset_in,err_checker_out})
		4'b1010: begin
                        pulse_counter=pulse_counter+1;  // counts the m=number of pulses
		end
		default :begin pulse_counter=pulse_counter;
		end
endcase

end

end//}
endtask  
//~~~~~~~~~~~~~~~~~~~ start_in block 2 ~~~~~~~~~~//
task task_start2;
begin//{
forever@(negedge start_in)
		begin
case({ncs_in,reset_in,err_checker_out})
4'b010: begin
  if(pulse_counter==1 || pulse_counter==2)
    begin
	dir_checker_out=1;
						task_repeat;    // calling counter task to start counting
end
else
begin
    pulse_counter=0;
    start_in_flag=0;
end
end

default: start_in_flag=start_in_flag;

		endcase
		end

end//}
endtask

task task_repeat;
begin//{
		repeat(CCR)    // to repeat CCR times
						begin//{ 
								repeat(1)   // to get initial value
								begin
                                  @(posedge clk) begin cout_checker_out=PLR; dir_checker_out=(cout_checker_out<ULR)?1:0; end
								end
								repeat(ULR-PLR)  // to count upper limit
									begin
									@(posedge clk) begin	cout_checker_out=cout_checker_out+1; dir_checker_out=(cout_checker_out<ULR)?1:0; end
									end
								repeat(ULR-LLR) // to count upto lower limit
										begin
										@(posedge clk) begin cout_checker_out=cout_checker_out-1;	dir_checker_out=(cout_checker_out>LLR)?0:1; end
										end
								repeat(PLR-LLR) // to count upto preload
										begin 
										@(posedge clk) begin cout_checker_out=cout_checker_out+1; dir_checker_out=(cout_checker_out<PLR)?1:1'BZ; end
										
										end
						
								end//}
task_ec_maker;   //calling ec maker task in order to make the end cycle =1
end//}


endtask

task task_ec_maker;
begin
ec_checker_out=1;
end
endtask
//~~~~~~~~~~~~~~~~~~~~~~~~~~end cycle block ~~~~~~~~~~`//
task task_ec;
begin//{
forever@(negedge clk)
begin//{
if(ec_checker_out==1) begin
//temp2=(ec_checker_out)?0:temp2;
ec_checker_out=0;
start_in_flag=0;
{plr_flag,llr_flag,ulr_flag,ccr_flag}=0;
pulse_counter=0;
dir_checker_out=1'bz;
end

end//}
end//}
endtask










//============================== TASK Compare cout_checker_out ================//
task task_compare_cout_checker_out;
	begin//{
	forever@(negedge clk) begin
		if(cout_checker_out===count_design_out)
		begin//{
		$display("cout_checker_out is correct ");
		end//}
		else
						begin//{
								$display("cout_checker_out is wrong");
						end//}
		
	end//}
	end
endtask


//============================== TASK Compare dir ================//
task task_compare_dir;
	begin//{
	forever@(negedge clk) begin
		if(dir_checker_out===dir_design_out)
		begin
		$display("direction is correct ");
		end
		else
						begin//{
								$display("direction is wrong");
						end//}
		
	end//}
	end//}
endtask


//============================== TASK Compare error ================//
task task_compare_err;
	begin//{
	forever@(negedge clk) begin
		if(err_checker_out===err_design_out)
		begin
		$display("error signal matched  ");
		end
		else
						begin//{
								$display(" error signal not matched");
						end//}
		
	end//}
	end//}
endtask

//============================== TASK Compare end cycle ================//
task task_compare_ec;
	begin//{
	forever@(negedge clk) begin
		if(ec_checker_out===ec_design_out)
		begin
		$display("end cycle is correct ");
		end
		else
						begin//{
								$display("end cycle is wrong");
						end//}
	end//}
		
	end//}
endtask


//============================== TASK Compare design ================//
task task_compare_design;
	begin//{
	forever@(negedge clk) begin
		if((cout_checker_out===count_design_out) && (ec_checker_out===ec_design_out ) && (err_checker_out===err_design_out) && (dir_checker_out===dir_design_out) )
		begin
		$display("cout_checker_outer design working correct ");
		end
		else
						begin//{
								$display("cout_checker_outer design  wrong");
						end//}
		
	end//}
	end//}
endtask





//================================== CLK GENERATION ============//
task task_clk_generation;
	begin
		forever #1 clk=~clk;
	end
endtask
//====================================END SIMULATION ===========//
task task_end_simulation;
	begin
#`ENDTIME $finish;
	end
endtask


endmodule


