class scoreboard;

mailbox  hmb2,hmb3;

transaction ht1,ht2;

function new(mailbox mb2,mb3)
		hmb2=mb2;
		hmb3=mb3;
		endfunction

task comparator;
				forever@(cb_monitor)
				begin
				ht1=new();
				ht2=new();
				hmb2.get(ht1);
				hmb3.get(ht2);
					if(ht1.mux_out == ht2.mux_out)
			$display($time,"PASS \t TB  data_in=%b selection_in=%0d mux_out=%b \n DUT  data_in=%b selection_in=%0d mux_out=%b ",ht1.data_in,ht1.selection_in,ht1.mux_out, ht2.data_in,ht2.selection_in,ht2.mux_out );
			else
			$display($time,"FAIL \t TB  data_in=%b selection_in=%0d mux_out=%b \n DUT  data_in=%b selection_in=%0d mux_out=%b ",ht1.data_in,ht1.selection_in,ht1.mux_out, ht2.data_in,ht2.selection_in,ht2.mux_out );

				end


endtask



endclass
