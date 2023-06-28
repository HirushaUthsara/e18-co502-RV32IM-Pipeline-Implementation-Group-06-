module tbdemultiplexer;

  // Include libraries
  `include "IEEE/STD_LOGIC_1164.ALL"

  // Declare signals
  wire out0, out1, miss0, miss1, OUTCOME, MISS;
  reg [2:0] ADDR = 3'b000;

  // Instantiate demultiplexer component
  demultiplexer UUT (
    .out0(out0),
    .miss0(miss0),
    .out1(out1),
    .miss1(miss1),
    .ADDR(ADDR),
    .OUTCOME(OUTCOME),
    .MISS(MISS)
  );

  // Testbench process
  initial begin
    // Apply stimulus
    OUTCOME = 1'b1;
    MISS = 1'b1;
    ADDR = 3'b001;
    #10;
    ADDR = 3'b010;
    #10;
    ADDR = 3'b001;
    #10;
    ADDR = 3'b010;
    #10;
    // More input combinations can be given here

    // End simulation
    $finish;
  end

endmodule

// Define the demultiplexer component
module demultiplexer(
  output reg out0,
  output reg miss0,
  output reg out1,
  output reg miss1,
  input wire [2:0] ADDR,
  input wire OUTCOME,
  input wire MISS
);
  // Add your demultiplexer logic here
  // ...
endmodule
