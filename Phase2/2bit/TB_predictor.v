module TwoCounterPredictorTest;

  // Inputs
  reg CLOCK;
  reg INIT;
  reg [2:0] ADDR;
  reg OUTCOME;

  // Outputs
  wire PREDICTION;
  wire [15:0] MISSES;

  // Clock
  reg TCLOCK;
  parameter clk_period = 10;

  // Instantiate the Unit Under Test (UUT)
  TwoCounterPredictor uut (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .ADDR(ADDR),
    .OUTCOME(OUTCOME),
    .PREDICTION(PREDICTION),
    .MISSES(MISSES)
  );

  // clk process definitions
  always begin
    TCLOCK <= 0;
    #(clk_period/2);
    TCLOCK <= 1;
    #(clk_period/2);
  end

  // Stimulus process
  initial begin
    #(15);

    INIT <= 1;
    #(10);
    INIT <= 0;

    ADDR <= 3'b001;
    OUTCOME <= 0;
    #(10);

    ADDR <= 3'b001;
    OUTCOME <= 0;
    #(10);

    ADDR <= 3'b001;
    OUTCOME <= 1;
    #(10);

    ADDR <= 3'b001;
    OUTCOME <= 0;
    #(10);

    ADDR <= 3'b001;
    OUTCOME <= 0;
    #(10);

    ADDR <= 3'b010;
    OUTCOME <= 0;
    #(10);

    ADDR <= 3'b001;
    OUTCOME <= 1;
    #(10);

    ADDR <= 3'b001;
    OUTCOME <= 1;
    #(10);

    ADDR <= 3'b001;
    OUTCOME <= 0;
    #(10);

    ADDR <= 3'b001;
    OUTCOME <= 0;
    #(10);

    ADDR <= 3'b010;
    OUTCOME <= 1;
    #(10);

    ADDR <= 3'b001;
    OUTCOME <= 0;
    #(10);

    ADDR <= 3'b001;
    OUTCOME <= 0;
    #(10);

    ADDR <= 3'b010;
    OUTCOME <= 1;
    #(10);

    ADDR <= 3'b010;
    OUTCOME <= 0;
    #(10);

    ADDR <= 3'b001;
    OUTCOME <= 0;
    #(10);

    $finish;
  end

endmodule
