module vending_machine(input clk_in,reset_in,enable_in,s1,s2,s3,s4,rupees10,rupees20,cancel_in,output reg [7:0]change_out,return_out,output reg product_out); 

localparam      PRODUCT_SELECT=6'b000001,
		MONEY_INSERT=6'b000010,
		PRODUCT_DELIVERY=6'b000100,
		GIVE_CHANGE=6'b001000,
		IDLE=6'b010000,
		RETURN_MONEY=6'b100000;

reg [5:0]present_state,next_state; // state handling registers	1+1

reg pcancel_in,ncancel_in,ps1,ns1,ps2,ns2,ps3,ns3,ps4,ns4; // input handling registers 1+4 1+4

reg [7:0]p_change_out,n_change_out,p_return_out,n_return_out;  // op handling registers 1+1 1+1

reg [3:0]ps1_product_count=4'd10,ps2_product_count=4'd10,ps3_product_count=4'd10,ps4_product_count=4'd10; // count of each product stored in resepective FFs  inter two 4

reg [3:0]ns1_product_count,ns2_product_count,ns3_product_count,ns4_product_count; // count of each product stored in resepective FFs  inter two 4


reg prupees10,nrupees10,prupees20,nrupees20;
reg [5:0]p_ip_money,n_ip_money;  // inter 1    money store 

reg [4:0]p_wait_time,next_wait_time;  // waiting for money counter inter 1
 
reg p_product_out,n_product_out;     // op giving ffs     1   total 15 
// PS LOGIC
always@(posedge clk_in)
begin
$display("posedge clk_in or negedge reset started");
	if(reset_in==0)
		begin
			present_state<=IDLE; //states
			pcancel_in<=0;
			ps1<=0;
			ps2<=0;
			ps3<=0;
			ps4<=0;                          
			prupees10<=0;
			prupees20<=0;     // ips 5
			p_ip_money<=0;    // inter
			p_change_out<=0;  // op1
			p_return_out<=0;    //op2
			p_wait_time<=0;   // inter
			p_product_out<=0;  // op 3

		end
	else
		begin
		$display("not reset ");

		
			present_state<=next_state;
			pcancel_in<=ncancel_in;
			ps1<=ns1;
			ps2<=ns2;
			ps3<=ns3;
			ps4<=ns4;
			prupees10<=nrupees10;
			prupees20<=nrupees20;
			p_ip_money<=n_ip_money;
			p_change_out<=n_change_out;
			p_return_out<=n_return_out;
			p_wait_time<=next_wait_time;
			p_product_out<=n_product_out;
			ps1_product_count<=ns1_product_count;
			ps2_product_count<=ns2_product_count;
			ps3_product_count<=ns3_product_count;
			ps4_product_count<=ns4_product_count;

		end



end

// NS LOGIC

always@(*)
begin
	next_state=present_state; // DEFAULT STATE
	ncancel_in=cancel_in;
	ns1=s1;  		// IP TAKING INTO Dffs
	ns2=s2;
	ns3=s3;
	ns4=s4;
	nrupees10=rupees10;
	nrupees20=rupees20;
	n_ip_money=p_ip_money;
	next_wait_time=p_wait_time;
	n_product_out=p_product_out;
	ns1_product_count=ps1_product_count;
	ns2_product_count=ps2_product_count;
	ns3_product_count=ps3_product_count;
	ns4_product_count=ps4_product_count;
							$display(" product count ",ns1_product_count);
							$display(" IP MONEY ",p_ip_money);
							$display(" ns1= %b ps1=%b ",ns1,s1);
							$display("s2 = %b ",ns2);
							$display("s3 = %b ",ns3);
							$display("s4 = %b ",ns4);
							$display("state = %b ",next_state);
							$display("cancel = %b ",ncancel_in);
							$display("wait time = %b ",next_wait_time);
				//			$display("given 20 rupees = %b ",nrupees20);
					//		$display("given 20 rupees = %b ",nrupees20);
							
							
	
	



