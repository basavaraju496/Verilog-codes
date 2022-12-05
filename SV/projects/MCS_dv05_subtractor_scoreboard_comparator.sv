
////////////////////////score_board/////////////////////
class scoreboard;

	mailbox h_mbx1,h_mbx2;   // created two h_mbx1,2 for storing the data from the dut and data from the ip monitor(checker)
	transaction h_trans1,h_trans2;   
	function new(mailbox h_mbx1,h_mbx2);
		this.h_mbx1 = h_mbx1;            // checker mbx
		this.h_mbx2 = h_mbx2;            // dut mbx
	endfunction

	task run();
	begin
		forever
		begin
		#1
			h_trans1 = new();    // to handle the checker data
			h_trans2 = new();    // to handle dut data
			h_mbx1.get(h_trans1);  // getting daata ffrom checker to trans1
			h_mbx2.get(h_trans2);  //getting data from dut to trans2

			if(h_trans1.out == h_trans2.out)
			$display($time,"PASS \t tb_out=%d \t dut_out=%d \t tb_in1=%d \t tb_in2=%d \t dut_in1=%d \t dut_in2=%d",h_trans1.out,h_trans2.out,h_trans1.in1,h_trans1.in2,h_trans2.in1,h_trans2.in2);
			else
			$display($time,"FAIL \t tb_out=%d \t dut_out=%d \t tb_in1=%d \t tb_in2=%d \t dut_in1=%d \t dut_in2=%d",h_trans1.out,h_trans2.out,h_trans1.in1,h_trans1.in2,h_trans2.in1,h_trans2.in2);

		end
	end
	endtask

endclass

