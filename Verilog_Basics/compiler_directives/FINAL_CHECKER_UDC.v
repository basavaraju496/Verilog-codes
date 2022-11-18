`include"FINAL_UDC.v"
//`define WIDTH 7
//`define ENDTIME 3000
`define CLK_PERIOD 30.3
`define CYCLES 2000
`timescale 1ns/1ps    // precision==3
module tb_checker_udc;
//========================DUT and checker  inputs and DUT outputs========//
// inputs
reg clk;       
reg reset_in;     
reg ncs_in,nrd_in,nwr_in,start_in,a0,a1;        

//outputs
wire [`WIDTH:0]wire_din;   //   for giving ip to dut  and checker  inout is wire

wire err_design_out,ec_design_out,dir_design_out;   // for dut op

reg [`WIDTH:0]reg_design_din;       // taking op from dut

wire [`WIDTH:0] count_design_out;                  // for design op

//======================== checker ops =================//
//
reg [`WIDTH:0] cout_checker_out;  // for checker op

reg err_checker_out,ec_checker_out,dir_checker_out;   // for checker op


reg [`WIDTH:0]PLR,LLR,ULR,CCR;

reg plr_flag,ulr_flag,llr_flag,ccr_flag; // flags to prevent overwrite


integer pulse_counter;

//=============  assigning values ========================//

assign wire_din =(nwr_in==0 && ncs_in==0 )? reg_design_din:8'bz;  // register values given to wire din

reg [`WIDTH:0]checker_read;   // store the read result from checker


//--------------------------------module instatiation---------------------//

//module up_down_counter255_tester (inout [7:0]Din,input clk,ncs,nrd_in,nwr_in,start_in,reset,A0,A1 ,output reg [7:0]cout_checker_out,output reg err,ec_checker_out,dir);
up_down_counter2556 DUT(wire_din,clk,ncs_in,nrd_in,nwr_in,start_in,reset_in,a0,a1,count_design_out,err_design_out,ec_design_out,dir_design_out);

//module up_down_counter2556 (inout [7:0]Din,input clk,ncs,nrd,nwr,start_in,reset,A0,A1 ,output reg [7:0]cout,output reg err,ec,dir);

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
begin
fork               // all task executes at same time

	task_checker;
				//	task_compare_design;

task_inputs;
//task_random_input;
	task_clk_generation1;
//	task_middle_values;
	task_write_into_file;

join
end
endtask
//===========================clk
//generation===================================//
task task_clk_generation1;
begin

		repeat(2*`CYCLES)
			begin
					#`CLK_PERIOD clk=~clk;
			end

end
endtask


//``````````````````````````````````````````````````````````````````````````````````````````
//                            FILE CREATION for storing ops(2)
//`````````````````````````````````````````````````````````````````````````````````````````
	integer fd_DUT, fd_CHECKER;  // file descriptors
	initial begin
		fd_DUT = $fopen("DUT_UDC_op.txt","w");
		fd_CHECKER = $fopen("CHECKER_UDC_op.txt","w");
	end




	//============= writing memory data to the respectve op files ============//
	task task_write_into_file;
	begin
		forever@(negedge clk) begin
			$fwrite(fd_DUT,"%d\n",count_design_out);
			$fwrite(fd_CHECKER,"%d\n",cout_checker_out);
		end
	end
	endtask



task task_inputs;
begin
	repeat(1)
	begin
		@(posedge clk)
		begin
`ifdef BASIC
			    task_stimulus(5,10,15,2); $display("llr<plr<ulr");
      //  /*wait(ec_checker_out==1 || err_checker_out==1)*/ #120.000	@(negedge clk) task_stimulus(0,0,250,1); //$display("plr=llr=ulr"); 
     

`endif		
          
`ifdef ALLEQUAL
          //===================PLR==LLR==ULR====================//
       /* wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk)*/ task_stimulus(0,0,0,0); $display("plr=llr=ulr"); 
          wait(cout_checker_out===8'dz)	@(negedge clk) task_stimulus(10,10,10,5); $display("plr=llr=ulr"); 
          wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk) task_stimulus(255,255,255,5); $display("plr=llr=ulr"); 
          wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk) task_stimulus(123,123,123,123); $display("plr=llr=ulr");

		  `endif
