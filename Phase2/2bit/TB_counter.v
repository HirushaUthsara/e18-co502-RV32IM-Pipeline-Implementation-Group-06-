module counterTest;

  reg TCLOCK;
  reg TINIT;
  reg TMISS;
  wire [15:0] TMISSES;
  reg [3:0] clk_period = 10;

  // Define counter module
  counter uut (
    .CLOCK(TCLOCK),
    .INIT(TINIT),
    .MISS(TMISS),
    .MISSES(TMISSES)
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
    #(10);
    TMISS <= 1'b0;
    #(10);
    TMISS <= 1'b1;
    #(10);
    TMISS <= 1'b0;
    #(10);
    TMISS <= 1'b1;
    #(10);
    TMISS <= 1'b1;
    #(10);
    TMISS <= 1'b0;
    $finish;
  end

endmodule
