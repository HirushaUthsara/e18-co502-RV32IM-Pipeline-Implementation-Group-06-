module Counter2Test;

  reg TCLOCK;
  reg TINIT;
  reg TOUTCOME;
  reg TMISS;
  wire TPREDICTION;

  // Define counterTwo module
  counterTwo uut (
    .CLOCK(TCLOCK),
    .INIT(TINIT),
    .OUTCOME(TOUTCOME),
    .MISS(TMISS),
    .PREDICTION(TPREDICTION)
  );

  // Define clock process
  always begin
    #5 TCLOCK = 1'b0;
    #5 TCLOCK = 1'b1;
  end

  // Define stimulus process
  initial begin
    #75;
    TINIT = 1'b1;
    #50;
    TINIT = 1'b0;
    TMISS = 1'b0;
    TOUTCOME = 1'b0;
    #50;
    TOUTCOME = 1'b1;
    TMISS = 1'b1;
    #50;
    TOUTCOME = 1'b1;
    TMISS = 1'b1;
    #50;
    TOUTCOME = 1'b0;
    TMISS = 1'b1;
    #50;
    TOUTCOME = 1'b0;
    TMISS = 1'b1;
    #50;
    TOUTCOME = 1'b0;
    TMISS = 1'b0;
    #50;
    TOUTCOME = 1'b1;
    TMISS = 1'b1;
    #50;
    $finish;
  end

endmodule