`ifdef ALLDIFFERENT

          //====================== LLR<PLR<ULR ================//
	/*	wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk)*/ task_stimulus(4,5,7,6); $display("plr<llR<=ulr"); 
	   	wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk) task_stimulus(0,4,6,2); $display("plr<llR<=ulr"); 


	   	wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk) task_stimulus(0,123,255,2); $display("plr<llR<=ulr"); 
	   	wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk) task_stimulus(68,123,255,1); $display("plr<llR<=ulr"); 
	   	wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk) task_stimulus(240,250,255,1); $display("plr<llR<=ulr");
	   	wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk) task_stimulus(123,200,255,1); $display("plr<llR<=ulr");
	   	wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk) task_stimulus(50,100,150,2); $display("plr<llR<=ulr"); 

`endif		
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~PLR==LLR~~~ ULR is more~~~~~~~~~~~~~~~~~~~~~//
`ifdef PLR_LLR
	   /*	wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk)*/ task_stimulus(0,0,5,1); $display("plr==llr ulr is more"); 
	   	wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk) task_stimulus(10,10,255,2); $display("plr==llr ulr is more"); 
	   	wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk) task_stimulus(50,50,100,2); $display("plr==llr ulr is more"); 
	   	wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk) task_stimulus(5,5,50,1); $display("plr==llr ulr is more"); 
	   	wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk) task_stimulus(20,20,25,1); $display("plr==llr ulr is more"); 
	   	wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk) task_stimulus(100,100,255,2); $display("plr==llr ulr is more");
`endif		
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ULR=PLR~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`//
`ifdef ULR_PLR

	   	/*wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk)*/ task_stimulus(1,5,5,2); $display("PLR=ULR "); 
	   	wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk) task_stimulus(1,2,2,2); $display("PLR=ULR "); 
	   	wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk) task_stimulus(10,5,5,5); $display("PLR=ULR ");
	   	wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk) task_stimulus(0,255,255,2); $display("PLR=ULR "); 
	   	wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk) task_stimulus(50,123,123,2); $display("PLR=ULR ");
	   	wait(ec_checker_out==1 || err_checker_out==1)	@(negedge clk) task_stimulus(66,255,255,2); $display("PLR=ULR ");

`endif		
		end
	end
end
endtask

//************************* CHANGE INPUT  *****************************//
//
task task_stimulus;
		input  [7:0]LLR_new,PLR_new,ULR_new,CCR_new;
    //   input  [7:0]PLR_new,ULR_new,LLR_new,CCR_new;

		begin
				//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//									WRITING		LLR<PLR<ULR
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~		
	@(negedge clk)	ncs_in=0; reset_in=0;
	@(negedge clk)  reset_in=1;  nwr_in=1;  
    @(negedge clk) a0=0; a1=0; reset_in=1; nwr_in=0; reg_design_din=PLR_new; // plr
    @(negedge clk) a0=1; a1=0; reg_design_din=ULR_new;    // ulr
    @(negedge clk) a0=0; a1=1; reg_design_din=LLR_new;    // llr
    @(negedge clk) a0=1; a1=1; reg_design_din=CCR_new;    //ccr    data loaded   reset data af5er writing
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//									READING	
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
#5 
  @(negedge clk) ncs_in=0; reset_in=1;  nwr_in=1;   nrd_in=0;
  @(negedge clk) a0=0; a1=0;   // plr
  @(negedge clk) a0=1; a1=0;    // ulr
  @(negedge clk) a0=0; a1=1;   // llr
  @(negedge clk) a0=1; a1=1;   //ccr    data loaded   reset data af5er writing

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//									START 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
$display(" start pulse applied ");
@(negedge clk)  start_in=1;   nwr_in=1; nrd_in=1;             // start pulse given at negedge of clock
@(negedge clk )  start_in=0;  
		end
	endtask


task task_random_input;
begin
    repeat(1) begin
	
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//									WRITING		
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~		
	@(negedge clk)	ncs_in=0; reset_in=0;
    @(negedge clk) ncs_in=0; reset_in=1;  nwr_in=1;  // nrd_in=0;
    @(negedge clk) a0=0; a1=0; reset_in=1; nwr_in=0; reg_design_din=$random; // plr
    @(negedge clk) a0=1; a1=0; reg_design_din=$random;    // ulr
    @(negedge clk) a0=0; a1=1; reg_design_din=$random;   // llr
    @(negedge clk) a0=1; a1=1; reg_design_din=$random;    //ccr    data loaded   reset data af5er writing
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//									READING	
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
#5 
  @(negedge clk) ncs_in=0; reset_in=1;  nwr_in=1;   nrd_in=0;
  @(negedge clk) a0=0; a1=0;   // plr
  @(negedge clk) a0=1; a1=0;    // ulr
  @(negedge clk) a0=0; a1=1;   // llr
  @(negedge clk) a0=1; a1=1;   //ccr    data loaded   reset data af5er writing

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//									START 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
//@(negedge clk) ncs_in=1; 
$display(" start pulse applied ");
@(negedge clk) ncs_in=0; start_in=1;   nwr_in=1; nrd_in=1;             // start pulse given at negedge of clock
@(negedge clk )  start_in=0;  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  
@(negedge clk )  ncs_in=0;
end
end
endtask
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~``
//							Regression
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
task task_middle_values;
begin

`ifdef CNCS
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                      NCS while counting   
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   
    			    task_stimulus(10,15,5,2); $display("llr<plr<ulr");      // calling stimulus task 
