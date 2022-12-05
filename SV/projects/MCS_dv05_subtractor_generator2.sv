///////////////////////generator////////////////////
class generator;
	transaction h_trans;    // creating handle for transaction class for getting fields
	mailbox h_mbx;           // creating mailbox handle for putting data into fields
	function new(mailbox h_mbx);
		this.h_mbx = h_mbx;    //this.mbx tells in this mailbox 
		$display("inside generator constructor this.h_mbx=%p h_mbx=%p ",this.h_mbx,h_mbx);
	endfunction
	task run();
		repeat(10)   // it tells number of times to randomize
		begin
#10
			h_trans = new();           // creating memory (object) for transaction class
			if(h_trans.randomize());     // generating random inputs  and that randomized ips are stored in h_trans object (data)
			h_mbx.put(h_trans);          // putting in mailbox  from fields in h_trans object
			$display($time,"generator data is %p",h_trans);    // displaying h_trans object details
			$display($time,"generator data is %p",h_mbx);       // displaying the h_mbx object details

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









