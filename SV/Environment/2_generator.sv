
//====================GENERATOR======================//
class generator;

transaction ht;  // handler for transaction class

mailbox hmb1;    

// constructor

function new(mailbox hmb_new)
				hmb1=hmb_new;
		endfunction

task randomizer();
repeat(10) begin  //randomizing 10 times

				ht=new();
							//	if(ht.randomize());
								ht.randomize();
								hmb1.put(ht);
										$display("inside the generator data in trans handle = %p ",ht);
										$display("inside the generator data in mailbox 1 handle = %p ",hmb1);
					end
endtask

endclass