wait(cout_checker_out==15) @(negedge clk)ncs_in=1;
//#5
`endif		
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                      WRITING while counting   
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef CWRITE
    			    task_stimulus(10,15,5,2); $display("llr<plr<ulr");
                    wait(cout_checker_out==8)  @(negedge clk) nwr_in=0; {a1,a0}=0;  reg_design_din=100; // plr
					@(negedge clk)  {a1,a0}=1; reg_design_din=150; //ulr
					@(negedge clk)  {a1,a0}=2; reg_design_din=0; // llr
					@(negedge clk)  {a1,a0}=3; reg_design_din=5; //ccr
`endif		
 //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                      READING while counting   
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef CREAD
    			    task_stimulus(10,15,5,2); $display("llr<plr<ulr");
                    wait(cout_checker_out==5)   nrd_in=0; {a1,a0}=1;  // reading plr 
					@(negedge clk)  {a1,a0}=1;  // reading ulr
					@(negedge clk)  {a1,a0}=2;  // reading llr
					@(negedge clk)  {a1,a0}=3;  // reading ccr
`endif		
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                      RESET while counting   
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef CRESET
   			    task_stimulus(10,15,5,2); $display("llr<plr<ulr");
                    wait(cout_checker_out==15)   reset_in=0;
`endif		
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                      START while counting   
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef CSTART
  			    task_stimulus(10,15,5,2); $display("llr<plr<ulr");
                    wait(cout_checker_out==14)  @(negedge clk) start_in=1; reset_in=1;
                      @(negedge clk) start_in=0;
#100
                task_stimulus(10,15,5,2); $display("llr<plr<ulr");
                    wait(cout_checker_out==12)  @(posedge clk) start_in=1;
                     @(posedge clk) start_in=1;
#100
					 
                task_stimulus(10,15,5,2); $display("llr<plr<ulr");
                    wait(cout_checker_out==15)  @(posedge clk) start_in=1;
                      @(posedge clk) start_in=1;
					  @(posedge clk)  start_in=0;
#100
`endif		

  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                      START pulse when END CYCLE == 1    
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef ECS
				task_stimulus(10,15,5,2); $display("llr<plr<ulr");
                    wait(ec_checker_out==1 )  #1 start_in=1;
#2 start_in=0;
#100
`endif		
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                      RESET when END CYCLE == 1    
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef ECRESET
  			    task_stimulus(10,15,5,2); $display("llr<plr<ulr");
                    wait(ec_checker_out==1 || err_checker_out==1)  #1 reset_in=0;
`endif		
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                      READING when END CYCLE == 1    
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef ECREAD
    			    task_stimulus(10,15,5,2); $display("llr<plr<ulr");
                    wait(ec_checker_out==1 || err_checker_out==1)   nrd_in=0; {a1,a0}=1; 

    			    task_stimulus(10,15,5,2); $display("llr<plr<ulr");
                    wait(ec_checker_out==1 || err_checker_out==1)   nrd_in=0; {a1,a0}=2;  

    			    task_stimulus(10,15,5,2); $display("llr<plr<ulr");
                    wait(ec_checker_out==1 || err_checker_out==1)   nrd_in=0; {a1,a0}=3;  
    			    task_stimulus(10,15,5,2); $display("llr<plr<ulr");
                    wait(ec_checker_out==1 || err_checker_out==1)   nrd_in=0; {a1,a0}=0;  

`endif		
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                      WRITING when END CYCLE == 1    
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef ECWRITE
    			    task_stimulus(10,15,5,2); $display("llr<plr<ulr");
                    wait(ec_checker_out==1 || err_checker_out==1)   nwr_in=0; {a1,a0}=1;  reg_design_din=100; //ulr
                   @(negedge clk) {a1,a0}=2;  reg_design_din=10; // llr
                   @(negedge clk)  {a1,a0}=3;  reg_design_din=5; //ccr
                   @(negedge clk)  {a1,a0}=0;  reg_design_din=50; //  plr

`endif		
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                      starting while error 
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
`ifdef ERWRITE
    			    task_stimulus(10,15,5,2); $display("llr<plr<ulr");
                    wait(ec_checker_out==1 || err_checker_out==1)   nwr_in=0; {a1,a0}=1;  reg_design_din=100;
`endif		
end
endtask
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
//						CHECKER TASK
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`
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
														PLR=0;
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
//============================================ WRITE ==========================//
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



					
//===============================ERROR =======================================//					
task task_error;
begin
forever@(posedge clk)
					begin//{

err_checker_out=(PLR<LLR || PLR>ULR)?1:0;
{plr_flag,llr_flag,ccr_flag,ulr_flag}=err_checker_out?0:{plr_flag,llr_flag,ccr_flag,ulr_flag};
					end//}
					end
endtask


//=================================START=================================//

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

		//$display("inside start 3 pulse =%0d",pulse_counter);
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

task task_start2;
begin//{
forever@(negedge start_in)
		begin
case({ncs_in,reset_in,err_checker_out})
4'b010: begin
//$display("inside neg of strat pulse count=%0d",pulse_counter);
  if((pulse_counter==1 || pulse_counter==3 || pulse_counter==2 ))
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
                                  @(posedge clk) begin cout_checker_out=PLR; dir_checker_out=(cout_checker_out<ULR)?1:dir_checker_out; 



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
/*task task_clk_generation;
	begin
		forever #(`CLK_PERIOD/2) clk=~clk;
	end
endtask
//====================================END SIMULATION ===========//
/*task task_end_simulation;
	begin
#`ENDTIME $finish;
	end
endtask*/
  initial begin
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(); 
	end

endmodule






