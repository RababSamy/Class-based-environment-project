import my_pkg::*;

class sequencer#(parameter DATA_WIDTH = 32, ADDR_WIDTH = 4);

	transaction trans;
	mailbox #(transaction) transdriv;
	 

  	function new(mailbox #(transaction) transdriv);
    	this.transdriv = transdriv;
    	this.trans = new();
  	endfunction

	task genseq();
		void'(trans.randomize());
		trans.Disp("Sequencer");
		transdriv.put(trans);
	endtask

endclass