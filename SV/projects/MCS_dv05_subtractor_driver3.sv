
//////////////////////driver///////////////////////////
class driver;

	transaction h_trans;    // creating handle for transaction for getting data fields from mailbox
	mailbox h_mbx;           // creating handle for mailbox handle  for getting data which is written in generator class
	virtual adder_intf h_vintf;     // creating handle for virtual interface  inordeer to communicate with the dut
	function new(virtual adder_intf h_vintf,mailbox h_mbx);    //
		this.h_vintf = h_vintf;
		this.h_mbx = h_mbx;
	endfunction
	task run();
	// giving data to the dut using virtual interface(static to dynamic)
	//	h_vintf.cb_driver.rst <= 0;  // giving reset at #0 output delay  from cb driver
	//	@(h_vintf.cb_driver) h_vintf.cb_driver.rst <= 1; 
	//	@(h_vintf.cb_driver) h_vintf.cb_driver.rst <= 0;
			forever// runs untill $finish comes
					begin
						@(h_vintf.cb_driver) // @posedge clk 
						h_trans = new();
						h_mbx.get(h_trans);      // getting data from the mailbox  and keeping in h_trans
						h_vintf.cb_driver.in1 <= h_trans.in1;     // giving ip1 to the dut 
						h_vintf.cb_driver.in2 <= h_trans.in2;       // giving ip2 to the dut 

						$display($time,"driver output is %p",h_trans);
						$display($time,"driver output is %p",h_mbx);
					end
	endtask

endclass

/*
Driver class is responsible for,

    receive the stimulus generated from the generator and drive to DUT by assigning transaction class values to interface signals.

 
 5                     driver  output is '{in1:1, in2:29, clk:0, rst:0, out:0}   in h_trans

                     5 driver output is '{items:'{}, maxItems:0, read_awaiting:null-pointer, write_awaiting:null-pointer, qtd:140668433866864}   in mailbox



	
 */
