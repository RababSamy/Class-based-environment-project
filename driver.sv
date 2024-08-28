import my_pkg::*;

class driver;

	virtual intf vif;
    transaction trans;
	mailbox #(transaction) transdriv;

  	function new(virtual intf vif, mailbox #(transaction) transdriv);
  		this.vif = vif;
    	this.transdriv = transdriv;
  	endfunction

	task drivseq();
        transdriv.get(trans);
        trans.Disp("Driver");
        @(negedge vif.ckb);
        vif.rst = trans.rst;
        vif.write_en = trans.write_en;
        vif.read_en = trans.read_en;
        vif.address = trans.address;
        vif.data_in = trans.data_in;
    endtask
endclass