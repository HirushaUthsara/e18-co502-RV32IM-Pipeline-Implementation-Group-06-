module GBHTest;

  reg CLOCK;
  reg INIT;
  reg OUTCOME;
  wire [3:0] column;

  // Define GBH module
  GBH uut (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .column(column)
  );

  reg TCLOCK;
  reg TINIT;
  reg TOUTCOME;
  reg [3:0] Tcolumn;
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
    TOUTCOME <= 1'b0;
    #10;
    TOUTCOME <= 1'b0;
    #10;
    TOUTCOME <= 1'b1;
    #10;
    TOUTCOME <= 1'b0;
    #10;
    TOUTCOME <= 1'b1;
    #10;
    TOUTCOME <= 1'b1;
    #10;
    TOUTCOME <= 1'b0;
    #10;
    $finish;
  end

endmodule
