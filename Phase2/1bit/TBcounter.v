module counterTest;

  // Declare inputs and outputs
  reg CLOCK;
  reg INIT;
  reg MISS;
  wire [15:0] MISSES;

  // Define the clock period
  // real clk_period = 10.0; // Time in ns

  // Instantiate the counter module
  counter uut (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .MISS(MISS),
    .MISSES(MISSES)
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
    MISS <= 0;
    #10;
    MISS <= 0;
    #10;
    MISS <= 1;
    #10;
    MISS <= 0;
    #10;
    MISS <= 1;
    #10;
    MISS <= 1;
    #10;
    MISS <= 0;
    $finish;
  end

endmodule
