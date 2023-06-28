module comparator(
    input CLOCK,
    input INIT,
    input OUTCOME,
    input [2:0] ADDR,
    input PREDICTION,
    output [2:0] ADDR_W,
    output MISS
);

assign MISS = OUTCOME ^ PREDICTION;
assign ADDR_W = ADDR;

endmodule
