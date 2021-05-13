`ifndef MEM_FC
`define MEM_FC

class mem_fc extends uvm_subscriber #(mem_transaction);

  `uvm_component_utils (mem_fc)
  mem_transaction trn;

  covergroup trn_coverage;

    adressCover : coverpoint trn.address iff(trn.write | trn.read)
      {}
    transitionsCover : coverpoint trn.write iff(trn.write | trn.read){
      bins transition[] = (0,1 => 0,1);
    }
    data_inCover : coverpoint trn.data_in iff(trn.write | trn.read){
      option.auto_bin_max = 3; 
    }
    data_outCover : coverpoint trn.data_out iff(trn.write | trn.read){
      option.auto_bin_max = 3; 
    }
  endgroup 

  function  new(string name = "mem_fc", uvm_component parent = null);
      super.new(name, parent);
      trn_coverage = new();

  endfunction 


  function void write (mem_transaction t);
      trn = t;
      trn_coverage.sample();
      if (trn_coverage.get_coverage() == 100) begin
        test_done =1;
        `uvm_info("FC_Moinitor", "xxxxxxxxxxx 100\% coverage reached xxxxxxxxxxx", UVM_LOW)
      end
  endfunction

endclass

`endif