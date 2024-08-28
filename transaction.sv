class transaction #(parameter DATA_WIDTH = 32, ADDRESS_WIDTH = 4);

	//input signals

	rand logic rst, write_en, read_en;
	rand logic [DATA_WIDTH-1:0] data_in;
	rand logic [ADDRESS_WIDTH-1:0] address;

	//output signals

	logic valid_out;
	logic [DATA_WIDTH-1:0] data_out;

	//-----------------------------------------------------------//

	//random constraints

	//reset distribution
	constraint crst {rst dist{1:=10, 0:=90};}

	//write enable distribution
	constraint cwrite {write_en dist{1:=50, 0:=50};}

	//read enable distribution
	constraint cread {read_en dist{1:=50, 0:=50};}

	//input data distribution
	constraint cdat {data_in dist{[0:100]:/120, [101:1000]:/200, [1001:8000]:/250, [8001:$]:/180};}

	//address distribution
	constraint cadd {address dist{[0:3]:/10, [4:7]:/1, [8:11]:/1, [12:$]:/4};}

	//reset constraint
	constraint crst_data {if (rst)
		{write_en == 0;
		read_en == 0;
		address == 0;
		data_in == 0;}
		}

	//enable constraint

	constraint cen {(read_en && write_en) != 1;}

	//-----------------------------------------------------------//

	//display randomized data

	task Disp(string className);
		$display("%0s inputs:", className);
		$display("rst: %0d, write_en: %0d, read_en: %0d, data_in: %0d, address: %0d", rst, write_en, read_en, data_in, address);
		$display("time: %0d", $time);
		$display("----------");
	endtask
endclass