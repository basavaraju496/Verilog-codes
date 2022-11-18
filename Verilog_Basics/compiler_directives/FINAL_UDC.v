`define WIDTH 7
module up_down_counter2556 (inout [`WIDTH:0]Din,input clk,ncs,nrd,nwr,start_in,reset,A0,A1 ,output reg [`WIDTH:0]cout,output reg err,ec,dir);
reg start_flag; // start flag is raised whenever start pulse comes 
reg [`WIDTH:0]reg_out;  // storing din out value in reg for storing input
reg [`WIDTH:0]temporary_CCR;  // to store ccr
reg [5:0]pulse_counter; // to count pulses in start counts the start pulses

assign Din=(ncs==0 && nrd==0 && nwr==1)? reg_out:8'bz;  // whenever value in din out changes the it iis assigned to din 
//  inout port must be wire so we are unable to use in procedural blocks(while
//  reading) taken a register as reg_out values will be taken to it{while
//  reading}| and
//  assigned to wire Din	using assign keyword***************///

reg [`WIDTH:0]PLR,ULR,CCR,LLR;
// registers for storing values required for counter
// ===>PLR = PRELOAD REGISTER stores  count start value 
// ======>ULR = UPPER LIMIT REGISTER stores upperlimit of count
// ========>LLR = LOWER LIMIT REGISTER stores lower limit of count
//==>CCR= CYCLIC COUNT REGISTER number of times to count

reg up_flag,down_flag,preload_flag;
// these flags will control flow of count whether to do up counting or downcounting

reg plr_flag,ulr_flag,llr_flag,ccr_flag;  // flags to prevent overwrite the data into registers while counting and to prevent the multiple times writing of data

always@(posedge clk)
		begin //{  1
			if(ncs==0)  
					begin //{ chip select on 2
						if(reset==0)
										begin //{   // reset==0
											PLR=0;
											LLR=0;
											CCR=0;
											ULR=8'd255;  
											ec=1'b0;  // initiallly zero
											err=1'b0;
                                            dir=1'bz;      
                                            start_flag=1'bz; 
											pulse_counter=0;
                                            temporary_CCR=8'bz;
											cout=8'bz;
											plr_flag=0;
											llr_flag=0;
											ulr_flag=0;
											ccr_flag=0;
{up_flag,down_flag,preload_flag}=0;

						   				 end //} reset==0 end
						else  // reset ==1 case
											begin //{ 3
																	if(nwr==0)
																		begin //{ // writing start 4
																		$display(" $ display >>>>>> PLR=%0d ULR=%0d LLR=%0d= CCR=%0d ",PLR,ULR,LLR,CCR);
																		$strobe("$strobe >>>>> PLR=%0d ULR=%0d LLR=%0d= CCR=%0d ",PLR,ULR,LLR,CCR);
																		$monitor("$monitor >>>> PLR=%0d ULR=%0d LLR=%0d= CCR=%0d ",PLR,ULR,LLR,CCR);





																		case({A1,A0})
                                  					     				2'b00: begin 
																					if(plr_flag==0)
																							begin
																								PLR=Din;  // PLR loaded with input data
																								plr_flag=1; 
																							end
																						else
																							begin
																							PLR=PLR;
																							plr_flag=plr_flag;
																							end
																		end

					                                       				2'b01: begin
																				if(ulr_flag==0)
																							begin
																							ULR=Din;	// ULR loaded with input data
																							ulr_flag=1;	
																							end
																				else
																							begin
																							ULR=ULR;
																							ulr_flag=ulr_flag;
																							end

																		
																		end
																		
                    							                   		2'b10: begin
																		if(llr_flag==0)
																							begin
																							LLR=Din; // LLR loaded with input data
																							llr_flag=1;   
																							end
																		else
																							begin
																							LLR=LLR;
																							llr_flag=llr_flag;
																							end
																		end
                    		                   							2'b11: begin
																				if(ccr_flag==0)
																								begin
																								CCR=Din; // CCR loaded with input data
																								ccr_flag=1; 
																								end
																								else
																								begin
							     																CCR=CCR; 
								     															ccr_flag=ccr_flag;
								   										
									         													end
																								end
																		 default : begin 
																		 				 PLR=PLR;
																						 LLR=LLR;
																						 CCR=CCR; 
																						 ULR=ULR;  
																						 plr_flag=plr_flag; 
																						 llr_flag=llr_flag; 
																						 ccr_flag=ccr_flag; 
																						 ulr_flag=ulr_flag;
																				    end
																		 
																		endcase
																	end //} writing end

                                            
															else if(nrd==0)  // reading can be happened at any time
																	begin//{
																		case({A1,A0})
        		                               							2'b00: begin reg_out=PLR;end
                		                       							2'b01: begin reg_out=ULR;end
                                		       							2'b10: begin reg_out=LLR;end
                        		               							2'b11: begin reg_out=CCR;end
																		default : begin   		reg_out=8'bz;   		 end
																		endcase
                                                                    end//} read end
															else   
																begin  //{
                                                                    					
					
                														    PLR=PLR;
                														    LLR=LLR;
                														    CCR=CCR;
                														    ULR=ULR;
                														    start_flag=start_flag;
                														    temporary_CCR=temporary_CCR;
                														    err=err;
                														    dir=dir;
                														    ec=ec;
                														   	cout=cout;																					
    
												  				  end//} 
											
                                            end//}  reset 1 end
															
				end//} ncs =0 end
				else
					begin//{ ncs==1
					
                    PLR=PLR;
                    LLR=LLR;
                    CCR=CCR;
                    ULR=ULR;
                    start_flag=start_flag;
                    temporary_CCR=temporary_CCR;
                    err=err;
                    dir=dir;
                    ec=ec;
                    cout=cout;
                    end//}    ncs 1 end 
	   
        end//}  always end


