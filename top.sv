module top;
  import uvm_pkg::*;
  import tb_pkg::*;

  bit clk;
  mem_interface mem_inf(clk);

  memory dut ( .clock(mem_inf.clock),
                .reset(mem_inf.reset),
                .address(mem_inf.address),
                .data_in(mem_inf.data_in),
                .data_out(mem_inf.data_out),
                .write(mem_inf.write),
                .read(mem_inf.read)
                ); 

  initial begin
    uvm_config_db #(virtual mem_interface)::set(null, "uvm_test_top","agent_interface", mem_inf);
  end

  initial 
    forever #5 clk = !clk;

  initial begin
    run_test();
  end
      
endmodule
