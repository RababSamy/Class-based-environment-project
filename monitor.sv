import my_pkg::*;


class monitor;

	virtual intf vif;
  transaction trans;
	mailbox #(transaction) trans2mon_score;
  mailbox #(transaction) trans2mon_sub;

  function new(virtual intf vif, mailbox #(transaction) trans2mon_score, trans2mon_sub);
    this.vif = vif;
    this.trans = new();
    this.trans2mon_score = trans2mon_score;
    this.trans2mon_sub = trans2mon_sub;
  endfunction

   task mondata();
      #10;
      @(negedge vif.ckb)
      trans.rst = vif.rst;
      trans.write_en = vif.write_en;
      trans.read_en = vif.read_en;
      trans.data_in = vif.data_in;
      trans.address = vif.address;
      trans.valid_out = vif.valid_out;
      trans.data_out = vif.data_out;
      trans.Disp("Monitor");
      trans2mon_score.put(trans);
      trans2mon_sub.put(trans);
  endtask
endclass