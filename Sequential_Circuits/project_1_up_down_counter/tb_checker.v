`include"tester.v"
`define ENDTIME 100

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

reg up_flag,down_flag,preload_flag;

//integer i;

reg [7:0]PLR,LLR,ULR,CCR;

reg plr_flag,ulr_flag,llr_flag,ccr_flag; // flags to prevent overwrite

reg start_in_flag;    // to start_in cout_checker_outing

integer pulse_counter;

reg [7:0]temp2;

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
	//forever@(negedge clk)
	//	begin//{
		// ncs_in=$random; reset_in=$random; nwr_in=$random; nrd_in=$random; reg_din=$random; {a1,a0}=$random;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//									WRITING		
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~		
		ncs_in=0;
		reset_in=0;
  @(negedge clk) ncs_in=0; reset_in=1;  nwr_in=0;  // nrd=0;
  @(negedge clk) a0=0; a1=0; reset_in=1;  reg_design_din=10; // plr
  @(negedge clk) a0=1; a1=0; reg_design_din=15;    // ulr
  @(negedge clk) a0=0; a1=1; reg_design_din=5;    // llr
  @(negedge clk) a0=1; a1=1; reg_design_din=2;    //ccr    data loaded   reset data af5er writing



//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//									READING	
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	

  @(negedge clk) ncs_in=0; reset_in=1;  nwr_in=1;   nrd_in=0;
  @(negedge clk) a0=0; a1=0; reset_in=1;  // plr
  @(negedge clk) a0=1; a1=0;    // ulr
  @(negedge clk) a0=0; a1=1;   // llr
  @(negedge clk) a0=1; a1=1;   //ccr    data loaded   reset data af5er writing

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//									START 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	

$display(" start pulse applied ");
@(negedge clk)  start_in=1;   nwr_in=1;              // start pulse given at negedge of clock
  
 @(negedge clk )  start_in=0;  
		
	//	end//}
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
	// task_counter1;
	// task_counter2;
	// task_counter3;
	// task_ec2;
	 task_new;
	 

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
                    temp2=temp2;
                    err_checker_out=err_checker_out;
                    dir_checker_out=dir_checker_out;
                    ec_checker_out=ec_checker_out;
                    cout_checker_out=cout_checker_out;
	end//}
	default: begin  // save
		PLR=PLR;
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
                                    			        temp2=8'bz;
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


//~~~~~~~~~~~~~~~~~~~~~~~~~~end cycle block ~~~~~~~~~~`//
task task_ec;
begin//{
forever@(negedge clk)
begin//{
ec_checker_out=(ec_checker_out==1)?0:ec_checker_out;
{plr_flag,ulr_flag,llr_flag,ccr_flag}=ec_checker_out? 0 : {plr_flag,ulr_flag,llr_flag,ccr_flag};

end//}
end//}
endtask

//~~~~~~~~~~~~~~~~~~` start_in block 1 ~~~~~~~~~~~~~~~`//

task task_start1;
begin//{
forever@(posedge clk)
begin
//	pulse_counter=(start_in==1 && ncs_in==0 && reset_in==1 &&  err_checker_out==0) ? (pulse_counter+1):pulse_counter;
//	$display("pulse =%0d ",pulse_counter);
//	pulse_counter=(0)? (pulse_counter+1):100; //pulse_counter;

case({start_in,ncs_in,reset_in,err_checker_out})
		4'b1010: begin
pulse_counter=pulse_counter+1;

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
case({pulse_counter,ncs_in,reset_in,err_checker_out})
4'b1010: begin
						ec_checker_out=(CCR==0)?(1'b1):((CCR>0)?(0):(1'bz));
						pulse_counter=(CCR==0)?(0):((CCR>0)? pulse_counter:0);
						start_in_flag=(CCR==0)?(0):((CCR>0)?1:0);
						temp2=(CCR>0)?CCR:0;
						up_flag=(CCR>0)?1:0;
						cout_checker_out=(PLR>1)?(PLR-1):0; 
end

default: start_in_flag=start_in_flag;
		endcase
		end

end//}
endtask

//~~~~~~~~~~~~~~~~~  counter 1 ~~~~~~~~~``````//

