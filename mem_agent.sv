`ifndef MEM_AGENT
`define MEM_AGENT

class mem_agent extends uvm_agent;

  `uvm_component_utils(mem_agent)

  uvm_analysis_port #(mem_transaction) ap;

  mem_driver driver;
  mem_monitor monitor;
  mem_sequencer sequencer;
  agent_config a_config;
  mem_fc fc;


  function new (string name = "mem_agent", uvm_component parent = null);
      super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);

      ap = new("ap", this);
      if(!uvm_config_db #(agent_config)::get(this, "", "agent_config", a_config)) begin
          `uvm_fatal("a_config", "Can't get config for agent");
      end    
      if(a_config.active == 1) begin 
          driver = mem_driver::type_id::create("driver", this);
          sequencer = mem_sequencer::type_id::create("sequencer", this);
      end
      monitor = mem_monitor::type_id::create("monitor", this);
      fc = mem_fc::type_id::create("fc", this);


  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
      if(a_config.active == 1) begin
          driver.seq_item_port.connect(sequencer.seq_item_export);
      end
      monitor.m_analysis_port.connect(ap);
      monitor.m_analysis_port.connect(fc.analysis_export);
  endfunction : connect_phase

endclass

`endif
