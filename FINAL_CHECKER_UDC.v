`include"FINAL_UDC.v"
`define ENDTIME 2000

module tb_checker_udc;
//========================DUT and checker  inputs and DUT outputs========//
// inputs
reg clk;       
reg reset_in;     
reg ncs_in,nrd_in,nwr_in,start_in,a0,a1;        

reg [7:0]temp2;
//outputs
wire [7:0]wire_din;   //   for giving ip to dut  and checker  inout is wire

wire err_design_out,ec_design_out,dir_design_out;   // for dut op

reg [7:0]reg_design_din;       // taking op from dut

wire [7:0] count_design_out;                  // for design op

//======================== checker ops =================//
//
reg [7:0] cout_checker_out;  // for checker op

reg err_checker_out,ec_checker_out,dir_checker_out;   // for checker op

integer i;

reg [7:0]PLR,LLR,ULR,CCR;

reg plr_flag,ulr_flag,llr_flag,ccr_flag; // flags to prevent overwrite

//reg start_in_flag;    // to start_in cout_checker_outing

integer pulse_counter;

//=============  assigning values ========================//

assign wire_din =(nwr_in==0 && ncs_in==0 )? reg_design_din:8'bz;  // register values given to wire din

reg [7:0]checker_read;   // store the read result from checker


//--------------------------------module instatiation---------------------//

up_down_counter255_tester DUT(wire_din,clk,ncs_in,nrd_in,nwr_in,start_in,reset_in,a0,a1,count_design_out,err_design_out,ec_design_out,dir_design_out);
//module up_down_counter255_tester (inout [7:0]Din,input clk,ncs,nrd_in,nwr_in,start_in,reset,A0,A1 ,output reg [7:0]cout_checker_out,output reg err,ec_checker_out,dir);


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
	task_clk_generation;
	task_end_simulation;
task_random_input;
join
endtask





task task_random_input;
begin
    repeat(1) begin
	
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//									WRITING		
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~		
	@(negedge clk)	ncs_in=0; reset_in=0;
    @(negedge clk) ncs_in=0; reset_in=1;  nwr_in=1;  // nrd_in=0;
    @(negedge clk) a0=0; a1=0; reset_in=1; nwr_in=0; reg_design_din=1; // plr
    @(negedge clk) a0=1; a1=0; reg_design_din=2;    // ulr
    @(negedge clk) a0=0; a1=1; reg_design_din=0;    // llr
    @(negedge clk) a0=1; a1=1; reg_design_din=2;    //ccr    data loaded   reset data af5er writing
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//									READING	
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
#5 
  @(negedge clk) ncs_in=0; reset_in=1;  nwr_in=1;   nrd_in=0;
  @(negedge clk) a0=0; a1=0;   // plr
  @(negedge clk) a0=1; a1=0;    // ulr
  @(negedge clk) a0=0; a1=1;   // llr
  @(negedge clk) a0=1; a1=1;   //ccr    data loaded   reset data af5er writing
//@(negedge clk) reset_in=0;
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//									START 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
//@(negedge clk) ncs_in=1; 
$display(" start pulse applied ");
@(negedge clk) ncs_in=0; start_in=1;   nwr_in=1; nrd_in=1;             // start pulse given at negedge of clock
@(negedge clk )  start_in=0;  
@(negedge clk )  //start_in=1;

@(negedge clk )  //start_in=0;
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk ) // nwr_in=0;  {a1,a0}=1; reg_design_din=100;
@(negedge clk ) // nrd_in=0;  nwr_in=1;
@(negedge clk )  
@(negedge clk ) //reset_in=0; 
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  //start_in=1;
@(negedge clk ) // start_in=0;
@(negedge clk )  

@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  //start_in=1;
@(negedge clk ) // start_in=0;
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk ) ncs_in=0; 

//#71	start_in=1;
//#2 start_in=0;
//wait(ec_checker_out==1) #1 start_in=1;
//#2 start_in=0;
end
end
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
	 task_start3;
//task_flag_modifier;
	join
		end//}
		endtask
// =============================chip select =================//

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
                    err_checker_out=err_checker_out;
                    dir_checker_out=dir_checker_out;
                    ec_checker_out=ec_checker_out;
                    cout_checker_out=cout_checker_out;
	end//}
	default: begin  // save previous
        cout_checker_out=cout_checker_out;
                    PLR=PLR;
                    LLR=LLR;
                    CCR=CCR;
                    ULR=ULR;
					pulse_counter=pulse_counter;
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
														err_checker_out=1'b0;
                                    			        dir_checker_out=1'bz;      
														pulse_counter=0;
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
begin//{
forever@(posedge clk) begin//{

case({ncs_in,reset_in,nwr_in})

