module tbdemultiplexer;

  reg out0;
  reg out1;
  reg miss0;
  reg miss1;
  wire [2:0] ADDR;
  wire OUTCOME;
  wire MISS;

  // Define demultiplexer module
  demultiplexer UUT (
    .out0(out0),
    .miss0(miss0),
    .out1(out1),
    .miss1(miss1),
    .ADDR(ADDR),
    .OUTCOME(OUTCOME),
    .MISS(MISS)
  );

  // tb process
  initial begin
    OUTCOME <= 1'b1;
    MISS <= 1'b1;
    ADDR <= 3'b001;
    #(10);
    ADDR <= 3'b010;
    #(10);
    ADDR <= 3'b001;
    #(10);
    ADDR <= 3'b010;
    #(10);
    // more input combinations can be given here
    $finish;
  end

endmodule
