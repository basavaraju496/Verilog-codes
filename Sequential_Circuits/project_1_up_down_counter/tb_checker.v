`include"tester.v"
`define ENDTIME 10

module tb_checker;
//========================DUT inputs and outputs========//
// inputs
reg clk;       
reg reset;     
reg ncs,nrd,nwr,start,a0,a1;        


//outputs
wire [7:0]wire_din;   //   for giving ip to dut  and checker

wire err_design_out,ec_design_out,dir_design_out;   // for dut op

reg [7:0]reg_design_din;       // taking op from dut

wire [7:0] count_design_out;                  // for design op

//======================== checker ops =================//
//
reg [7:0] count_out;  // for checker op

reg err_out,ec_out,dir_out;   // for checker op

reg up_flag,down_flag,preload_flag;

integer i;

reg [7:0]PLR,LLR,ULR,CCR;

reg plr_flag,ulr_flag,llr_flag,ccr_flag; // flags to prevent overwrite

reg start_flag;    // to start counting

integer pulse_counter;

reg [7:0]temp2;

//=============  assigning values ========================//

assign wire_din =(nwr==0 && ncs==0 )?reg_design_din:8'bz;  // register values given to wire din


//--------------------------------module instatiation---------------------//

up_down_counter255_tester DUT(wire_din,clk,ncs,nrd,nwr,start,reset,a0,a1,count,err_design_out,ec,dir);


/==========================INITIAL VALUES =================================//
initial
	 begin

 		clk = 1'b0;
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

								task_compare_count;
								task_compare_dir;
								task_compare_err;
								task_compare_ec;
	task_stimulus;
	task_clk_generation;
	task_end_simulation;

join
endtask


//~~~~~~~~~~~~~~~~~~~~~~~~``task stimulus ~~~~~~~~~~~~~`//

task stimulus;
	begin//{
	forever@(negedge clk)
		begin//{
		// ncs=$random; reset=$random; nwr=$random; nrd=$random; reg_din=$random; {a1,a0}=$random;  
		ncs=0; reset=0;
		
		end//}
	end//}
endtask


//========================= task checker ==================// 
task task_checker;
	begin//{
		
forever@(posedge clk)
					begin//{
						case(ncs)
			1'b0:begin//{ ncs==0 case
						case(reset)
						1'b0: begin//{	reset==0			
											PLR=1;
											LLR=0;
											CCR=0;
											ULR=8'd255;  
											ec_out=1'bz;
											err_out=1'bz;
                                            dir_out=1'bz;     
                                            start_flag=1'bz; 
											pulse_counter=0;
                                            temp2=8'bz;
											count_out=8'bz;
											plr_flag=0;
											llr_flag=0;
											ulr_flag=0;
											ccr_flag=0;
											end//} reset==0 end
						1'b1: begin//{
case(nwr)

1'b0: begin //{ nwr==0 case
case({plr_flag,ulr_flag,llr_flag,ccr_flag})
		4'd0:begin
	/*	if(a1==0 && a0==0)		begin PLR=din; plr_flag=1;end 
		else if(a1==0 && a0==1)	begin ULR=din; ulr_flag=1;end
		else if(a1==1 && a0==0)	begin LLR=din; llr_flag=1;end
		else if(a1==1 && a0==1)	begin CCR=din; ccr_flag=1;end
		else begin PLR=PLR; LLR=LLR; CCR=CCR; ULR=ULR;  plr_flag=plr_flag; llr_flag=llr_flag; ccr_flag=ccr_flag; ulr_flag=ulr_flag; end
		end

		4'd1:begin
		if(a1==0 && a0==0)		begin PLR=din; plr_flag=1;end 
		else if(a1==0 && a0==1)	begin ULR=din; ulr_flag=1;end
		else if(a1==1 && a0==0)	begin LLR=din; llr_flag=1;end
		else if(a1==1 && a0==1)	begin CCR=CCR; ccr_flag=1;end
		else begin PLR=PLR; LLR=LLR; CCR=CCR; ULR=ULR;  plr_flag=plr_flag; llr_flag=llr_flag; ccr_flag=ccr_flag; ulr_flag=ulr_flag; end
		end
		
		4'B0010:begin
		if(a1==0 && a0==0)		begin PLR=din; plr_flag=1;end 
		else if(a1==0 && a0==1)	begin ULR=din; ulr_flag=1;end
		else if(a1==1 && a0==0)	begin LLR=din; llr_flag=1;end
		else if(a1==1 && a0==1)	begin CCR=din; ccr_flag=1;end
		else begin PLR=PLR; LLR=LLR; CCR=CCR; ULR=ULR;  plr_flag=plr_flag; llr_flag=llr_flag; ccr_flag=ccr_flag; ulr_flag=ulr_flag; end
		end

		
		
		
		PLR=din; ULR=din; LLR=din; CCR=din;
	*/	
		
		
		
		end



endcase









end//}
1'b1: begin//{ nwr==1 case




end

case(nrd)


1'b0: begin end

1'b1: begin end



end


endcase










end//}
		end//}
		1'b1: // ncs==1 case
		begin //{
					count_out=count_out;
                    PLR=PLR;
                    LLR=LLR;
                    CCR=CCR;
                    ULR=ULR;
                    start_flag=start_flag;
                    temp2=temp2;
                    err_out=err_out;
                    dir_out=dir_out;
                    ec_out=ec_out;
                    count_out=count_out;

		
		
		end//}
						endcase






					end//} 1st forever end


//~~~~~~~~~~~~~~~~~~~~~~error block~~~~~~~~~~~~~~~~//					
forever@(posedge clk)
					begin//{

