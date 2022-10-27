module tb_mux8by1;

reg clk=0;


// ------------------declaring signals----------------------//
reg [7:0]data_in_tb;

reg [2:0]selection_in_tb;

wire design_mux_out;

reg check_mux_out;

// ----------- module instantiation ---------------//

mux8to1 dut_instance(data_in_tb,selection_in_tb,design_mux_out,clk);

// ----------------- clock generation------------------//
always #5 clk=~clk;

// --------stimulus input ------------------//

always@(negedge clk) 
begin
	data_in_tb=$random;
	selection_in_tb=$random;

end

// --------------checker op getting ----------------------//

always@(posedge clk)
begin
	//check_mux_out=data_in_tb[selection_in_tb];    // mux virtual op in check 
	case(selection_in_tb)
	3'b000: begin check_mux_out=data_in_tb[0]; end 
	3'b001: begin check_mux_out=data_in_tb[1]; end 
	3'b010: begin check_mux_out=data_in_tb[2]; end 
	3'b011: begin check_mux_out=data_in_tb[3]; end 
	3'b100: begin check_mux_out=data_in_tb[4]; end 
	3'b101: begin check_mux_out=data_in_tb[5]; end 
	3'b110: begin check_mux_out=data_in_tb[6]; end 
	3'b111: begin check_mux_out=data_in_tb[7]; end 
	default : begin check_mux_out=8'bz; end

	endcase
end

// -------------comparing DUT vs TB --------------------// 

always@(negedge clk )
begin
		if(design_mux_out==check_mux_out)
		begin
			$display($time," data = %b sel=%b design_mux_out=%b ::: check_mux_out=%b ::: both are equal ",data_in_tb,selection_in_tb,design_mux_out,check_mux_out);
		end
		else
		begin
			$display($time,"data=%b sele=%b design_mux_out=%b ::: check_mux_out=%b ::: both are not equal ",data_in_tb,selection_in_tb,design_mux_out,check_mux_out);
		end


end


//----------------- finishing simulation --------------//

initial #1000 $finish;

endmodule