if(enable_in==0)
	begin
$display("PRESENT STATE @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  %b",present_state);
	
		case(present_state)
			IDLE : 	begin
$display("IDLE @@@@@@@@@@@@ state started");
				next_state=PRODUCT_SELECT;
				ncancel_in=0;
				ns1=0;
				ns2=0;
				ns3=0;
			ns4=0;
				nrupees10=0;
				nrupees20=0;
				n_ip_money=0;
			next_wait_time=0;
			n_product_out=0;

				end
			
			PRODUCT_SELECT : begin                                                 // PRODUCT SELECTION STATE i/p are snacks , coffee , cool drink , candies ,cancel_in
							$display("i am in product select state please select product");
					$display("ps1=%b",ps1);

							if(ps1==1'b1)
							begin
							$display("product snack is selected");
							
							next_state=MONEY_INSERT;
							end

						else if(ps2==1)
							begin
							next_state=MONEY_INSERT;
							end

						else if(ps3==1)
							begin
							next_state=MONEY_INSERT;
							end
						else if(ps4==1)
							begin
							next_state=MONEY_INSERT;
							end
						else if(pcancel_in==1)
							begin
							//$display("else block in ##############################33 IDLE state executed");
							
							next_state=IDLE;
							end

						else
							begin
						//	$display("else block in ##############################33 IDLE state executed");
							
							next_state=IDLE;

							end


					 end // product select end

				MONEY_INSERT : 	begin                                // MONEY INSERTION ips are cancel_in,rupees10,rupees20,
							$display("i am in money insert state please insert money");
							$display("instered money is 10rs = %b 20rs = %b ",prupees10,prupees20);
							

					
							if(pcancel_in==1)
							begin
										if(p_ip_money==0) begin                     // no money inserted case
										next_state=PRODUCT_SELECT;
										end
										else    begin                                     // some amount of money given  case
											next_state=RETURN_MONEY;
											end

							end
						else if((ps1==1)&&(ps1_product_count>0))     // snacks are available case 
							begin
							$display(" else if block started ps1 %b  and product count %d is ",ps1,ps1_product_count);
							
									if(p_wait_time==30)          // waiting for money insertion
									begin
										if(p_ip_money==0) begin                     // no money inserted case
										next_state=PRODUCT_SELECT;
										end
										else    begin                                     // some amount of money given  case
											next_state=RETURN_MONEY;
											end
									end

								else if(prupees10==1)                      // rs 10 insertion case
									begin
									//	n_ip_money=p_ip_money+6'd10;
												if(p_ip_money>=30)
														begin		
															next_state=PRODUCT_DELIVERY;
														end
												else
													begin
														n_ip_money=p_ip_money+6'd10;

														next_state=MONEY_INSERT;
													end
									end  // 10 end
								else if(prupees20==1)                     // rs 20 insertion case
									begin
									//	n_ip_money=p_ip_money+6'd20;
													if(p_ip_money>=30)
														begin		
														next_state=PRODUCT_DELIVERY;
														end
													else
														begin
														n_ip_money=p_ip_money+6'd20;

														next_state=MONEY_INSERT;
														end


									end //20 end
								else                                   // counting wait time case
									begin
										next_wait_time=p_wait_time+1'b1; next_state=MONEY_INSERT;
									end   

							end // snacks block end 

						else if((ps2==1)&&(ps2_product_count>0))     // 2.coffee block
							begin
								if(p_wait_time==30)          // waiting for money insertion
									begin
										if(p_ip_money==0) begin                     // no money inserted case
										next_state=PRODUCT_SELECT;
										end
										else    begin                                     // some amount of money given  case
											next_state=RETURN_MONEY;
											end
									end

								else if(prupees10==1)                      // rs 10 insertion case
									begin
									//	n_ip_money=p_ip_money+6'd10;
												if(p_ip_money>=40)
														begin		
															next_state=PRODUCT_DELIVERY;
														end
												else
														begin
														next_state=MONEY_INSERT;
														n_ip_money=p_ip_money+6'd10;

														end

									end  // 10 end
								else if(prupees20==1)                     // rs 20 insertion case
									begin
									//	n_ip_money=p_ip_money+6'd20;
													if(p_ip_money>=40)
														begin		
														next_state=PRODUCT_DELIVERY;
														end
													else
														begin
														n_ip_money=p_ip_money+6'd20;

														next_state=MONEY_INSERT;
														end


									end //20 end
								else                                   // counting wait time case
									begin
										next_wait_time=p_wait_time+1'b1; next_state=MONEY_INSERT;

									end   

							

						end  // 2.coffee block end
		
						else if((ps3==1)&&(ps3_product_count>0))     // 3.cool drink block
							begin
								if(p_wait_time==30)          // waiting for money insertion
									begin
										if(p_ip_money==0) begin                     // no money inserted case
										next_state=PRODUCT_SELECT;
										end
										else    begin                                     // some amount of money given  case
											next_state=RETURN_MONEY;
											end
									end

								else if(prupees10==1)                      // rs 10 insertion case
									begin
									//	n_ip_money=p_ip_money+6'd10;
												if(p_ip_money>=40)
														begin		
															next_state=PRODUCT_DELIVERY;
														end
													else
														begin
														n_ip_money=p_ip_money+6'd10;

														next_state=MONEY_INSERT;
														end

									end  // 10 end
								else if(prupees20==1)                     // rs 20 insertion case
									begin
										n_ip_money=p_ip_money+6'd20;
													if(p_ip_money>=40)
														begin		
														next_state=PRODUCT_DELIVERY;
														end
													else
														begin
														n_ip_money=p_ip_money+6'd20;

														next_state=MONEY_INSERT;
														end


									end //20 end
								else                                   // counting wait time case
									begin
										next_wait_time=p_wait_time+1'b1; next_state=MONEY_INSERT;

									end   

							

						end  // 3.cool drink block end

						else if((ps4==1)&&(ps4_product_count>0))     // 4.candy block
							begin
								if(p_wait_time==30)          // waiting for money insertion
									begin
										if(p_ip_money==0) begin                     // no money inserted case
										next_state=PRODUCT_SELECT;
										end
										else    begin                                     // some amount of money given  case
											next_state=RETURN_MONEY;
											end
									end

								else if(prupees10==1)                      // rs 10 insertion case
									begin
									//	n_ip_money=p_ip_money+6'd10;
												if(p_ip_money>=30)
														begin		
															next_state=PRODUCT_DELIVERY;
														end
													else
														begin
														n_ip_money=p_ip_money+6'd10;
														next_state=MONEY_INSERT;
														end

									end  // 10 end
								else if(prupees20==1)                     // rs 20 insertion case
									begin
									//	n_ip_money=p_ip_money+6'd20;
													if(p_ip_money>=30)
														begin		
														next_state=PRODUCT_DELIVERY;
														end
													else
														begin
														n_ip_money=p_ip_money+6'd20;
														next_state=MONEY_INSERT;
														end


									end //20 end
								else                                   // counting wait time case
									begin
										next_wait_time=p_wait_time+1'b1; next_state=MONEY_INSERT;

									end   

							

						end  // 4.candy block end

						else
							begin
								next_state=PRODUCT_SELECT;
							end

						end // money insert end

			PRODUCT_DELIVERY: begin
							$display("i am in product delivery state ");
			
								
						if((ps1==1)&&(ps1_product_count>0))     // snacks are available case 
							begin
							$display("SNACKS are available");
							n_product_out=1'b1;
							ns1_product_count=ps1_product_count-1'b1;
								if(p_ip_money>30)
									begin
										next_state=GIVE_CHANGE;
									end
								else
									begin
										next_state=IDLE;
									end
							end

						else if((ps2==1)&&(ps2_product_count>0))     // coffee  are available case 

							begin
							$display("COFFEE  is available");
							n_product_out=1'b1;
							ns2_product_count=ps2_product_count-1'b1;
								if(p_ip_money>40)
									begin
										next_state=GIVE_CHANGE;
									end
								else
									begin
										next_state=PRODUCT_SELECT;
									end
							end






						else if((ps3==1)&&(ps3_product_count>0))     // cool drinks are available case 
							begin
							$display("cool drinks are available");
							n_product_out=1'b1;
							ns3_product_count=ps3_product_count-1'b1;
								if(p_ip_money>40)
									begin
										next_state=GIVE_CHANGE;
									end
								else
									begin
										next_state=PRODUCT_SELECT;
									end
							end

						else if((ps4==1)&&(ps4_product_count>0))     // candies are available case 
							begin
							$display("candies are available");
							n_product_out=1'b1;
							ns4_product_count=ps4_product_count-1'b1;
								if(p_ip_money>30)
									begin
										next_state=GIVE_CHANGE;
									end
								else
									begin
										next_state=PRODUCT_SELECT;
									end
							end

						else // delivery else
							begin
								next_state=RETURN_MONEY;
								$display("sorry product not availabe now");
							end
					end // delivery block end



					RETURN_MONEY:
							begin
							$display("please take return");
							
								if(ps1==1)
									begin
										n_return_out=p_ip_money;	next_state=IDLE;

									end
							else if(ps2)
									begin
										n_return_out=p_ip_money;	next_state=IDLE;

									end
							else if(ps3)
									begin
										n_return_out=p_ip_money;	next_state=IDLE;

									end
							else if(ps3)
									begin
										n_return_out=p_ip_money;	next_state=IDLE;

									end
							else
								begin							
								next_state=IDLE;
								end
							end  // return_out block end


					GIVE_CHANGE:
							begin
							$display("please take change");
							
								if(ps1==1)
									begin
										n_change_out=p_ip_money-30;	next_state=IDLE;
									end
							else if(ps2)
									begin
										n_change_out=p_ip_money-40;	next_state=IDLE;

									end
							else if(ps3)
									begin
										n_change_out=p_ip_money-40;	next_state=IDLE;

									end
							else if(ps3)
									begin
										n_change_out=p_ip_money-30;	next_state=IDLE;

									end
							else
								begin							
								next_state=IDLE;
								end

							end // give change_out block end




						default: begin

							next_state=IDLE;

							 end
endcase
	end // if ENABLE block end

else  // enable_in==1 case
	begin
							$display("enable 1 block entered");
	
	next_state=present_state; // DEFAULT STATE
	ncancel_in=cancel_in;
	ns1=s1;  		// IP TAKING INTO Dffs
	ns2=s2;
	ns3=s3;
	ns4=s4;
	nrupees10=rupees10;
	nrupees20=rupees20;
	n_ip_money=p_ip_money;
	next_wait_time=p_wait_time;
	n_product_out=p_product_out;

	end

end // always 2 end


// OP LOGIC


always@(present_state)
	begin
							$display("op logic started");
	
		case(present_state)
		PRODUCT_SELECT :	begin
				change_out=p_change_out;
				return_out=p_return_out;
				product_out=p_product_out;
				end

		MONEY_INSERT:begin
				change_out=p_change_out;
				return_out=p_return_out;
				product_out=p_product_out;
				end

		PRODUCT_DELIVERY:begin
				change_out=p_change_out;
				return_out=p_return_out;
				product_out=p_product_out;
				
//				$display
				end

		GIVE_CHANGE:begin
				change_out=p_change_out;
				return_out=p_return_out;
				product_out=p_product_out;end

		IDLE:begin
				change_out=p_change_out;
				return_out=p_return_out;
				product_out=p_product_out;end

		RETURN_MONEY:begin
				change_out=p_change_out;
				return_out=p_return_out;
				product_out=p_product_out;end

	//		end
		default: begin
			change_out=0;
			return_out=0;
			product_out=0;
					end
		endcase
 end

endmodule
