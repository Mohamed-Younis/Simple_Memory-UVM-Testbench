`ifndef MEM_ENV
`define MEM_ENV

class mem_env extends uvm_env;

  `uvm_component_utils(mem_env)
  mem_agent agent;
  mem_scoreboard scoreboard;

  function new(string name = "mem_env", uvm_component parent = null);
      super.new(name, parent);
  endfunction : new

  function void build_phase (uvm_phase phase);
      agent = mem_agent::type_id::create("agent", this);
      scoreboard = mem_scoreboard::type_id::create("scoreboard", this);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
      agent.ap.connect(scoreboard.analysis_export);
  endfunction : connect_phase

endclass

`endif
