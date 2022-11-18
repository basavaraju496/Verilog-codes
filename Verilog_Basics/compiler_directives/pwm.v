// Code your design here
module pwm_generation(input clk_in,refresh,enable,input [1:0]sel, output reg clk_out);
  localparam   IDLE=5'b00001,
  			   RUN=5'b00010,
  			   F10K=5'b00100,    /// states 
			   F100K=5'B01000,
  			   F1000K=5'b10000;
  
  parameter C10=14'd10000,
  C100=14'd1000,                   // variable count
  C1000=14'd100;

reg [1:0]psel,nsel;
  
  reg [4:0]present_state,next_state;  // state handling registers
  
  reg [13:0]p_counter,n_counter;     // counter   
 
  reg p_clk_out,n_clk_out;               // variable clk
  
always@(posedge clk_in,negedge refresh)
    begin
      	if(refresh==0)   // reset condition
      	  									begin
      										    present_state<=IDLE;
     										       p_counter<=14'b0;
   										       p_clk_out<=0; 
													 psel<=2'bz;
       		 								end
      else
	  			begin
   											   present_state<=next_state; 
													psel<=nsel;
											      p_counter<=n_counter;
										         p_clk_out<=n_clk_out; 
      		end
    end   // always block end

  // ns logic
always@(*)
  begin
    next_state=present_state;    // default present states assigned to next state
    n_counter=p_counter;
    n_clk_out=p_clk_out; 
	 nsel=sel;


 								   if(enable==0)
								      begin
							 				case(present_state)
													  IDLE:begin
      															   next_state=RUN;
										    							p_counter=0;
                              							   n_clk_out=0; 

                      									end                                
             
 														 RUN:  begin
   																	 	case(psel)
																		        2'b00:next_state=F10K;
																		        2'b01:next_state=F100K;
																		        2'b10:next_state=F1000K;
																            default:next_state=IDLE;
  																			endcase
    															 end
    
 														 F10K: begin
 																	    n_clk_out=0; 
 																	   if(p_counter==(C1000-1))
  																					  begin
 																					     next_state=F100K; p_counter=0;
   																				  end   
																      else
																	  				begin
       																				 next_state=F10K;
																				      	n_counter=p_counter+1'b1;
																				        n_clk_out=1; 
																				   end
    
    
  																end
 													 F100K:
															begin
 																 n_clk_out=0; 
 																	 if(p_counter==(C100-1))
  																		  begin
  																			    next_state=F1000K; 
     																				 p_counter=0;
      
   																		 end
  																  else 
																  			begin
    																			    n_counter=p_counter+1'b1;
     																				 next_state=F100K;
  																	 			    n_clk_out=1; 
  																			  end
   
														  end
												  F1000K:begin
   															 n_clk_out=0; 

   														 if(p_counter==(C10-1))
 																   begin
   																   next_state=RUN; p_counter=0;
 																   end
														    else begin
  																    n_counter=p_counter+1'b1;
  																    next_state=F1000K;
    																  n_clk_out=1; 
   																 end
    
 														 end
   											default:begin next_state=IDLE; end
      
      							  endcase
      end// if end
		else
	  	begin
						 next_state=present_state; 
					    n_counter=p_counter;
					    n_clk_out=p_clk_out;  
	   end
  end
  // op logic
  
          always@(present_state)
            begin
              case(present_state)
                IDLE :  clk_out=p_clk_out; 
                RUN : begin clk_out=p_clk_out; end
                F10K : begin clk_out=p_clk_out; end
                F100K : begin clk_out=p_clk_out; end
                F1000K : begin clk_out=p_clk_out; end
					 default : clk_out=1'bz;
              
              endcase
            end
  
  
  
  
  
  
  
  
  
  
  
  
endmodule
