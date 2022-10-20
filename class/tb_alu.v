module tb_alu; // TESTBENCH
// SIGNALS
reg [3:0]opcode_in;
reg init;
reg [7:0]A,B;
wire [15:0]Y;
reg ex_sel;
integer i;


// module instatiation
top_alu DUT(opcode_in,init,A,B,Y,ex_sel);

// giving stimulus 
initial
	begin
//$monitor("time =%t init = %b opcode = %b output of decoder = %b  ",$time,init,opcode_in,Y);

		init=1'b1;
                ex_sel=1'b0;
//ex_sel=1'b0;
	//	opcode_in=4'd13;
//A=8'b0001_0010; B=8'b1000_0011;
	//	for (i=12; i<13; i=i+1)
		//	begin
			 	opcode_in=4'b0000; B=8'b0000_0010; A=8'b0000_0010;

		//	end
	//		#5 	opcode_in=4'b1100; B=8'b0000_0010; A=8'b0000_0010;
	//		#5 	opcode_in=4'b1100; B=8'b0000_0000; A=8'b0000_0010;
                
		  
/*
//opcode_in=4'b1100; 
//#5 opcode_in=4'b1101;
//#5 opcode_in=4'b1110;*/

	end   
 
always #5 opcode_in=opcode_in+1'b1;
initial
	begin 
$monitor($time," init = %b opcode = %b (%3d) inputs  A= %b (%3d) , B=%b (%3d)  Y= %b (%d)",init,opcode_in,opcode_in,A,A,B,B,Y,Y);
	end


initial #200 $finish;




endmodule
