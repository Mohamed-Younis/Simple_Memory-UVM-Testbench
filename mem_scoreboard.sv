`ifndef MEM_SCOREBOARD
`define MEM_SCOREBOARD

class mem_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(mem_scoreboard)
  uvm_analysis_imp #(mem_transaction, mem_scoreboard ) analysis_export;
  bit [7:0] test_memory [8];
  mem_transaction saved_trn;
  bit data_read;

  function new (string name = "mem_scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    analysis_export = new("analysis_export", this);
    saved_trn = mem_transaction::type_id::create("saved_trn");
  endfunction : build_phase

  function void write(mem_transaction trn);
      if(data_read == 1) begin
        data_read = 0;
        `uvm_info("Scoreboard", $sformatf("\n Test memory data is %h at adress %d --- Dut data out is %h at adress %d \n", test_memory[saved_trn.address], saved_trn.address, trn.data_out, saved_trn.address ), UVM_LOW)
        if(trn.data_out != test_memory[saved_trn.address]) begin
            `uvm_error("Scoreboard error", "read data doen't match");
        end
      end

      if (trn.write) begin
        test_memory[trn.address] = trn.data_in;
        `uvm_info("Scoreboard", $sformatf("\n wrote %h at adress %d \n", trn.data_in, trn.address) , UVM_LOW)
      end
      else if(trn.read) begin
        saved_trn.copy(trn);
        data_read = 1;
      end
     `uvm_info("Scoreboard", trn.convert2string, UVM_HIGH);
  endfunction : write

endclass


`endif