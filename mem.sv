module mem #(parameter DATA_WIDTH = 32,ADDRESS_WIDTH = 4)(intf intrf);

	localparam mem_depth = 2 ** ADDRESS_WIDTH;
	logic [DATA_WIDTH - 1 : 0] mem_array [mem_depth];
	
	always @(posedge intrf.clk or posedge intrf.rst) begin
		if (intrf.rst) begin
			for (int i = 0; i < mem_depth; i++) begin
				mem_array[i] <=0;
			end
			intrf.valid_out <= 0;
			intrf.data_out <=0;
		end
		else begin
			if (intrf.write_en && !(intrf.read_en)) begin
					mem_array[intrf.address] <= intrf.data_in;
					intrf.valid_out <= 0;
				end
			else if (!(intrf.write_en) && intrf.read_en) begin
					intrf.data_out <= mem_array[intrf.address];
					intrf.valid_out <= 1;
				end
			else begin
				intrf.data_out <= 'bx;
				intrf.valid_out <= 0;
			end
		end
	end
endmodule