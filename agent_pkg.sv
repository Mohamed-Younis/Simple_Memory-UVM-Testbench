package agent_pkg;
    import uvm_pkg::*;
   
    `include "uvm_macros.svh"

    bit test_done = 0;

    `include "agent_config.sv"
    `include "mem_transaction.sv"
    `include "mem_sequence.sv"
    typedef uvm_sequencer #(mem_transaction) mem_sequencer;
    `include "mem_driver.sv"
    `include "mem_monitor.sv"
    `include "mem_fc.sv"
    `include "mem_agent.sv"

endpackage

