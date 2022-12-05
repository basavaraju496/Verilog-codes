class checker;

mailbox hmb2;

transaction ht;

static int count;

virtual mux_intf h_vintf;

// get data from intf



function new(mux_intf h_vintf,mailbox mb2);
				this.intf=intf;
					hmb2=mb2;
endfunction


task checker;
				begin 
						@(cb_monitor) // take ips @ pos edge clk
							ht=new();
							// take ips from intf and then give it to trans
							
							ht.data_in=h_vintf.cb_monitor.data_in;   // takin data_in
							ht.selection_in=h_vintf.cb_monitor.selection_in;   // taking the selection_in
							count++;
							$display("%0d time got data in checker ",count);
							task_checker;
							hmb2.put(ht)
				end
endtask

task task_checker;
//begin
//forever@(posedge clk)

//begin
	//check_mux_out=data_in_tb[selection_in_tb];    // mux virtual op in check 
	case(ht.selection_in_tb)
	3'b000: begin ht.mux_out=ht.data_in_tb[0]; end 
	3'b001: begin ht.mux_out=ht.data_in_tb[1]; end 
	3'b010: begin ht.mux_out=ht.data_in_tb[2]; end 
	3'b011: begin ht.mux_out=ht.data_in_tb[3]; end 
	3'b100: begin ht.mux_out=ht.data_in_tb[4]; end 
	3'b101: begin ht.mux_out=ht.data_in_tb[5]; end 
	3'b110: begin ht.mux_out=ht.data_in_tb[6]; end 
	3'b111: begin ht.mux_out=ht.data_in_tb[7]; end 
	default : begin ht.mux_out=8'bz; end

	endcase
//end
//end
endtask



endclass