3'b010:begin
if(a1==0 && a0==0)
		begin
{plr_flag,PLR}=(plr_flag)? {plr_flag,PLR} : {1'b1,reg_design_din} ; 
		
		end



else if(a1==0 && a0==1)
		begin
{ulr_flag,ULR}=(ulr_flag)? {ulr_flag,ULR} : {1'b1,reg_design_din} ; 

end

else if(a1==1 && a0==0)
		begin
{llr_flag,LLR}=(llr_flag)? {llr_flag,LLR} : {1'b1,reg_design_din} ; 

end
else if(a1==1 && a0==1)
		begin
{ccr_flag,CCR}=(ccr_flag)? {ccr_flag,CCR} : {1'b1,reg_design_din} ; 
end
end
default: begin end

endcase



end//}
end//}
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
{plr_flag,llr_flag,ccr_flag,ulr_flag}=err_checker_out?0:{plr_flag,llr_flag,ccr_flag,ulr_flag};
					end//}
					end
endtask


//~~~~~~~~~~~~~~~~~~` start_in block 1 ~~~~~~~~~~~~~~~`//

task task_start1;
begin//{
forever@(posedge clk)
begin//{

		case({ncs_in,reset_in,err_checker_out})
		4'b010: begin
						if(start_in==1)
		begin
                        pulse_counter=pulse_counter+1;  // counts the m=number of pulses
		end
		end
		default:begin pulse_counter=pulse_counter;	end
			endcase

end//}
end//}
endtask


task task_start3;
begin//{
forever@(negedge clk)
begin//{

case({ncs_in,reset_in,err_checker_out})
		4'b010: begin

						if(start_in==1) begin
                        pulse_counter=pulse_counter+1;  // counts the m=number of pulses
						end
		end
		default :begin pulse_counter=pulse_counter;
		end
endcase

end//}
end
endtask  
//~~~~~~~~~~~~~~~~~~~ start_in block 2 ~~~~~~~~~~//
task task_start2;
begin//{
forever@(negedge start_in)
		begin
case({ncs_in,reset_in,err_checker_out})
4'b010: begin
$display("inside neg of strat pulse count=%0d",pulse_counter);
  if((pulse_counter==1 || pulse_counter==2 ))
    begin
	if(CCR==0)
begin			
					{plr_flag,ulr_flag,llr_flag,ccr_flag}=0;  // WE CAN WRITE NEW DATA AFTER ENDCYCLE 

end
else
begin
	dir_checker_out=1;
						task_repeat;    // calling counter task to start counting
								if(ncs_in==0  && reset_in==1 &&  err_checker_out==0 && ec_checker_out==0)
						
						task_ec_maker;	// task_ec;						
	end						
end
else
begin
    pulse_counter=0;
end
end

default: begin end

		endcase
		end

end//}
endtask

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~EC MAKER ~~~~~~~~~~~~~~~~~~~~`//
task task_ec_maker;
begin
if(ULR==PLR && PLR==LLR) begin
		 ec_checker_out=1; task_ec; end
		else begin
		ec_checker_out=1;
		task_ec;
end
end
endtask
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~COUNTER ~~~~~~~~~~~~~~~~~~~~~~~``//

task task_repeat;
begin//{
		repeat(CCR)    // to repeat CCR times
						begin//{ 
						
						case({ncs_in,reset_in,err_checker_out,ec_checker_out}) 4'b0100: begin//{
							repeat(1)   // to get initial value
								begin
								if(ncs_in==0  && reset_in==1 &&  err_checker_out==0 && ec_checker_out==0)
                                  @(posedge clk) begin cout_checker_out=PLR; dir_checker_out=(cout_checker_out<ULR)?1:0; 



end							//	end
end
								repeat(ULR-PLR)  // to count upper limit
									begin
								if(ncs_in==0  && reset_in==1 &&  err_checker_out==0 && ec_checker_out==0)

									begin
									@(posedge clk) begin	cout_checker_out=cout_checker_out+1; dir_checker_out=(cout_checker_out<ULR)?1:0; end
									
									end
									end
								repeat(ULR-LLR) // to count upto lower limit
										begin
								if(ncs_in==0  && reset_in==1 &&  err_checker_out==0 && ec_checker_out==0)
begin
										
										@(posedge clk) begin cout_checker_out=cout_checker_out-1;	dir_checker_out=(cout_checker_out>LLR)?0:1; end end
										end
								repeat(PLR-LLR) // to count upto preload
										begin 
								if(ncs_in==0  && reset_in==1 &&  err_checker_out==0 && ec_checker_out==0)
begin
										
										@(posedge clk) begin cout_checker_out=cout_checker_out+1; dir_checker_out=(cout_checker_out<PLR)?1:1'BZ; end end
										
										end
										
								end//}
								default: begin end
								endcase
								end//}
								
end//}


endtask

//~~~~~~~~~~~~~~~~~~~~~~~~~~end cycle block ~~~~~~~~~~`//
task task_ec;
begin//{
repeat(1)
begin//{
if(ec_checker_out==1) begin
{plr_flag,llr_flag,ulr_flag,ccr_flag}=0;
pulse_counter=0;

dir_checker_out=1'bz;

@(posedge clk) ec_checker_out=0;

end

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




