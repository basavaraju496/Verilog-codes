/*class transaction;

	rand bit [7:0] in1,in2;  // gernerating random 
	bit clk,rst;                 // giving manually
	bit [7:0] out;       

// constraint for ips to randomize

	constraint input_range {	in1 inside {[0:10]};
					in2 inside {[20:30]};
				}

endclass
*/

//========================================TRANSACTION==========================//
class transaction;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~INPUTS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
rand bit [7:0]data_in;      // 8 bit data
rand bit [2:0]selection_in;   // 3 bit selection line
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~OUTPUTS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
bit mux_out;   // 1 bit op

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~constraint for randomizing the ips~~~~~~~~~~~~~`//

constraint ip_range{ 

		data_in inside {[0:120]};
		selection_in inside{[1,5]};
}

endclass



