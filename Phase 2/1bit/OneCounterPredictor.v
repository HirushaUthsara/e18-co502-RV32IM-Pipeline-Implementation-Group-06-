module OneCounterPredictor(
    input wire CLOCK,
    input wire INIT,
    input wire [2:0] ADDR,
    input wire OUTCOME,
    output wire PREDICTION,
    output wire [15:0] MISSES
);

wire [15:0] miss_in;
wire [2:0] addr_out;
wire demout0;
wire demout1;
wire demmiss0;
wire demmiss1;
wire A;
wire B;
wire PREDICTION_wire;

demultiplexer demux (
    .out0(demout0),
    .miss0(demmiss0),
    .out1(demout1),
    .miss1(demmiss1),
    .ADDR(ADDR),
    .OUTCOME(OUTCOME),
    .MISS(miss_in[0])
);

counterOne firstCount (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(demout0),
    .MISS(demmiss0),
    .PREDICTION(A)
);

counterOne secondCount (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(demout1),
    .MISS(demmiss1),
    .PREDICTION(B)
);

Multiplexer mux (
    .A(A),
    .B(B),
    .ADDR(ADDR),
    .OUTPUT(PREDICTION_wire)
);

comparator comp (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .ADDR(ADDR),
    .PREDICTION(PREDICTION_wire),
    .ADDR_W(addr_out),
    .MISS(miss_in[0])
);

counter countM (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .MISS(miss_in[0]),
    .MISSES(MISSES)
);

assign PREDICTION = PREDICTION_wire;
assign miss_in[15:1] = 16'b0;

endmodule
