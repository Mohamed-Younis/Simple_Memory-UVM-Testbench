interface mem_interface(input logic clock);
  logic [7:0] data_in;
  logic [7:0] data_out;
  logic [2:0] address;
  logic write;
  logic read;
  logic reset;
endinterface
