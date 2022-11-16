

always@(posedge clk)
begin
if(data_loader==1)
		begin
				if(temp2==0)
					ec=1
					else
					cout=PLR;
					upflag=1;
		end

end

always@(posedge clk)
		begin
		
			if(uf==1 && count<ULR)
			begin
					task_counting(1,count);
						if(count==ULR)
							begin
								df=1;
							end
						else
							begin end
			end
else
	begin
		df=1;	uf=0;
	end
		end

always@(posedge clk)
		begin
			if(df==1 && count>LLR)
			begin
					task_counting(0,count);
						if(count==LLR)
							begin
								pf=1; df=0;
							end
						else
							begin end
			end
else
	begin
		pf=1;	
	end
		end
always@(posedge clk)
		begin//{
if(start_flag==1 && ncs==0 &&  reset==1 &&  err==0 && ec==0)
		begin//{
					 if(preload_flag==1)
							begin//{
							if( count<PLR)
								begin//{
										task_counting(1,count);
										if(count==ULR)
											begin//{
											data_loader=1; pf=0; temp2=temp2-1;
											end//}
										else
										begin end
								end
							else
								begin//{
									 pf=0; data_loader=1;	temp2=temp2-1;
								end//}
								end//}
							else
								begin//{
								//	 pf=0; data_loader=1;	temp2=temp2-1;
								end//}
							end//}
							else
							begin //{
//							count=count;
							
							end//}



		end//}



end//}


task task_counting;
input direction;
input [7:0]count;

count=(direction)?(count+1):(count-1);



endtask
