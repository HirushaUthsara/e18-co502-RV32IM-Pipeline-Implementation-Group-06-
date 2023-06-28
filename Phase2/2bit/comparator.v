module comparator (
    input CLOCK,
    input INIT,
    input OUTCOME,
    input [2:0] ADDR,
    input PREDICTION,
    output wire [2:0] ADDR_W,
    output wire MISS
);

assign ADDR_W = ADDR;

assign MISS = OUTCOME ^ PREDICTION;

endmodule

