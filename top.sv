import my_pkg::*;

module top;

	bit clk, rst;
	always #5 clk = ~clk;
	int n_iterations = 200;

	intf memo_if(clk);
	mem #(.DATA_WIDTH(32), .ADDRESS_WIDTH(4)) memo (.intrf(memo_if));

	env envt = new(memo_if);

	initial begin
			envt.run(n_iterations);
	end

endmodule


