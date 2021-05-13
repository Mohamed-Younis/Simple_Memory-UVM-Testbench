`ifndef MEM_SEQUENCE
`define MEM_SEQUENCE 

class mem_sequence extends uvm_sequence #(mem_transaction);

  `uvm_object_utils(mem_sequence)

  mem_transaction seq_item;

  function new (string name= "mem_sequence");
    super.new(name);
  endfunction

  task body();
    while (!test_done) begin
      seq_item = mem_transaction::type_id::create("seq_item");
      start_item(seq_item);
      if(!seq_item.randomize) begin
          `uvm_error("mem_sequence", "randomization failed");
      end
      finish_item(seq_item);
    end
  endtask
  
endclass

`endif
