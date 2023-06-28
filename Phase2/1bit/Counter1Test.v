module Counter1Test;

  // Declare inputs and outputs
  reg CLOCK;
  reg INIT;
  reg OUTCOME;
  reg MISS;
  wire PREDICTION;

  // Define the clock period
  // real clk_period = 10.0; // Time in ns

  // Instantiate the counterOne module
  counterOne uut (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .MISS(MISS),
    .PREDICTION(PREDICTION)
  );

  // Toggle the clock with the specified period
  initial begin
    $dumpfile("Counter1Test.vcd"); // Set the waveform output file
    $dumpvars(0, Counter1Test); // Dump all signals in the module

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
    OUTCOME <= 0;
    #10;
    OUTCOME <= 1;
    MISS <= 1;
    #10;
    OUTCOME <= 1;
    MISS <= 0;
    #10;
    // Add more stimulus code here
    $finish;
  end

endmodule
