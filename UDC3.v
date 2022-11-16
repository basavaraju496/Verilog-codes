
module up_down_counter2556 (inout [7:0]Din,input clk,ncs,nrd,nwr,start_in,reset,A0,A1 ,output reg [7:0]cout,output reg err,ec,dir);
reg start_flag; // start flag is raised whenever start pulse comes 
reg [7:0]reg_out;  // storing din out value in reg for storing input
reg [7:0]temporary_CCR;  // to store ccr
reg [5:0]pulse_counter; // to count pulses in start counts the start pulses

assign Din=(ncs==0 && nrd==0 && nwr==1)? reg_out:8'bz;  // whenever value in din out changes the it iis assigned to din 
//  inout port must be wire so we are unable to use in procedural blocks(while
//  reading) taken a register as reg_out values will be taken to it{while
//  reading}| and
//  assigned to wire Din	using assign keyword***************///

reg [7:0]PLR,ULR,CCR,LLR;
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
		up_flag<=1;
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
 if(ec==0 && start_flag==1 && temporary_CCR<CCR && err==0 && reset==1 && ncs==0 )
	begin//{
      if(cout==ULR_reg)
        	down_flag=1;

      if(cout==LLR_reg && down_flag===1 )
      		up_flag=1;

      if(cout==PLR && up_flag===1 && down_flag==1)
        	preload_flag=1;

      if(ec===1)
		cout=8'dz;

      cout= !(cout=== 8'dz || cout===8'dx) ?(((cout==ULR_reg && down_flag===0) || down_flag===1) ? ( (cout==LLR_reg && up_flag===0) || up_flag===1 ? ( ((cout==PLR && preload_flag===0) || preload_flag===1) ? PLR: cout+1):cout-1): cout+1):PLR;


           if(preload_flag===1)
      		begin
		temporary_CCR=temporary_CCR+1;
		down_flag=0;up_flag=0;preload_flag=0;
		end
		
	end//}
	
	else	
		if((cout!== 8'dz || cout!==8'dx) && ec==0)//for multiple start signals are coming
			cout=cout;
		else
			cout=8'dz;


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






