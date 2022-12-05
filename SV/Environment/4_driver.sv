class driver;

virtual mux_intf h_vintf;   //  virtual??

mailbox hmb1;

transaction ht2;

function new(mux_intf h_vintf,mailbox mb1)
		hmb1=mb1;
		this.h_vintf=h_vintf;
		endfunction

task drive_to_dut;

forever @(h_vintf.cb_driver) // getting at every posedge  clk 
			ht2=new();
			hmb1.get(ht2);
			h_vintf.cb_driver.data_in<=ht2.data_in;  // sending data to intf 
			h_vintf.cb_driver.selection_in<=ht2.selection_in;    // sending data to intf  
			$display($time,"\t sending data to intf ");

endtask






endclass
