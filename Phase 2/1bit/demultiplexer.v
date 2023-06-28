module demultiplexer(
    output wire out0,
    output wire miss0,
    output wire out1,
    output wire miss1,
    input wire [2:0] ADDR,
    input wire OUTCOME,
    input wire MISS
);

assign out0 = (ADDR == 3'b001) ? OUTCOME : 1'b0;
assign miss0 = (ADDR == 3'b001) ? MISS : 1'b0;
assign out1 = (ADDR == 3'b010) ? OUTCOME : 1'b0;
assign miss1 = (ADDR == 3'b010) ? MISS : 1'b0;

endmodule
