module memory (
    input clock,
    input reset,
    input [2:0] address,
    input write,
    input read,
    input [7:0] data_in,
    output reg [7:0] data_out
    ); 


    reg [7:0] mem [8];

    always @(posedge clock or posedge reset ) begin
    if (reset)
    for(int i = 0; i < 8; i++) mem [i] = 8'h0;

    if (write)    mem[address] <= data_in;
    if (read)     data_out <= mem[address];
    end 
endmodule