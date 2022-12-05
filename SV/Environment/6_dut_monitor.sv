class dut_monitor;

mailbox hmb3; 

transaction ht;  // handler for transaction class

virtual mux_intf h_vintf;

function new(mux_intf h_vintf,mailbox mb3)
				this.h_vintf=h_vintf;
				hmb3=mb3;
		endfunction

task take_from_dut;

forever@(h_vintf.cb_monitor)
		begin

				ht=new():
				ht.data_in=h_vintf.cb_monitor.data_in;
				ht.selection_in=h_vintf.cb_monitor.selection_in;
				ht.mux_out=h_vintf.cb_monitor.mux_out;
				hmb3.put(ht);
		end


endtask

endclass
