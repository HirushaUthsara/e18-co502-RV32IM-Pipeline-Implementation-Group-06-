module tb_Multiplexer;

  // Inputs
  reg A;
  reg B;
  reg [2:0] ADDR;

  // Outputs
  wire Output;

  // Clock
  reg clk;
  parameter clk_period = 10;

  // Instantiate the Unit Under Test (UUT)
  Multiplexer uut (
    .A(A),
    .B(B),
    .ADDR(ADDR),
    .OUTPUT(Output)
  );

  // clk process definitions
  always begin
    clk <= 0;
    #(clk_period/2);
    clk <= 1;
    #(clk_period/2);
  end

  // Stimulus process
  initial begin
    // Hold reset state for 100 ns
    #(100);

    ADDR <= 3'b001;
    A <= 1'b0;
    B <= 1'b0;
    #(clk_period);

    ADDR <= 3'b010;
    A <= 1'b0;
    B <= 1'b0;
    #(clk_period);

    ADDR <= 3'b010;
    A <= 1'b0;
    B <= 1'b1;
    #(clk_period);

    ADDR <= 3'b010;
    A <= 1'b0;
    B <= 1'b0;
    #(clk_period);

    ADDR <= 3'b001;
    A <= 1'b1;
    B <= 1'b0;
    #(clk_period);

    ADDR <= 3'b010;
    A <= 1'b0;
    B <= 1'b1;
    #(clk_period);

    ADDR <= 3'b001;
    A <= 1'b0;
    B <= 1'b1;
    #(clk_period);

    ADDR <= 3'b001;
    A <= 1'b1;
    B <= 1'b1;
    #(clk_period);

    ADDR <= 3'b001;
    A <= 1'b0;
    B <= 1'b1;
    #(clk_period);

    ADDR <= 3'b010;
    A <= 1'b0;
    B <= 1'b0;
    #(clk_period);

    $finish;
  end

endmodule
