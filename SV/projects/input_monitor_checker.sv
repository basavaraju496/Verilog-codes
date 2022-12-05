
/////////////////////////////input_monitor/////////////////////
class input_monitor;

virtual adder_intf h_vintf;   // virtual interface handler to get signals from driver
mailbox h_mbx;        // to put data from checker to the mailbox
transaction h_trans;   //transaction handle to get data into into transaction handle 
function new(virtual adder_intf h_vintf,mailbox h_mbx);       // to keep same as previous
	this.h_vintf = h_vintf;
	this.h_mbx = h_mbx;
endfunction

task run();
	begin
		//h_trans = new();
		forever
		begin
			@(h_vintf.cb_monitor)   // taking ips and ops with zero delay 
			h_trans = new();	
			h_trans.rst = h_vintf.cb_monitor.rst;  // taking reset from vintf
			h_trans.in1 = h_vintf.cb_monitor.in1;  // taking in1 from vintf
			h_trans.in2 = h_vintf.cb_monitor.in2;  // taking in2 from vintf

		/*	if(h_vintf.cb_monitor.rst == 0)
			begin*/
			//@(h_vintf.cb_monitor)
			h_trans.out = h_trans.in1 + h_trans.in2;   // checker logic
			
			h_mbx.put(h_trans);                   // keeping the all values in mailbox inorder to transfer to the scoreboard
		//	end

		end
	end	
endtask

endclass