`ifndef MEM_BASIC_TEST
`define MEM_BASIC_TEST

class mem_basic_test extends uvm_test;

  `uvm_component_utils(mem_basic_test)

  mem_env env; 
  agent_config a_config;
  mem_sequence seq;


  function new(string name = "mem_basic_test", uvm_component parent = null);
      super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
      seq = mem_sequence::type_id::create("seq");
      a_config = agent_config::type_id::create("a_config", this);
      env = mem_env::type_id::create("env", this);
      
      if(!uvm_config_db #(virtual mem_interface)::get(this, "", "agent_interface", a_config.agent_interface))
          `uvm_fatal("env.agent_interface", "couldn't get the interface from top")
      uvm_config_db #(agent_config)::set(this, "env.agent*", "agent_config",a_config);

  endfunction : build_phase

  task run_phase(uvm_phase phase);
      phase.raise_objection(this, "----------------------TEST STAETED----------------------");
      seq.start(env.agent.sequencer);
      phase.drop_objection(this, "----------------------TEST FINISHED----------------------");
  endtask : run_phase

endclass
 
`endif
