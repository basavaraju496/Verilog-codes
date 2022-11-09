// Code your design here
module up_down_counter255 (inout [7:0]Din,input clk_in,ncs_in,nrd_in,nwr_in,start_in,reset_in,A0,A1 ,output reg [7:0]count_out,output reg err_out,ec_out,dir_out);
reg start_flag; // start flag is raised whenever start pulse comes 
reg [7:0]reg_out;  // storing din out value in reg
// for storing input 


reg [7:0]temp2;

integer pulse_counter=0;

assign Din=(ncs_in==0 && nrd_in==0 && nwr_in==1)? reg_out:8'bz;  // whenever value in din out changes the it iis assigned to din 
//  inout port must be wire so we are unable to use in procedural blocks(while
//  reading) taken a register as reg_out values will be taken to it{while
//  reading}| and
//  assigned to wire Din	using assign keyword***************///

reg [7:0]PLR,ULR,CCR,LLR;
// registers for storing values required for counter
// ===>PLR = stores  count start value 
// ======>ULR = stores upperlimit of count
// ========>LLR = stores lower limit of count
//==>CCR= number of times to count
// reg [9:0]temp,no_of_PLRs;
// temp is used to calculate the no of PLRs came in counting sequence

reg up_flag,down_flag,preload_flag;
// these flags will control flow of count

always@(posedge clk_in)
		begin //{
			if(ncs_in==0)
					begin //{ chip select on
						if(reset_in==0)
										begin //{   // reset==0
											PLR=0;
											LLR=0;
											CCR=0;
											ULR=8'd255;  
											ec_out=1'bz;
											err_out=1'bz;
                                            dir_out=1'bz;    /// doubt  
                                            start_flag=1'bz; 
											pulse_counter=0;
                                            temp2=8'bz;
											count_out=8'bz;

						   				 end //} reset==0 end
						else  // reset ==1 case
											begin //{
																	if(nwr_in==0)
																		begin //{ // writing start
                                                                      //   $display("data is writing plr=%0d ulr=%0d llr=%0d ccr=%0d",PLR,ULR,LLR,CCR);
																	//	err_out=0;
																		case({A1,A0})
                                  					     				2'b00: begin PLR=Din; end
					                                       				2'b01: begin ULR=Din;end
                    							                   		2'b10: begin LLR=Din;end
                    		                   							2'b11: begin CCR=Din;end
																		 default : begin   		PLR=PLR; LLR=LLR; CCR=CCR; ULR=ULR;   		 end
																		endcase
																	end //} writing end
															else if(nrd_in==0)
																	begin//{
																		case({A1,A0})
        		                               							2'b00: begin reg_out=PLR;end
                		                       							2'b01: begin reg_out=ULR;end
                                		       							2'b10: begin reg_out=LLR;end
                        		               							2'b11: begin reg_out=CCR;end
																		default : begin   		reg_out=8'bz;   		 end
																		endcase
																	end//}
															else
																begin  //{
                                                                    					count_out=count_out;
    
												  				  end//} */
											
															end//}
															
				end//} ncs =0 end
				else
					begin//{
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
	   end//} always end
//===========================================ERROR SIGNAL GENERATION========================//
always@(posedge clk_in)
		begin//{
		if(PLR<LLR || PLR>ULR)
			begin//{
				err_out=1;
			end//}
			else
				begin//{
				err_out=0; 
				end//}
		end//}
	
			
//====================== START FLAG ==============================//
always@(negedge start_in)
		begin//{
		if(pulse_counter==1 && ncs_in==0 && reset_in==1 && nwr_in!==0 && nrd_in!==0 && err_out==0) // starts only when one pulse is obtained and ncs=0 reset =1 ,.....
		begin//{
				if(CCR==0)         // storing CCR values to temporary register
					begin				
					ec_out=1; 
					pulse_counter=0;
					end
					else
					begin
					temp2=CCR; ec_out=0; 
				start_flag=1;
				dir_out=1;         // default direction is up ???? doubt 
				up_flag=1;         // default direction is up counting
				count_out=PLR-1;   // loaded with plr-1 but show count from PLR
					end
		end//}
		else 
						begin//{    
							start_flag<=0;  // pulse count>1 || ncs=1 || reset=0 || nwr=0 || nrd=0 || err=1 endcycle=0    
						end//}

		end//}