/*
task task_counter1;
begin
forever@(posedge clk)
begin
	case({start_in_flag,ncs_in,reset_in,err_checker_out,ec_checker_out})
	5'b10100 : begin
	case(up_flag)
		1'b1:begin 
$display("counter 1");
							cout_checker_out=(cout_checker_out<ULR)? cout_checker_out+1:(cout_checker_out==PLR && cout_checker_out==ULR && cout_checker_out==LLR)? cout_checker_out: cout_checker_out; 
							dir_checker_out=(cout_checker_out<ULR)? 1 : dir_checker_out;
							ec_checker_out=(temp2==0)?1:ec_checker_out;
							temp2=(cout_checker_out<ULR)? temp2 : (cout_checker_out==PLR && cout_checker_out==ULR && cout_checker_out==LLR )?(temp2-1):temp2;
							pulse_counter=(cout_checker_out<ULR)? pulse_counter:(cout_checker_out==PLR && cout_checker_out==ULR && cout_checker_out==LLR )?((temp2==0)? 0 : pulse_counter):pulse_counter;
							down_flag=(cout_checker_out<ULR)? down_flag:(cout_checker_out==PLR && cout_checker_out==ULR && cout_checker_out==LLR )? 0:1;
							up_flag=(cout_checker_out<ULR)? up_flag:(cout_checker_out==PLR && cout_checker_out==ULR && cout_checker_out==LLR )? up_flag :0;
							end
//$display("counter 1");
//$display("************counter 1 else *********");

		default: begin 		cout_checker_out=cout_checker_out; dir_checker_out=dir_checker_out; end
	endcase
end	
	default begin 
							cout_checker_out=cout_checker_out;
							dir_checker_out=dir_checker_out;
	end
	endcase
end
end
endtask

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`down cout_checker_outer ~~~~~~~~~/

task task_counter2;
begin
forever@(posedge clk)
begin
	case({start_in_flag,ncs_in,reset_in,err_checker_out,ec_checker_out})
	5'b10100 : begin
				case(down_flag)
			1'b1:begin 

							cout_checker_out= (cout_checker_out>LLR)? (cout_checker_out-1):cout_checker_out;
							dir_checker_out=(cout_checker_out>LLR)? 0 :dir_checker_out; 
							ec_checker_out=(temp2)? 1:ec_checker_out;
							temp2=(cout_checker_out>LLR)? temp2:(cout_checker_out==PLR && cout_checker_out==LLR && temp2==1 )?8'bz:temp2;
							
//							down_flag=(cout_checker_out==PLR && cout_checker_out==ULR && cout_checker_out==LLR )?0:1;
							down_flag=(cout_checker_out>LLR)? down_flag :(cout_checker_out==PLR && cout_checker_out==LLR && temp2==1 )? 0 :down_flag;
							preload_flag=(cout_checker_out>LLR)? preload_flag : 1 ;
							end
				default: begin cout_checker_out=cout_checker_out; dir_checker_out=dir_checker_out; end
				endcase
				end	
				default :begin 
							cout_checker_out=cout_checker_out;
							dir_checker_out=dir_checker_out;
							end

					/*1'b1:begin

					end


					default: begin 	cout_checker_out=cout_checker_out; dir_checker_out=dir_checker_out;

					end




	endcase
end
end
endtask  

//!~~~~~~~~~~~~~~~~~~~~~~~~~~~up cout_checker_outer 2 ~~~~~~~~~~~~~~//
/*
task task_ec2;
begin//{
forever@(ec_checker_out)
		begin//{
		if(ec_checker_out==1)
			begin//{
			pulse_counter=0;
			temp2=8'bz;
			start_in_flag=0;
			end//}
		else
		begin//{

		end//}
end//}
end//}
endtask*/
//~~~~~~~~~~~~~~~~~~~~
/*
task task_counter3;
begin
forever@(posedge clk)
begin
	case({start_in_flag,ncs_in,reset_in,err_checker_out,ec_checker_out})
	5'b10100 : begin
	case(preload_flag)
		1'b1:begin 

							cout_checker_out=(cout_checker_out<PLR)? (cout_checker_out+1):cout_checker_out;
							dir_checker_out=(cout_checker_out<PLR)? 1 :dir_checker_out; 
							ec_checker_out=(cout_checker_out<PLR)?(cout_checker_out==PLR && temp2==1)? 1 : ec_checker_out : ec_checker_out;
							temp2=(cout_checker_out<PLR)?(cout_checker_out==PLR && temp2==1 )?8'bz:temp2 : (temp2-1);
							//down_flag=(cout_checker_out==PLR && cout_checker_out==ULR && cout_checker_out==LLR )?0:1;
							up_flag=(cout_checker_out<PLR)? up_flag :1;
							preload_flag=(cout_checker_out<PLR)?1:0;
							end
		default: begin cout_checker_out=cout_checker_out; dir_checker_out=dir_checker_out; end
	endcase
end	
	default begin 
							cout_checker_out=cout_checker_out;
							dir_checker_out=dir_checker_out;
	end
	endcase
end
end
endtask
*/
task task_new;
begin
        /*  for(cout_checker_out=PLR; cout_checker_out<ULR; cout_checker_out=cout_checker_out+1)  
			begin
				@(posedge clk) cout_checker_out=cout_checker_out;
			end*/
#20
cout_checker_out=0;
repeat(ULR-PLR) @(posedge clk) begin
		cout_checker_out=cout_checker_out+1;
end

end
endtask












//	end//}
//endtask //  */
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
