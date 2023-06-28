module comparatorTest;

  // Declare inputs and outputs
  reg CLOCK;
  reg INIT;
  reg OUTCOME;
  reg [2:0] ADDR;
  reg PREDICTION;
  wire [2:0] ADDR_W;
  wire MISS;

  // Define the clock period
  // real clk_period = 10.0; // Time in ns

  // Instantiate the comparator module
  comparator uut (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .ADDR(ADDR),
    .PREDICTION(PREDICTION),
    .ADDR_W(ADDR_W),
    .MISS(MISS)
  );

  // Toggle the clock with the specified period
  initial begin
    forever begin
      #5;
      CLOCK <= 0;
      #5;
      CLOCK <= 1;
    end
  end

  // Stimulus process
  initial begin
    #15;
    INIT <= 1;
    #10;
    INIT <= 0;
    OUTCOME <= 0;
    PREDICTION <= 0;
    #10;
    OUTCOME <= 0;
    PREDICTION <= 0;
    #10;
    OUTCOME <= 0;
    PREDICTION <= 0;
    #10;
    OUTCOME <= 1;
    PREDICTION <= 0;
    #10;
    OUTCOME <= 0;
    PREDICTION <= 1;
    #10;
    OUTCOME <= 0;
    PREDICTION <= 0;
    #10;
    OUTCOME <= 1;
    PREDICTION <= 0;
    #10;
    OUTCOME <= 1;
    PREDICTION <= 1;
    #10;
    OUTCOME <= 0;
    PREDICTION <= 1;
    #10;
    OUTCOME <= 0;
    PREDICTION <= 0;
    $finish;
  end

endmodule
