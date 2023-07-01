module Counter2Test;

  reg TCLOCK;
  reg TINIT;
  reg TOUTCOME;
  reg TMISS;
  wire TPREDICTION;
  reg [3:0] clk_period = 10;

  // Define counterTwo module
  counterTwo uut (
    .CLOCK(TCLOCK),
    .INIT(TINIT),
    .OUTCOME(TOUTCOME),
    .MISS(TMISS),
    .PREDICTION(TPREDICTION)
  );

  // clk process definitions
  always begin
    TCLOCK <= 1'b0;
    #(clk_period/2);
    TCLOCK <= 1'b1;
    #(clk_period/2);
  end

  // Stimulus process
  initial begin
    #(15);
    TINIT <= 1'b1;
    #(10);
    TINIT <= 1'b0;
    TMISS <= 1'b0;
    TOUTCOME <= 1'b0;
    #(10);
    TOUTCOME <= 1'b1;
    TMISS <= 1'b1;
    #(10);
    TOUTCOME <= 1'b1;
    TMISS <= 1'b1;
    #(10);
    TOUTCOME <= 1'b0;
    TMISS <= 1'b1;
    #(10);
    TOUTCOME <= 1'b0;
    TMISS <= 1'b1;
    #(10);
    TOUTCOME <= 1'b0;
    TMISS <= 1'b0;
    #(10);
    TOUTCOME <= 1'b1;
    TMISS <= 1'b1;
    #(10);
    $finish;
  end

endmodule
