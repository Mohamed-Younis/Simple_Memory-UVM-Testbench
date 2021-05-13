`ifndef MEM_DRIVER
`define MEM_DRIVE

class mem_driver extends uvm_driver #(mem_transaction);

  `uvm_component_utils(mem_driver)

  mem_transaction trn;
  agent_config a_config;
  virtual mem_interface d_interface;

  function new (string name, uvm_component parent = null);
      super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
      if(!uvm_config_db #(agent_config)::get(this, "", "agent_config",a_config)) begin
          `uvm_fatal("driver_if", "failed to get the driver interface")
      end
      d_interface = a_config.agent_interface;

  endfunction : build_phase 

  task run_phase(uvm_phase phase);
      d_interface.reset = 0;
      @(negedge d_interface.clock)
      d_interface.reset = 1;
      @(negedge d_interface.clock)
      d_interface.reset = 0;
      forever begin
          seq_item_port.get_next_item(trn);
          @(negedge d_interface.clock)
          d_interface.write   = trn.write;
          d_interface.read    = trn.read;
          d_interface.address = trn.address;
          d_interface.data_in = trn.data_in;
          $display("____________________________Driver____________________________");
          `uvm_info("Driver", trn.convert2string, UVM_LOW);
          seq_item_port.item_done();
      end
          
  endtask : run_phase

endclass


`endif
