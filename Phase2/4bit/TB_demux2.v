module tbdemuxTwo;

  reg enable0, enable1, enable2, enable3, enable4, enable5, enable6, enable7, enable8, enable9, enable10, enable11, enable12, enable13, enable14, enable15;
  reg [3:0] column;
  reg OUTCOME;
  reg ENABLE;

  reg o0, o1, o2, o3, o4, o5, o6, o7, o8, o9, o10, o11, o12, o13, o14, o15;

  // Define demuxTwo module
  demuxTwo UUT (
    .enable0(enable0), .out0(o0),
    .enable1(enable1), .out1(o1),
    .enable2(enable2), .out2(o2),
    .enable3(enable3), .out3(o3),
    .enable4(enable4), .out4(o4),
    .enable5(enable5), .out5(o5),
    .enable6(enable6), .out6(o6),
    .enable7(enable7), .out7(o7),
    .enable8(enable8), .out8(o8),
    .enable9(enable9), .out9(o9),
    .enable10(enable10), .out10(o10),
    .enable11(enable11), .out11(o11),
    .enable12(enable12), .out12(o12),
    .enable13(enable13), .out13(o13),
    .enable14(enable14), .out14(o14),
    .enable15(enable15), .out15(o15),
    .column(column),
    .OUTCOME(OUTCOME),
    .ENABLE(ENABLE)
  );

  // Define testbench process
  initial begin
    ENABLE <= 1'b1;
    column <= 4'b0010;
    OUTCOME <= 1'b1;
    #10;
    column <= 4'b1000;
    #10;
    ENABLE <= 1'b0;
    #10;
    ENABLE <= 1'b1;
    column <= 4'b0100;
    #10;
    column <= 4'b0010;
    OUTCOME <= 1'b0;
    #10;
    ENABLE <= 1'b0;
    // More input combinations can be given here
    $finish;
  end

endmodule
