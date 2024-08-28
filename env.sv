import my_pkg::*;

class env;

	sequencer #(32, 4) seq;
	driver driv;
	monitor mon;
	scoreboard score;
	subscriber sub;

	mailbox #(transaction) transdriv;
	mailbox #(transaction) trans2mon_score;
  	mailbox #(transaction) trans2mon_sub;

  	function new(virtual intf vif);
  		transdriv = new();
  		trans2mon_score = new();
  		trans2mon_sub = new();

  		seq = new(transdriv);
  		driv = new(vif, transdriv);
  		mon = new(vif, trans2mon_score, trans2mon_sub);
  		score = new(trans2mon_score);
  		sub = new(trans2mon_sub);
  	endfunction

  	task run(int n);
  		$display("Number of iterations = %0d", n);
  		for (int i = 1; i < n+1; i++) begin
  			$display("Iteration number: %0d", i);
  			fork
        	seq.genseq();
        	driv.drivseq();
        	mon.mondata();
        	score.check();
        	sub.covercollec();
        	join_none
			wait fork;
			$display("_____________________");
			#5;
        end
	endtask

endclass