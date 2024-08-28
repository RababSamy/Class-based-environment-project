import my_pkg::*;

class scoreboard#(parameter DATA_WIDTH = 32, ADDRESS_WIDTH = 4);

	transaction trans;
	mailbox #(transaction) trans2mon_score;
	
	function new(mailbox #(transaction) trans2mon_score);
		this.trans2mon_score = trans2mon_score;
	endfunction

	parameter mem_depth = ADDRESS_WIDTH ** 2;
	logic [DATA_WIDTH - 1 : 0] mem_array [mem_depth];

	task check();
			trans2mon_score.get(trans);
			trans.Disp("Scoreboard");
			if(trans.rst) begin
				foreach(mem_array[i])
					mem_array[i] = 0;
					trans.write_en = 0;
					trans.read_en = 0;
					trans.valid_out = 0;
				$display("Reset mode: ON" );
			end
			else if (trans.write_en && !(trans.read_en)) begin
				mem_array[trans.address] = trans.data_in;
				$display("Write mode: ON, Data: %0d, Address: %0d, Valid_out: %0d", trans.data_in, trans.address, trans.valid_out);
				end
			else if (trans.read_en && !(trans.write_en)) begin
					trans.data_out = mem_array[trans.address];
						$display("Read mode: ON, Data_expected: %0d, Data_actual: %0d, Address: %0d, Valid_out: %0d", mem_array[trans.address], trans.data_out, trans.address, trans.valid_out);
			end
			else if (!(trans.read_en) && !(trans.write_en)) begin
				$display("Enable: OFF, Data_in: %0d, Address: %0d, Data_out: %0d, Valid_out: %0d", trans.data_in, trans.address, trans.data_out, trans.valid_out);
			end
			else begin
				$error("Both enables: ON, cannot read and write simultaneously");
			end
	endtask

endclass