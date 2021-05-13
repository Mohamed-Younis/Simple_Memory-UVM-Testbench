`ifndef AGENT_CONFIG
`define AGNET_CONFIG

class agent_config extends uvm_object;

  `uvm_object_utils(agent_config);

  bit active = 1;
  virtual mem_interface agent_interface;

  function new (string name = "agent_config");
  super.new(name);
  endfunction : new

endclass 

`endif 
