`ifndef MEM_MONITOR
`define MEM_MONITOR
class mem_monitor extends uvm_monitor;

  `uvm_component_utils(mem_monitor)

  uvm_analysis_port #(mem_transaction) m_analysis_port;

  virtual mem_interface m_interface;
  agent_config a_config;
  mem_transaction trn;


  function new (string name = "mem_monitor", uvm_component parent = null);
      super.new(name, parent);
  endfunction : new

  function void build_phase (uvm_phase phase);
      m_analysis_port = new("m_analysis_port" , this);
      if(!uvm_config_db #(agent_config)::get(this, "", "agent_config", a_config)) begin
          `uvm_fatal("m_interface", "Couldn't get the mem_interface")
      end
      m_interface = a_config.agent_interface;
  endfunction : build_phase

  task run_phase (uvm_phase phase);
      forever begin
        trn = mem_transaction::type_id::create("trn");
        @(negedge m_interface.clock)
        #1
        trn.read = m_interface.read;
        trn.write = m_interface.write;
        trn.data_in = m_interface.data_in;
        trn.address = m_interface.address;
        trn.data_out = m_interface.data_out;
       `uvm_info("Monitor", trn.convert2string, UVM_HIGH);
        m_analysis_port.write(trn);
      end

  endtask : run_phase
endclass

`endif
