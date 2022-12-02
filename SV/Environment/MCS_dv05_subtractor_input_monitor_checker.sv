
/////////////////////////////input_monitor/////////////////////
class input_monitor;     // checker

virtual adder_intf h_vintf;    // getting data from virtual interface
mailbox h_mbx;                 // mailbox for putting data which will be given to score card
transaction h_trans;           // transaction for 
function new(virtual adder_intf h_vintf,mailbox h_mbx);
	this.h_vintf = h_vintf;
	this.h_mbx = h_mbx;
endfunction

task run();
	begin
		//h_trans = new();
		forever
		begin
			@(h_vintf.cb_monitor)                    
			h_trans = new();                     // creating memory for transaction for putting checker data op into mailbox
			h_trans.rst = h_vintf.cb_monitor.rst;
			h_trans.in1 = h_vintf.cb_monitor.in1;
			h_trans.in2 = h_vintf.cb_monitor.in2;

		/*	if(h_vintf.cb_monitor.rst == 0)
			begin*/
			//@(h_vintf.cb_monitor)
			h_trans.out = h_trans.in1 + h_trans.in2;     // checker op   getting into the trans handle
			h_mbx.put(h_trans);                         // putting data into the mailbox
		//	end

		end
	end	
endtask

endclass
