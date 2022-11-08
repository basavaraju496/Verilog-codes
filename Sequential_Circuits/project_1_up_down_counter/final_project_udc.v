module up_down_counter255 (inout [7:0]Din,input clk_in,ncs_in,nrd_in,nwr_in,start_in,reset_in,A0,A1 ,output reg [7:0]count_out,output reg err_out,ec_out,dir_out);
reg start_flag; // start flag is raised whenever start pulse comes 
reg [7:0]reg_out;  // storing din out value in reg
// for storing input 


reg [7:0]temp2;


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
											ec_out=0;
											err_out=0;
						   				 end //} reset==0 end
						else  // reset ==1 case
											begin //{
																	if(nwr_in==0)
																		begin //{ // writing start
																		err_out=0;
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
													
												  				  end//} */
											
															end//}
															
				end//} ncs =0 end
				else
					begin//{
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
integer pulse_counter=0;
always@(negedge start_in)
		begin//{
		if(pulse_counter==1 && ncs_in==0 && nwr_in!==0 && nrd_in!==0 && err_out==0 && ec_out==0)
		begin//{
				start_flag=1;
				count_out=PLR-1;
				temp2=CCR;
				ec_out=0;
				dir_out=1;
				up_flag=1;
		end//}
		else 
						begin//{
							start_flag<=0;
						end//}

		end//}
			
always@(posedge clk_in)
		begin//{
		 if(start_in==1)
				begin//{
					pulse_counter=pulse_counter+1;
				end//}
				else
					begin//{
						pulse_counter=pulse_counter;
	
					end//}
		end//}

 always@(negedge clk_in)
		begin//{
				if(temp2==0)
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
			if(start_flag==1 && ec_out==0 && err_out==0)
				begin//{
					if(up_flag==1)
							begin//{
								if(count_out<ULR) 
									begin//{
										count_out=count_out+1; dir_out=1; 
									end//}	
								else // count ==ulr
									begin//{
										
										if(count_out==LLR && count_out==ULR && count_out==LLR )
											begin//{
											 temp2=temp2-1;
											if(temp2==1)
											ec_out=1;	
											end//}
											else begin
											down_flag=1; up_flag=0; end
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
			if(start_flag==1 && ec_out==0 && err_out==0)
		begin//{
				 	 if(down_flag==1)
							begin//{
								 if(count_out>LLR)
								begin//{
									count_out=count_out-1; dir_out=0;// end

									if((count_out==PLR && count_out==LLR) && temp2==1)	
									begin
										ec_out=1;
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
		if(ec_out==1)
				ec_out<=0;
				else
				ec_out<=ec_out;

end
// ===============================UP COUNTING UPTO PLR===================//
always@(posedge clk_in)
begin//{
			if(start_flag==1 && ec_out==0 && err_out==0)
		begin//{
					 if(preload_flag==1)
							begin//{
								if(count_out<PLR)
									begin//{
										count_out=count_out+1; dir_out=1;
										if(count_out==PLR && temp2==1)
											begin
												ec_out=1;
											end
									end//}
									else 
									begin//{	
										temp2=temp2-1; up_flag=1; preload_flag=0;
										//if((LLR==PLR || PLR==ULR) && temp2==CCR-1)
										//	begin
										//		ec_out=1;
										//	end
										
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



