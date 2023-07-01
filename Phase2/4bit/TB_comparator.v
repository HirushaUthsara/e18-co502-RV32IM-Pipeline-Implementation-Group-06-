module comparatorTest;

  reg TOUTCOME;
  reg TPREDICTION;
  wire TMISS;

  // Define comparator module
  comparator uut (
    .OUTCOME(TOUTCOME),
    .PREDICTION(TPREDICTION),
    .MISS(TMISS)
  );

  // Define stimulus process
  initial begin
    #75;
    TOUTCOME = 1'b0;
    TPREDICTION = 1'b0;
    #50;
    TOUTCOME = 1'b0;
    TPREDICTION = 1'b0;
    #50;
    TOUTCOME = 1'b0;
    TPREDICTION = 1'b0;
    #50;
    TOUTCOME = 1'b1;
    TPREDICTION = 1'b0;
    #50;
    TOUTCOME = 1'b0;
    TPREDICTION = 1'b1;
    #50;
    TOUTCOME = 1'b0;
    TPREDICTION = 1'b0;
    #50;
    TOUTCOME = 1'b1;
    TPREDICTION = 1'b0;
    #50;
    TOUTCOME = 1'b1;
    TPREDICTION = 1'b1;
    #50;
    TOUTCOME = 1'b0;
    TPREDICTION = 1'b1;
    #50;
    TOUTCOME = 1'b0;
    TPREDICTION = 1'b0;
    #50;
    $finish;
  end

endmodule