err_out=(PLR<LLR || PLR>ULR)?1:0;

					end//}
//~~~~~~~~~~~~~~~~~~~~~~~~~~end cycle block ~~~~~~~~~~`//

forever@(posedge clk)
begin
ec_out=(ec_out==1)?0:ec_out;
{plr_flag,ulr_flag,llr_flag,ccr_flag}=(ec_out)?0:
{plr_flag,ulr_flag,llr_flag,ccr_flag};
end

//~~~~~~~~~~~~~~~~~~` start block 1 ~~~~~~~~~~~~~~~`//

forever@(posedge clk)
begin
	pulse_counter=(start==1 && ncs==0 && reset==1 &&  err_out==0)? (pulse_counter+1):pulse_counter;

end
//~~~~~~~~~~~~~~~~~~~ start block 2 ~~~~~~~~~~//
forever@(negedge start)
		begin
case({(pulse_counter,ncs_in,reset_in,err_out})
4'b1010: begin ec_out=(CCR==0)?(1'bz):((CCR>0)?(0):(1'bz));
pulse_counter=(CCR==0)?(0):((CCR>0)? pulse_counter:0);
start_flag=(CCR==0)?(0):((CCR>0)?1:0);
temp2=(CCR>0)?CCR:0;
up_flag=(CCR>0)?1:0;
end

default: start_flag=start_flag;
		endcase
		end
//~~~~~~~~~~~~~~~~~  counter 1 ~~~~~~~~~``````//

forever(posedge clk)
begin
	case({start_flag,ncs,reset,err_out,ec_out})
	5'b10100 : begin
	case(up_flag)
		1'b1:begin 

							count_out=(count_out<ULR)? (count_out+1):count_out;
							dir_out=(count_out<ULR)? 1 : dir_out;
							ec_out=(temp2)?1:ec_out;
							temp2=(count_out==PLR && count_out==ULR && count_out==LLR )?(temp2-1):temp2;
							
							down_flag=(count_out==PLR && count_out==ULR && count_out==LLR )?0:1;
							up_flag=(count_out==PLR && count_out==ULR && count_out==LLR )? up_flag :0;
							end
		default: begin count_out=count_out; dir_out=dir_out; end
	endcase
end	
	default begin 
							count_out=count_out;
							dir_out=dir_out;
	end
	endcase
end

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~`down counter ~~~~~~~~~/

forever(posedge clk)
begin
	case({start_flag,ncs,reset,err_out,ec_out})
	5'b10100 : begin
	case(down_flag)
		1'b1:begin 

							count_out=(count_out>LLR)? (count_out-1):count_out;
							dir_out=(count_out>ULR)? 0 :dir_out; 
							ec_out=(temp2)?1:ec_out;
							temp2=(count_out==PLR && count_out==ULR && count_out==LLR )?(temp2-1):temp2;
							
							down_flag=(count_out==PLR && count_out==ULR && count_out==LLR )?0:1;
							up_flag=(count_out==PLR && count_out==ULR && count_out==LLR )? up_flag :0;
							end
		default: begin count_out=count_out; dir_out=dir_out; end
	endcase
end	
	default begin 
							count_out=count_out;
							dir_out=dir_out;
	end
	endcase
end

//!~~~~~~~~~~~~~~~~~~~~~~~~~~~up counter 2 ~~~~~~~~~~~~~~//


forever(posedge clk)
begin
	case({start_flag,ncs,reset,err_out,ec_out})
	5'b10100 : begin
	case(preload_flag)
		1'b1:begin 

							count_out=(count_out<ULR)? (count_out+1):count_out;
							dir_out=(count_out<ULR)? 1 : 
							ec_out=(temp2)?1:ec_out;
							temp2=(count_out==PLR && count_out==ULR && count_out==LLR )?(temp2-1):temp2;
							
							down_flag=(count_out==PLR && count_out==ULR && count_out==LLR )?0:1;
							up_flag=(count_out==PLR && count_out==ULR && count_out==LLR )? up_flag :0;
							end
		default: begin count_out=count_out; dir_out=dir_out; end
	endcase
end	
	default begin 
							count_out=count_out;
							dir_out=dir_out;
	end
	endcase
end
















	end//}
endtask
//============================== TASK Compare count ================//
task task_compare_count;
	begin//{
		if(count_checker_out==count_design_out)
		begin
		$display("count is correct ");
		else
						begin//{
								$display("count is wrong");
						end//}
		end
	end//}
endtask


//============================== TASK Compare dir ================//
task task_compare_dir;
	begin//{
		if(dir_checker_out==dir_design_out)
		begin
		$display("direction is correct ");
		else
						begin//{
								$display("direction is wrong");
						end//}
		end
	end//}
endtask


//============================== TASK Compare error ================//
task task_compare_err;
	begin//{
		if(err_checker_out==err_design_out)
		begin
		$display("error signal matched  ");
		else
						begin//{
								$display(" error signal not matched");
						end//}
		end
	end//}
endtask

//============================== TASK Compare end cycle ================//
task task_compare_ec;
	begin//{
		if(ec_checker_out==ec_design_out)
		begin
		$display("end cycle is correct ");
		else
						begin//{
								$display("end cycle is wrong");
						end//}
		end
	end//}
endtask


//============================== TASK Compare design ================//
task task_compare_design;
	begin//{
		if((count_checker_out==count_design_out) && (ec_checker_out==ec_design_out ) && (err_checker_out==err_design_out) && (dir_checker_out==dir_design_out) )
		begin
		$display("counter design working correct ");
		else
						begin//{
								$display("counter design  wrong");
						end//}
		end
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
