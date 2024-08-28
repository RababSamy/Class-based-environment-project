import my_pkg::*;

class subscriber;

	transaction trans;
	mailbox #(transaction) trans2mon_sub;

	covergroup memo_group;

		rst: coverpoint trans.rst{
		bins low = {0};
		bins high = {1};
		bins toggle_l2h = (0=>1);
		bins toggle_h2l = (1=>0);
		}
		write_en: coverpoint trans.write_en{
		bins low = {0};
		bins high = {1};
		bins toggle_l2h = (0=>1);
		bins toggle_h2l = (1=>0);
		}
		read_en: coverpoint trans.read_en{
		bins low = {0};
		bins high = {1};
		bins toggle_l2h = (0=>1);
		bins toggle_h2l = (1=>0);
		}
		valid_out: coverpoint trans.valid_out{
		bins low = {0};
		bins high = {1};
		bins toggle_l2h = (0=>1);
		bins toggle_h2l = (1=>0);
		}
		data_in: coverpoint trans.data_in{
		bins din1 = {[0:1000]};
		bins din2 = {[1001:2000]};
		bins din3 = {[2001:$]};
		}
		data_out: coverpoint trans.data_out{
		bins dout1 = {[0:1000]};
		bins dout2 = {[1001:2000]};
		bins dout3 = {[2001:$]};
		}
		cross_en: cross trans.read_en, trans.write_en;		
	endgroup

	function new(mailbox #(transaction) trans2mon_sub);
		this.trans2mon_sub = trans2mon_sub;
		memo_group =new();
	endfunction
	
	task covercollec();
			trans2mon_sub.get(trans);
			memo_group.sample();
			trans.Disp("Subscriber");
			$display("Coverage collection: done");
	endtask

endclass