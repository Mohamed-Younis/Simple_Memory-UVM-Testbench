`ifndef MEM_TRANSACTION
`define MEM_TRANSACTION

class mem_transaction extends uvm_sequence_item;

	`uvm_object_utils(mem_transaction)

	rand bit [7:0] data_in;
  bit [7:0] data_out;
	rand bit [2:0] address;
	rand bit write;
	rand bit read;

	constraint wr {write!= read;};
	function new ( string name = "mem_transaction");
		super.new(name);
	endfunction

	function void do_copy( uvm_object rhs);
		mem_transaction to_copy;
		if (!$cast(to_copy, rhs)) begin 
		`uvm_fatal("do_copy", "non matching transaction type");
		end
		super.do_copy(rhs);
		this.data_in  = to_copy.data_in;
		this.data_out = to_copy.data_out;
		this.address  = to_copy.address;
		this.read     = to_copy.read;
		this.write    = to_copy.write;
	endfunction : do_copy

	function mem_transaction do_clone(uvm_object rhs);
		mem_transaction to_clone;

		if (!$cast(to_clone, rhs)) begin 
		`uvm_fatal("do_clone", "non matching transaction type");
		end
		to_clone.do_copy(to_clone);
		return to_clone;
	endfunction : do_clone

	// function bit do_compare(uvm_object rhs, uvm_comparer comparer);
	//         mem_transaction to_compare;

	//         if (!$cast(to_compare, rhs)) return 0;

	//         return (super.do_compare(rhs, comparer)
	//                 && this.data_in  == to_compare.data_in
	//                 && this.data_out == to_compare.data_out
	//                 && this.address  == to_compare.address
	//                 && this.read     == to_compare.read
	//                 && this.write    == to_compare.write
	//                 );
	// endfunction : do_compare

	function string convert2string();
		string s;
		$sformat(s, "%s \n", super.convert2string());
		$sformat(s, "%s \n address: %0h \n write: %0d \n read: %0d \n data_in: %0h \n data_out:%0h \n" ,
									s, address, write, read, data_in, data_out );
		return s;
	endfunction : convert2string

	// function void do_print(uvm_printer printer);
	//         $display("--------------Memory Transaction--------------");
	//         $display(convert2string());
	//         $display("----------------------------------------------");
	// endfunction : do_print
endclass
`endif 
