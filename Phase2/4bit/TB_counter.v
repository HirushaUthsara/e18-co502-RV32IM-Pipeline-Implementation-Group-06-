module counterTest;

  reg TCLOCK;
  reg TINIT;
  reg TMISS;
  wire [15:0] TMISSES;

  // Define counter module
  counter uut (
    .CLOCK(TCLOCK),
    .INIT(TINIT),
    .MISS(TMISS),
    .MISSES(TMISSES)
  );

  // Define clock process
  always begin
    #5;
    TCLOCK = 1'b0;
    #5;
    TCLOCK = 1'b1;
  end

  // Define stimulus process
  initial begin
    #15;
    TINIT = 1'b1;
    #10;
    TINIT = 1'b0;
    TMISS = 1'b0;
    #10;
    TMISS = 1'b0;
    #10;
    TMISS = 1'b1;
    #10;
    TMISS = 1'b0;
    #10;
    TMISS = 1'b1;
    #10;
    TMISS = 1'b1;
    #10;
    TMISS = 1'b0;
    $finish;
  end

endmodule
