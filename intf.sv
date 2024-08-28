interface intf(input logic clk);

	parameter DATA_WIDTH = 32;
	parameter ADDRESS_WIDTH = 4;

	logic rst, write_en, read_en;
	logic [DATA_WIDTH-1:0] data_in;
	logic [ADDRESS_WIDTH-1:0] address;
	logic valid_out;
	logic [ADDRESS_WIDTH:0] data_out;
	
	clocking ckb @(posedge clk);
		default input #1step output #1step;
		input rst, write_en, read_en, data_in, address;
		output valid_out, data_out;
	endclocking
endinterface