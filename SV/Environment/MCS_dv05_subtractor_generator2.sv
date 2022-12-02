///////////////////////generator////////////////////
class generator;

	transaction h_trans;    // creating handle for transaction class for getting fields
	mailbox h_mbx;           // creating mailbox handle for putting data into fields

	function new(mailbox h_mbx);
		this.h_mbx = h_mbx;
	endfunction




	task task_to_randomize_data_in_generator();
		repeat(1)
		begin
			h_trans = new();           // creating memory (object) for transaction class
			if(h_trans.randomize());     // generating random inputs 
			h_mbx.put(h_trans);          // putting in mailbox  from fields in trans object
			$display($time,"generator data is %p",h_trans);
			$display($time,"generator data is %p",h_mbx);

		end
	endtask

endclass



/*Generator Class
#                    0generator data is 65538

Generator class is responsible for,

    1.Generating the stimulus by randomizing the transaction class
    2.Sending the randomized class to driver
	3.display data in generator class
//===============================address===================================//

#                    h_trans address is 131076
#                    h_mbx address is 65538

//===============================data %p===================================//
#                    0generator data is '{in1:3, in2:27, clk:0, rst:0, out:0}
#                    inside mbx handle data is '{items:'{@transaction@2}, maxItems:0, read_awaiting:null-pointer, write_awaiting:null-pointer, qtd:140668433866864}
/====================================%0p==================================//

#                    inside mbx handle is {@transaction@2} 0 null-pointer null-pointer 140668433866864


	*/









