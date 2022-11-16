

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
