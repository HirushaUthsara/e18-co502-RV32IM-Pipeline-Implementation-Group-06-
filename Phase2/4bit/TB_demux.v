module tbdemultiplexer;

  reg en0;
  reg en1;
  wire [2:0] ADDR;

  // Define demultiplexer module
  demultiplexer UUT (
    .enable0(en0),
    .enable1(en1),
    .ADDR(ADDR)
  );

  // Define testbench process
  initial begin
    ADDR <= 3'b001;
    #10;
    ADDR <= 3'b010;
    #10;
    ADDR <= 3'b001;
    #10;
    ADDR <= 3'b010;
    #10;
    // More input combinations can be given here
    $finish;
  end

endmodule
