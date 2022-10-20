module comparator(input [7:0]a,b,input el,output reg zf,cf,gf,lf);
  
//reg [7:0]accumulator=a;


always @(*)
begin

if(el==0)
begin
 	if (a==b)   // a equal to b
 	begin
	  cf=1'b0;
	   zf=1'b1;
	//	accumulator=8'b0;
        $display("when op are equal accumulator value");

	 end
        else if (a>b)   // a greaterthan  b
 	begin
	    
            gf=1'b1; 
      //  $display("when op are not equal accumulator value %b",accumulator);
 	end
        else    //  a lessthan  b
 	begin
	  lf=1'b1;
	 end
end
else 
	begin 
//	c_out=8'bzzz;
  	lf=1'b1;
     //   $display("when op are not not equal accumulator value %b",accumulator);

	end
 
end
endmodule