always@(posedge clk_in)
		begin//{
		 if(start_in==1 && ncs_in==0 && nwr_in!==0 && reset_in==1 && nrd_in!==0 && err_out==0)
				begin//{
					pulse_counter=pulse_counter+1;   // counting start pulses
				end//}
				else
					begin//{
						pulse_counter=pulse_counter;   
	
					end//}
		end//}
///==================================================================//
/* always@(negedge clk_in)
		begin//{
				if(temp2==0 && ncs_in==0 && nwr_in!==0 && reset_in==1 && nrd_in!==0 && err_out==0 && ec_out==0)
					begin
					//	ec_out=1;
						start_flag=0;
						count_out=count_out;
						temp2=8'bz;
				end
				else
					begin
						ec_out=0;
					end
		end//}*/

// ===========================COUNTER BLOCK====================//
//----------------UP COUNTING 1------------------------------//
always @(posedge clk_in )
		begin//{
			if(start_flag==1 && ncs_in==0 && nwr_in!==0 && reset_in==1 && nrd_in!==0 && err_out==0 && ec_out==0)
				begin//{
					if(up_flag==1)
							begin//{
								if(count_out<ULR) 
									begin//{
										count_out=count_out+1; dir_out=1;   
									end//}	
								else // count ==ulr
									begin//{
										if(count_out==PLR && count_out==ULR && count_out==LLR )
											begin//{
											 temp2=temp2-1;
											if(temp2==1) 
                                                begin
											        ec_out=1;
													pulse_counter=0;

											start_flag=0;
											count_out=count_out;
											temp2=8'bz;
                                            	end
                                                else
                                                begin
                                                    ec_out=ec_out;
                                                end
											end//}
											else
                                                 begin
											        down_flag=1; up_flag=0; 
                                                end
					    				end//}
end//}
					else
							begin//{
									count_out=count_out; dir_out=dir_out;

								end//}
end//}
else
begin
		count_out=count_out; dir_out=dir_out;
end
end//}

//============================DOWN COUNTING================================//
always@(posedge clk_in)		
		begin//{
if(start_flag==1 && ncs_in==0 && nwr_in!==0 && reset_in==1 && nrd_in!==0 && err_out==0 && ec_out==0)		begin//{
				 	 if(down_flag==1)
							begin//{
								 if(count_out>LLR)
								begin//{
									count_out=count_out-1; dir_out=0;// end

									if((count_out==PLR && count_out==LLR) && temp2==1)	
									    begin
										    ec_out=1;
											pulse_counter=0;

						start_flag=0;
						count_out=count_out;
						temp2=8'bz;
										end

									end//}	
								else 
								begin//{
									preload_flag=1; down_flag=0; 
								end//}
	
							
						end//}

				    	

					else
							begin//{
									count_out=count_out; dir_out=dir_out;

							end//}
							end//}

else
begin
		count_out=count_out; dir_out=dir_out;
end

end//}

//==============================END CYCLE============================//
	always@(posedge clk_in)
	begin	
		if(ec_out==1) begin
				ec_out<=0; end
				else begin
				ec_out<=ec_out;
                end
end
// ===============================UP COUNTING UPTO PLR===================//
always@(posedge clk_in)
begin//{
if(start_flag==1 && ncs_in==0 && nwr_in!==0 && reset_in==1 && nrd_in!==0 && err_out==0 && ec_out==0)		begin//{
					 if(preload_flag==1)
							begin//{
								if(count_out<PLR)
									begin//{
										count_out=count_out+1; dir_out=1;
										if(count_out==PLR && temp2==1)
											begin
												ec_out=1;
												pulse_counter=0;

						start_flag=0;
						count_out=count_out;
						temp2=8'bz;
											end
                                            else
                                            begin
                                                ec_out=ec_out;
                                            end
									end//}
									else 
									begin//{	
										temp2=temp2-1; up_flag=1; preload_flag=0;
										
										
									end//}
							
								end//}		
					else
							begin//{
									count_out=count_out; dir_out=dir_out;

							end//}
							end//}

					else
						begin
						count_out=count_out; dir_out=dir_out;
						end

					
					
		end//}
///////////======================== THE END  =======================//





    endmodule
