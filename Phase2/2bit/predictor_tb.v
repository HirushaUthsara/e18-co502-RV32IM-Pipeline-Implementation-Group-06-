`timescale 1ns / 1ps

module TwoCounterPredictorTest;

reg TCLOCK;
reg TINIT;
reg [2:0] TADDR;
reg TOUTCOME;
wire TPREDICTION;
wire [15:0] TMISSES;

TwoCounterPredictor uut (
    .CLOCK(TCLOCK),
    .INIT(TINIT),
    .ADDR(TADDR),
    .OUTCOME(TOUTCOME),
    .PREDICTION(TPREDICTION),
    .MISSES(TMISSES)
);

initial begin
    TCLOCK = 0;
    forever begin
        #5 TCLOCK = ~TCLOCK;
    end
end

initial begin
    TINIT = 0;
    TADDR = 3'b000;
    TOUTCOME = 0;

    #15 TINIT = 1;
    #10 TINIT = 0;

    #10 TADDR = 3'b001;
    TOUTCOME = 0;
    #10 TADDR = 3'b001;
    TOUTCOME = 0;
    #10 TADDR = 3'b001;
    TOUTCOME = 1;
    #10 TADDR = 3'b001;
    TOUTCOME = 0;
    #10 TADDR = 3'b001;
    TOUTCOME = 0;

    #10 TADDR = 3'b010;
    TOUTCOME = 0;
    #10 TADDR = 3'b001;
    TOUTCOME = 1;
    #10 TADDR = 3'b001;
    TOUTCOME = 1;
    #10 TADDR = 3'b001;
    TOUTCOME = 0;
    #10 TADDR = 3'b001;
    TOUTCOME = 0;

    #10 TADDR = 3'b010;
    TOUTCOME = 1;
    #10 TADDR = 3'b001;
    TOUTCOME = 0;
    #10 TADDR = 3'b001;
    TOUTCOME = 0;
    #10 TADDR = 3'b010;
    TOUTCOME = 1;
    #10 TADDR = 3'b010;
    TOUTCOME = 0;
    #10 TADDR = 3'b001;
    TOUTCOME = 0;

    #100;
    $finish;
end

endmodule