//===========================================ERROR SIGNAL GENERATION========================//
always@(posedge clk)
		begin//{
		if(PLR<LLR || PLR>ULR)
			begin//{
				err=1;
              {plr_flag,ulr_flag,ccr_flag,llr_flag}=0;
			end//}
			else
				begin//{
				err=0;
                 
				end//}
		end//}
	
reg data_flag;			
//====================== START FLAG @==============================//
always@(posedge clk)
		begin//{
		 if(start_in==1 && ncs==0 && reset==1 &&  err==0  )   // detects only whren err=0
				begin//{
					pulse_counter=pulse_counter+1;   // counting start pulses
                    
				end//}
				else
					begin//{
						pulse_counter=pulse_counter;   
	
					end//}
		end//}
always@(negedge clk)
		begin//{
		 if(start_in==1 && ncs==0 && reset==1 &&  err==0  )   // detects only whren err=0
				begin//{
					pulse_counter=pulse_counter+1;   // counting start pulses
				end//}
				else
					begin//{
						pulse_counter=pulse_counter;   
	
					end//}
		end//}
		


always@(negedge start_in)
		begin//{
		if( ncs==0 && reset==1 &&  err==0 ) // starts only when one pulse is obtained and ncs=0 reset =1 ,.....
		begin//{
          if(pulse_counter==1 || pulse_counter==2) begin
				if(CCR==0)         // storing CCR values to temporary register
					begin			
					{plr_flag,ulr_flag,llr_flag,ccr_flag}=0;  // WE CAN WRITE NEW DATA AFTER ENDCYCLE 
					pulse_counter=0;
					start_flag=0;
					data_flag=0;
          {preload_flag,up_flag,down_flag}=0;
		  
					
					end
					else if(CCR>0)
					begin
					temporary_CCR=CCR; 
					dir=1;
					ec=0; 
					data_flag=1;
					pulse_counter=pulse_counter;
					end
                    else
                    begin
                        ec=1'bz;
                        pulse_counter=0;
                        start_flag=0;
                    end
	
		end//}
				
					else begin
					start_flag=start_flag;
					pulse_counter=0;
					end
		end
		else 
						begin//{    
                          pulse_counter=0;
							start_flag=start_flag;  // pulse count>1 || ncs=1 || reset=0 || nwr=0 || nrd=0 || err=1 endcycle=0    
						end//}

		end//}
always@(posedge clk)
		begin
if(data_flag==1)
		begin
		//cout=PLR;
		start_flag<=1;
		up_flag=1;
		end
		//else
		//cout=cout;
