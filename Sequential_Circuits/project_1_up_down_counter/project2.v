module up_down_counter (inout [7:0]Din,input clk_in,ncs_in,nrd_in,nwr_in,start_in,reset_in,A0,A1 ,output reg [7:0]count_out,output reg err_out,ec_out,dir_out);
reg start_flag;
reg [7:0]reg_out;  // storing din out value in reg
// for storing input 




assign Din=(nrd_in==0 && nwr==1)? reg_out:8'bz;  // whenever value in din out changes the it iis assigned to din 
	

reg [7:0]plr,ulr,ccr,llr;

reg [9:0]temp,no_of_plrs;


always@(posedge clk_in ,ncs_in)
		begin //{
			if(ncs_in==0)
					begin //{ chip select on
						if(reset_in==0)
							begin //{   // reset==0
							plr<=0;
							llr<=0;
							ccr<=0;
							ulr<=8'd255;  
						//	dir_out<=1; default===>x
						//	err_out<=0;
							ec_out<=0;
//							nrd_in=1;
							err_out<=0;

//$display("****************RESET==0*************************** ");





						    end //} reset==0 end
						else  // reset ==1 case
							begin //{

//$display("****************RESET==1 *************************** ");
								if(nwr_in==0)
									begin //{ // writing start
									err_out<=0;
$display(">>>>>>>>>>>>>>>>WRITTING DATA INTO THE REGISTERS<<<<<<<<<<<<<<<<<<<<<<<");
$display("before writing plr=%0d ulr=%0d llr=%0d ccr=%0d",plr,llr,ulr,ccr);										
									
										case({A1,A0})
                                       		2'b00: begin plr<=Din; end
                                       		2'b01: begin ulr<=Din;end
                                       		2'b10: begin llr<=Din;end
                                       		2'b11: begin ccr<=Din;end
										 default : begin   		plr<=plr; llr<=llr; ccr<=ccr; ulr<=ulr;   		 end
							endcase
								end //} writing end
								else if(nrd_in==0)
										begin//{
$display(">>>>>>>>>>>>>>>>READING DATA FROM THE REGISTERS<<<<<<<<<<<<<<<<<<<<<<<");
$display("reading plr=%0d ulr=%0d llr=%0d ccr=%0d",plr,llr,ulr,ccr);										
												case({A1,A0})
                                       						2'b00: begin reg_out<=plr;end
                                       						2'b01: begin reg_out<=ulr;end
                                       						2'b10: begin reg_out<=llr;end
                                       						2'b11: begin reg_out<=ccr;end
															default : begin   		reg_out<=8'bz;   		 end
												endcase
									end//}
//   ************    ERROR CHECKING ************     //
								else if((plr<llr) || (plr>ulr))  // error check
										begin  //{
												err_out<=1;
								     			$display("unable to count with that values write new values");								
									    end//} 
// ************     START CHECKING	************//									
							else if(start_flag==1 && err_out==0)
									begin//{
								$display("********* COUNTING STARTED ***********");

									end//}
						end//}
end//}
end //} 1st always block end


//====================== start flag ==============================//

always@(negedge start_in)
		begin
			start_flag<=1;
		end

always@(posedge clk_in)
		begin
		 if(start_flag==1 && err_out==0)
				begin
					temp<=0;

				end
			
		end
// ====================direction ===============================//

always@(posedge clk_in)
		begin
		if(count_out==ulr)
			begin
				dir_out<=0;
			end
		else
		begin
			if(count_out==llr)
				begin
				dir_out<=1;
				end
				else
				begin
					dir_out<=dir_out;
				end
		end
		end





//===========================no of plrs calculation=========================//
always@(posedge clk_in)
		begin//{
				if(plr==ulr)
					begin
						if(plr==llr)
							begin
								no_of_plrs<=ccr;
							end
						else
							begin
								no_of_plrs<=ccr+1;
							end
					end
				else
					begin
						if(plr==llr)
							begin
								no_of_plrs<=ccr+1;
							end
						else
						begin
							no_of_plrs<=(2*ccr)+1;
						end
					end
		 end//}

    endmodule
