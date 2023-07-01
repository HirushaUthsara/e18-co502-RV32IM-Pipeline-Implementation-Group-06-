module comparatorTest;

  reg TCLOCK;
  reg TINIT;
  reg TOUTCOME;
  reg [2:0] TADDR;
  reg TPREDICTION;
  wire [2:0] TADDRW;
  wire TMISS;
  reg [3:0] clk_period = 10;

  // Define comparator module
  comparator uut (
    .CLOCK(TCLOCK),
    .INIT(TINIT),
    .OUTCOME(TOUTCOME),
    .ADDR(TADDR),
    .PREDICTION(TPREDICTION),
    .ADDR_W(TADDRW),
    .MISS(TMISS)
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
    TOUTCOME <= 1'b0;
    TPREDICTION <= 1'b0;
    #(10);
    TOUTCOME <= 1'b0;
    TPREDICTION <= 1'b0;
    #(10);
    TOUTCOME <= 1'b0;
    TPREDICTION <= 1'b0;
    #(10);
    TOUTCOME <= 1'b1;
    TPREDICTION <= 1'b0;
    #(10);
    TOUTCOME <= 1'b0;
    TPREDICTION <= 1'b1;
    #(10);
    TOUTCOME <= 1'b0;
    TPREDICTION <= 1'b0;
    #(10);
    TOUTCOME <= 1'b1;
    TPREDICTION <= 1'b0;
    #(10);
    TOUTCOME <= 1'b1;
    TPREDICTION <= 1'b1;
    #(10);
    TOUTCOME <= 1'b0;
    TPREDICTION <= 1'b1;
    #(10);
    TOUTCOME <= 1'b0;
    TPREDICTION <= 1'b0;
    $finish;
  end

endmodule
