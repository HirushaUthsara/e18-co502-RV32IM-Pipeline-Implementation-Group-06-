module TwoCounterPredictorTest;

  reg CLOCK;
  reg INIT;
  reg [2:0] ADDR;
  reg OUTCOME;
  wire PREDICTION;
  wire [15:0] MISSES;

  // Define TwoCounterPredictor module
  TwoCounterPredictor uut (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .ADDR(ADDR),
    .OUTCOME(OUTCOME),
    .PREDICTION(PREDICTION),
    .MISSES(MISSES)
  );

  reg TCLOCK;
  reg TINIT;
  reg [2:0] TADDR;
  reg TOUTCOME;
  reg TPREDICTION;
  reg [15:0] TMISSES;
  reg clk_period = 10;

  // Define clock_process
  always begin
    TCLOCK <= 1'b0;
    #clk_period/2;
    TCLOCK <= 1'b1;
    #clk_period/2;
  end

  // Define testbench process
  initial begin
    TINIT <= 1'b1;
    #15;
    TINIT <= 1'b0;
    TADDR <= 3'b001;
    TOUTCOME <= 1'b0;
    #10;
    TADDR <= 3'b001;
    TOUTCOME <= 1'b0;
    #10;
    TADDR <= 3'b001;
    TOUTCOME <= 1'b1;
    #10;
    TADDR <= 3'b001;
    TOUTCOME <= 1'b0;
    #10;
    TADDR <= 3'b001;
    TOUTCOME <= 1'b0;
    #10;
    TADDR <= 3'b010;
    TOUTCOME <= 1'b0;
    #10;
    TADDR <= 3'b001;
    TOUTCOME <= 1'b1;
    #10;
    TADDR <= 3'b001;
    TOUTCOME <= 1'b1;
    #10;
    TADDR <= 3'b001;
    TOUTCOME <= 1'b0;
    #10;
    TADDR <= 3'b001;
    TOUTCOME <= 1'b0;
    #10;
    TADDR <= 3'b010;
    TOUTCOME <= 1'b1;
    #10;
    TADDR <= 3'b001;
    TOUTCOME <= 1'b0;
    #10;
    TADDR <= 3'b001;
    TOUTCOME <= 1'b0;
    #10;
    TADDR <= 3'b010;
    TOUTCOME <= 1'b1;
    #10;
    TADDR <= 3'b010;
    TOUTCOME <= 1'b0;
    #10;
    TADDR <= 3'b001;
    TOUTCOME <= 1'b0;
    #10;
    $finish;
  end

endmodule
