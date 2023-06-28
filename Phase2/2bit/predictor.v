module TwoCounterPredictor (
    input CLOCK,
    input INIT,
    input [2:0] ADDR,
    input OUTCOME,
    output reg PREDICTION,
    output reg [15:0] MISSES
);

reg miss_in;
reg prediction_out;
wire [2:0] addr_out;
wire demout0, demout1;
wire demmiss0, demmiss1;
wire A, B;
wire demen0, demen1;

demultiplexer demux (
    .CLOCK(CLOCK),
    .out0(demout0),
    .enable0(demen0),
    .out1(demout1),
    .enable1(demen1),
    .ADDR(ADDR),
    .OUTCOME(OUTCOME)
);

counterTwo firstCount (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(demout0),
    .ENABLE(demen0),
    .PREDICTION(A)
);

counterTwo secondCount (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(demout1),
    .ENABLE(demen1),
    .PREDICTION(B)
);

Multiplexer mux (
    .A(A),
    .B(B),
    .ADDR(ADDR),
    .OUTPUT(prediction_out)
);

comparator comp (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .ADDR(ADDR),
    .PREDICTION(prediction_out),
    .ADDR_W(addr_out),
    .MISS(miss_in)
);

counter count (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .MISS(miss_in),
    .MISSES(MISSES)
);

always @(posedge CLOCK)
begin
    PREDICTION <= prediction_out;
end

endmodule
