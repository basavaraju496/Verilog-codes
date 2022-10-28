`include"alu.v"

module tb_new_alu_fork;

reg clk=0;


// ------------------declaring signals----------------------//
reg [7:0]A_in_tb,B_in_tb;

reg init_tb_in;

reg [3:0]opcode_in_tb;

wire [15:0]design_alu_out;

reg [15:0]checker_alu_out;

reg ex_sel_in_tb;

reg sflag;

reg [7:0]temp;

reg [3:0]w1,w2;
// ----------- module instantiation ---------------//

top_alu dut_instance(opcode_in_tb,init_tb_in,A_in_tb,B_in_tb,design_alu_out,ex_sel_in_tb);

// ----------------- clock generation------------------//
always #5 clk=~clk;

// --------stimulus input ------------------//

always@(negedge clk) 
begin
		opcode_in_tb=$random;
		A_in_tb=$random;
		B_in_tb=$random;

end
/*
initial begin
A_in_tb=10;
B_in_tb=20;
#25 opcode_in_tb=4'b0000;
#5 opcode_in_tb=4'b0001;
#10 opcode_in_tb=4'b0010;
#10 opcode_in_tb=4'b0011;
#10 opcode_in_tb=4'b0100;
*/



//end
initial begin
init_tb_in=0;
ex_sel_in_tb=0;

#10 init_tb_in=1;

end
// --------------checker op getting ----------------------//

always@(posedge clk)
begin
	if(init_tb_in==0)
		begin
		checker_alu_out=16'bz;
		end
	else
		begin
				case(opcode_in_tb)
						4'b0000: begin checker_alu_out={8'b0,8'bz};  end
						4'b0001: begin checker_alu_out=A_in_tb+B_in_tb; $display("doing ADDITION in checker ");   end
						4'b0010: begin checker_alu_out=A_in_tb-B_in_tb;  $display("doing SUBTRACTION in checker ");    end
						4'b0011: begin checker_alu_out=A_in_tb*B_in_tb;  $display("doing MULTILPICATION in checker ");  end
						4'b0100: begin checker_alu_out=A_in_tb/B_in_tb;  $display("doing DIVISION in checker "); end

						4'b0101: begin checker_alu_out={8'b0,A_in_tb&B_in_tb};  $display("doing AND in checker ");  end   
						4'b0110: begin checker_alu_out={8'b0,A_in_tb|B_in_tb};  $display("doing OR in checker "); end
						4'b0111: begin checker_alu_out={8'b0,~A_in_tb};  $display("doing NOT in checker "); end
	         			4'b1000: begin checker_alu_out={8'b0,~(A_in_tb&B_in_tb)};  $display("doing NAND in checker "); end
						4'b1001: begin checker_alu_out={8'b0,~(A_in_tb|B_in_tb)};  $display("doing NOR in checker ");  end
						4'b1010: begin checker_alu_out={8'b0,A_in_tb^B_in_tb};  $display("doing XOR in checker ");  end

						4'b1011: begin checker_alu_out={8'b0,8'bz};  $display("doing REFRESH in checker ");  end
						4'b1100: begin checker_alu_out=(A_in_tb==B_in_tb)?(16'h0000):((A_in_tb>B_in_tb)?(16'H0080):(16'H0001));  $display("doing COMPARISION in checker a=%0d b=%0d  ",A_in_tb,B_in_tb);  end  
						4'b1101: begin 


						if(B_in_tb[1:0]==2'b00)
							begin 
								checker_alu_out={8'b0,A_in_tb<<B_in_tb[7:4]};  // ls

							end
						else if(B_in_tb[1:0]==2'b01)
							begin
								checker_alu_out={8'b0,A_in_tb>>B_in_tb[7:4]};		//RS
								$display("rs is done in checking b=%b a=%b",B_in_tb[7:4],A_in_tb);

							end
							else if(B_in_tb[1:0]==2'b10)
									begin
										temp=A_in_tb;
										w2=B_in_tb[7:4]%8;
										w1=8-w2;

										checker_alu_out={8'b0,((A_in_tb<<w2)| (temp>>w1))};    // rotate left
									//	$display("data a=%b no of rotates B=%d left w1=%d right w2=%d 12 mod 8 %d",A_in_tb,B_in_tb[7:4],w1,w2,12%8);
									end
								else if(B_in_tb[1:0]==2'b11)
									begin
										temp=A_in_tb;
										w2=B_in_tb[7:4]%8;

										w1=8-B_in_tb[7:4];
										checker_alu_out={8'b0,((A_in_tb>>w2)| (temp<<w1))}; // rotate right 
									end
									else
									begin
										checker_alu_out=16'bz;
									end
						  end //shifter


						4'b1110: begin                       // code conv 
							
						if(B_in_tb[1:0]==2'b00)   // binary yto bcd
							begin 
								if(B_in_tb[7:4]<10)
									checker_alu_out=B_in_tb[7:4];
								else
								checker_alu_out=B_in_tb[7:4]+6;
							end
						else if(B_in_tb[1:0]==2'b01)   // BINARY TO GRAY
							begin
								checker_alu_out={B_in_tb[7],B_in_tb[7]^B_in_tb[6],B_in_tb[6]^B_in_tb[5],B_in_tb[5]^B_in_tb[4]};
							end
							else if(B_in_tb[1:0]==2'b10)   // BINARY TO XS-3
									begin
									checker_alu_out=(B_in_tb[7:4]<10)?(B_in_tb[7:4]+8'd3):B_in_tb[7:4]+57;
									end
								else if(B_in_tb[1:0]==2'b11)   // // BINARY TO XS-5

									begin
									checker_alu_out=(B_in_tb[7:4]<10)?(B_in_tb[7:4]+8'd5):B_in_tb[7:4]+91;
									
									end
									else
									begin
										checker_alu_out=16'bz;
									end
						
								 end // cod econverrsion end
						default: begin checker_alu_out=16'bz; end

				endcase
		end

end




// -------------comparing DUT vs TB --------------------// 

always@(negedge clk )
begin
		if(design_alu_out===checker_alu_out)
		begin
			$display($time,"opcode=%0d A_in_tb = %b (%0d) B_in_tb=%b (%0d) design_ALU_out=%b (%0d) ::: check_ALU_out=%b (%0d)::: both are equal ",opcode_in_tb,A_in_tb,A_in_tb,B_in_tb,B_in_tb,design_alu_out,design_alu_out,checker_alu_out,checker_alu_out);
		end
		else
		begin
			$display($time,"opcode=%0d A_in_tb = %b (%0d) B_in_tb=%b (%0d) design_ALU_out=%b (%0d) ::: check_ALU_out=%b (%0d) :::*************** both are NOT equal ",opcode_in_tb,A_in_tb,A_in_tb,B_in_tb,B_in_tb,design_alu_out,design_alu_out,checker_alu_out,checker_alu_out);

		end


end


//----------------- finishing simulation --------------//

initial #2000 $finish;

endmodule