end

always@(posedge clk)
		begin
if(data_flag==1)
		begin
		cout=PLR;
		//start_flag<=1;
		//up_flag<=1;
		end
		//else
		//cout=cout;
end








// ===========================COUNTER BLOCK====================//

always@(posedge clk)
begin//{
	if(start_flag==1 && ncs==0  && reset==1 &&  err==0 && ec==0)
				begin//{
				data_flag=0;
				
					if(up_flag==1)
		
							begin//{
							
								if(cout<ULR) 
									begin//{
                                      cout=cout+1;  dir=(cout<ULR)?1:0;   // dir=1 when upcounting
									 // if(cout==ULR) begin  down_flag=1; up_flag=0; end
							
                                    end//}	
	
                              else // count ==ulr
									begin//{
								//	$display("all equall inside else ");
										if(PLR == ULR && PLR==LLR )
											begin//{
								//	$display($time,"all equall inside else %0d ",temporary_CCR);

											 temporary_CCR=temporary_CCR-1;  
							//		$display($time,"all equall inside else %0d ",temporary_CCR);
											 
											if(temporary_CCR==0 || temporary_CCR==1) 
                                                begin//{

											        ec=1;
													dir=1'bz;
													pulse_counter=0;
													start_flag=0;
													cout=cout;
													temporary_CCR=8'bz;
                                            	end//}
                                                else
                                                begin//{
                                                    ec=ec;
													cout=cout;
                                                end//}
											end//}
											else
                                                 begin//{
											        down_flag=1; up_flag=0; dir=0;
                                                end//}
					    				end//}
end//}
					else
							begin//{
									cout=cout; //dir=1'bz; //new edit

								end//}
end//}
else
begin
		cout=cout; dir=dir;
end

if(start_flag==1 && ncs==0 &&  reset==1 &&  err==0 && ec==0)		
		begin//{
				 	 if(down_flag==1)
							begin//{
								 if(cout>LLR)
									begin//{
									cout=cout-1;
									dir=(cout>LLR)?0:1;// dir=0 when downcounting
									if((PLR==LLR) && temporary_CCR==0)	// CHECK PLR==LLR
									    begin//{
										    ec=1;
											dir=1'bz;
											pulse_counter=0;
											start_flag=0;
											temporary_CCR=8'bz;	
									end//}
									else begin
										cout=cout;
										ec=ec;
										end


									end//}	
								else 
								begin//{
									preload_flag=1; down_flag=0; dir=1; 
								end//}
	
							
						end//}

				    	

					else
							begin//{
									cout=cout; dir=dir;

							end//}
							end//}

else
begin
		cout=cout; dir=dir;
end


if(start_flag==1 && ncs==0 &&  reset==1 &&  err==0 && ec==0)		begin//{
					 if(preload_flag==1)
							begin//{
								if(cout<PLR)
									begin//{
										cout=cout+1; dir=(cout<PLR)?1:1'BZ; // dir=1 when upcounting
										if(cout==PLR && temporary_CCR==1)
											begin
												ec=1;
												dir=1'bz;
												pulse_counter=0;
													start_flag=0;
													temporary_CCR=8'bz;
											end
                                            else
                                            begin
                                                ec=ec;
                                            end
									end//}
									else 
									begin//{	
                                      temporary_CCR=temporary_CCR-1;  dir=(cout<ULR)?1:0;
                                      preload_flag=0;
										if(temporary_CCR==0)
										ec=1;
										else
											up_flag=1;
									end//}
							
								end//}		
					else
							begin//{
									cout=cout; dir=dir;

							end//} pf end
							end//} total if end

					else// totoal else
						begin
						cout=cout; dir=dir;
						end



end

//==============================END CYCLE @============================//
  always@(posedge clk)
	begin	
		if(ec==1) begin
					{plr_flag,ulr_flag,llr_flag,ccr_flag}=0;  // WE CAN WRITE NEW DATA AFTER ENDCYCLE 
				dir=1'bz;
          {preload_flag,up_flag,down_flag}=0;
				ec=0; 
					end
				else begin
					ec=ec;
                end
end
///////////======================== THE END  =======================//




    endmodule






