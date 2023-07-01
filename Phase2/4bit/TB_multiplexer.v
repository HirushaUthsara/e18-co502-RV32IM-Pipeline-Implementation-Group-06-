module tb_Multiplexer;

  reg A;
  reg B;
  reg [2:0] ADDR;
  wire Output;
  reg clk;
  reg [3:0] clk_period = 10;

  // Define Multiplexer module
  Multiplexer uut (
    .A(A),
    .B(B),
    .ADDR(ADDR),
    .OUTPUT(Output)
  );

  // clk process definitions
  always begin
    clk <= 1'b0;
    #(clk_period/2);
    clk <= 1'b1;
    #(clk_period/2);
  end

  // Stimulus process
  initial begin
    #100;
    ADDR <= 3'b001;
    A <= 1'b0;
    B <= 1'b0;
    #clk_period;
    ADDR <= 3'b010;
    A <= 1'b0;
    B <= 1'b0;
    #clk_period;
    ADDR <= 3'b010;
    A <= 1'b0;
    B <= 1'b1;
    #clk_period;
    ADDR <= 3'b010;
    A <= 1'b0;
    B <= 1'b0;
    #clk_period;
    ADDR <= 3'b001;
    A <= 1'b1;
    B <= 1'b0;
    #clk_period;
    ADDR <= 3'b010;
    A <= 1'b0;
    B <= 1'b1;
    #clk_period;
    ADDR <= 3'b001;
    A <= 1'b0;
    B <= 1'b1;
    #clk_period;
    ADDR <= 3'b001;
    A <= 1'b1;
    B <= 1'b1;
    #clk_period;
    ADDR <= 3'b001;
    A <= 1'b0;
    B <= 1'b1;
    #clk_period;
    ADDR <= 3'b010;
    A <= 1'b0;
    B <= 1'b0;
    #clk_period;
    $finish;
  end

endmodule
