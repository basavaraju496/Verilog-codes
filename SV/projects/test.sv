////////////////////2.test////////////////////////
class test;

	environment h_env;  //creating handle for environment
	virtual adder_intf h_vintf;  // creating handle for vintf inorder to take from top class
	function new(virtual adder_intf h_vintf);
		this.h_vintf = h_vintf;   // for making same interface to transferclk,data
		h_env = new(h_vintf);//passing the same interface to the environment and creating memory for environment
//		when  we call new in environment class  the handles are created for  mailboxes(3),generator ,driver,ip_mon,op_mon,scoreboard
	endfunction

	task run();
		h_env.run();  // calls the task in  environment which contain all class tasks kept in fork join inorder to run parallelly
	endtask

endclass
