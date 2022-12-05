/////////////////////////////3.environment/////////////////////////////
class environment;

	virtual adder_intf h_vintf;      // inorder to handle vintf recieved from test
	mailbox h_mbx_gen,h_mbx_ipmo,h_mbx_opmo;
    // 1.   mbx_gen for generator putting and driver getting 
      //2.    mbx_ip_monitor_checker to keep checker data in order to transmit the data to scoreboard
      //3.    mbx_op_monitor_dut to keep checker data in order to transmit the data to scoreboard

	generator h_gen;    // genertor class handler
	driver h_driv;          // driver class handler
	input_monitor h_ipmo;   // ip monitor class handler
	output_monitor h_opmo;   // op monitr class handler
	scoreboard h_scrbd;      // scoreboard class handler

function new(virtual adder_intf h_vintf);
	this.h_vintf = h_vintf;
	h_mbx_gen = new();   // creating memory for generator handle
	h_mbx_ipmo = new();  // creating memory for ipmo handle(checker)
	h_mbx_opmo = new();  // creating memory for opmo handle(dut op)
	h_gen = new(h_mbx_gen);            // passing the address of the  mail box 1(for putting) to the the generator 
	h_driv = new(h_vintf,h_mbx_gen);  // passing the address of the  mail box 1(for getting) ,vintf to the the driver 
	h_ipmo = new(h_vintf,h_mbx_ipmo);  // passing the address of the  mail box 2(for putting) ,vintf to the checker 
	h_opmo = new(h_vintf,h_mbx_opmo);   // passing the address of the  mail box 3(for putting) ,vintf to the the generator 
	h_scrbd = new(h_mbx_ipmo,h_mbx_opmo); // passing the address of the  mail box 2 ,mail box 3(for getting 2 datas) to the the generator 
endfunction

task run();
	fork
		h_gen.run();  // it has h_trans obj and random data kept into h_trans and kept that into mailbox1
		h_driv.run();  // it also has h_trans obj and takes data from mailbox1 and keep in h_trans
		h_ipmo.run();
		h_opmo.run();
		h_scrbd.run();
	join
endtask

endclass

