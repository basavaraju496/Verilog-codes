class transaction;

	rand bit [7:0] in1,in2;  // gernerating random 
	bit clk,rst;                 // giving manually
	bit [7:0] out;       

// constraint for ips to randomize

	constraint input_range {	in1 inside {[0:10]};
					in2 inside {[20:30]};
				}

endclass

  /*
   a.	 Fields required to generate the stimulus are declared in the transaction class
   b.Transaction class can also be used as a placeholder for the activity monitored by the monitor on DUT signals

1.the first step is to declare the Fields‘ in the transaction class
2. To generate the random stimulus, declare the fields as rand.
*/

