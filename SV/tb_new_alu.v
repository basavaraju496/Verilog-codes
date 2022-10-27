`include"alu.v"

module tb_new_alu;

reg clk=0;


// ------------------declaring signals----------------------//
reg [7:0]A_in_tb,B_in_tb;

reg init_tb_in;

reg [3:0]opcode_in_tb;

wire [15:0]design_alu_out;

reg [15:0]checker_alu_out;

reg ex_sel_in_tb;

// ----------- module instantiation ---------------//

top_alu dut_instance(opcode_in_tb,init_tb_in,A_in_tb,B_in_tb,design_alu_out,ex_sel_in_tb);

// ----------------- clock generation------------------//
always #5 clk=~clk;

// --------stimulus input ------------------//

always@(negedge clk) 
begin
		opcode_in_tb={$random}%13;
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
#20 init_tb_in=1;

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
						4'b0000: begin checker_alu_out=16'Bzzz;  end
						4'b0001: begin checker_alu_out=A_in_tb+B_in_tb; $display("doing ADDITION in checker ");   end
						4'b0010: begin checker_alu_out=A_in_tb-B_in_tb;  $display("doing SUBTRACTION in checker ");    end
						4'b0011: begin checker_alu_out=A_in_tb*B_in_tb;  $display("doing MULTILPICATION in checker ");  end
						4'b0100: begin checker_alu_out=A_in_tb/B_in_tb;  $display("doing DIVISION in checker "); end

						4'b0101: begin checker_alu_out=A_in_tb&B_in_tb;  $display("doing AND in checker ");  end
						4'b0110: begin checker_alu_out=A_in_tb|B_in_tb;  $display("doing OR in checker "); end
						4'b0111: begin checker_alu_out=~A_in_tb;  $display("doing NOT in checker "); end
						4'b1000: begin checker_alu_out=~(A_in_tb&B_in_tb);  $display("doing NAND in checker "); end
						4'b1001: begin checker_alu_out=~(A_in_tb|B_in_tb);  $display("doing NOR in checker ");  end
						4'b1010: begin checker_alu_out=A_in_tb^B_in_tb;  $display("doing XOR in checker ");  end

						4'b1011: begin checker_alu_out=16'bz;  $display("doing REFRESH in checker ");  end
						4'b1100: begin checker_alu_out=(A_in_tb==B_in_tb)?(16'h0000):((A_in_tb>B_in_tb)?(16'H0080):(16'H0001));  $display("doing COMPARISION in checker ");  end  
					//	4'b1101: begin checker_alu_out=shifter_operation(A_in_tb,B_in_tb[7:4],B_in_tb[1:0]);  end //shifter
				//		4'b1110: begin checker_alu_out= end
						default: begin checker_alu_out=16'bz; end

				endcase
		end

end
/*
// shifting task
task shifter_operation(input [7:0]A,input [3:0]data,input [1:0]sel,    );
//input [7:0]A;          // data to shift or rotate
//input [3:0]data;       // how many times shift
//input [1:0]sel;        // rotate or shift selection
reg [7:0]temp;         // temparary storage
reg w1=8-data;         // when rotate>8 doing modulus
output reg [7:0]shifter_out;
output reg sflag;
		begin 
			case(sel)
			        2'b00: begin shifter_out=A<<data;  sflag=1'b1;		        end       // left shift
	        		2'b01: begin shifter_out=A>>data;  	sflag=1'b1; 		end       // right shift
		        	2'b10: begin shifter_out=rotateleft(A,data); sflag=1'b1;     end       // rotate left
			        2'b11: begin shifter_out=rotateright(A,data); sflag=1'b1;  end       // rotate right
        				default: Y=8'bz;
					
			endcase


end
endtask

*/

// -------------comparing DUT vs TB --------------------// 

always@(posedge clk )
begin
		if(design_alu_out==checker_alu_out)
		begin
			$display($time,"opcode=%0d A_in_tb = %b (%0d) B_in_tb=%b (%0d) design_ALU_out=%b (%0d) ::: check_ALU_out=%b (%0d)::: both are equal ",opcode_in_tb,A_in_tb,A_in_tb,B_in_tb,B_in_tb,design_alu_out,checker_alu_out,design_alu_out,checker_alu_out);
		end
		else
		begin
			$display($time,"opcode=%0d A_in_tb = %b (%0d) B_in_tb=%b (%0d) design_ALU_out=%b (%0d) ::: check_ALU_out=%b (%0d) ::: both are NOT equal ",opcode_in_tb,A_in_tb,A_in_tb,B_in_tb,B_in_tb,design_alu_out,checker_alu_out,design_alu_out,checker_alu_out);

		end


end


//----------------- finishing simulation --------------//

initial #1000 $finish;

endmodule

