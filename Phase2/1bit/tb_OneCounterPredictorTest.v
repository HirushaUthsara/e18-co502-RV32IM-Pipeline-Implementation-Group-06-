module tb_OneCounterPredictorTest;
  // Entity declaration
  // entity tb_OneCounterPredictorTest is
  // end tb_OneCounterPredictorTest;

  // Component declaration for the Unit Under Test (UUT)
  // component OneCounterPredictor
  //   Port(
  //     CLOCK : in std_logic;
  //     INIT : in std_logic;
  //     ADDR : in std_logic_vector (2 downto 0);
  //     OUTCOME : in std_logic;
  //     PREDICTION : out std_logic;
  //     MISSES : out std_logic_vector (15 downto 0)
  //   );
  // end component;

  // Inputs
  reg CLOCK = 1'b0;
  reg INIT = 1'b0;
  reg [2:0] ADDR = 3'b000;
  reg OUTCOME = 1'b0;

  // Outputs
  wire PREDICTION;
  wire [15:0] MISSES;

  // Constants
//   real clk_period = 10 ns;

  // Instantiate the Unit Under Test (UUT)
  OneCounterPredictor uut (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .ADDR(ADDR),
    .OUTCOME(OUTCOME),
    .PREDICTION(PREDICTION),
    .MISSES(MISSES)
  );

  // clk process definition
  always begin
    #5;
    CLOCK <= 1;
    #5;
    CLOCK <= 0;
  end

  // Stimulus process
  initial begin
    // wait for 15 ns;
    #15;

    INIT <= 1'b1;
    // wait for 10 ns;
    #10;
    INIT <= 1'b0;

    ADDR <= 3'b001;
    OUTCOME <= 1'b1;
    // wait for 10 ns;
    #10;

    ADDR <= 3'b010;
    OUTCOME <= 1'b1;
    // wait for 10 ns;
    #10;

    ADDR <= 3'b001;
    OUTCOME <= 1'b0;
    // wait for 10 ns;
    #10;

    ADDR <= 3'b001;
    OUTCOME <= 1'b0;
    // wait for 10 ns;
    #10;

    ADDR <= 3'b001;
    OUTCOME <= 1'b0;
    // wait for 10 ns;
    #10;

    ADDR <= 3'b010;
    OUTCOME <= 1'b0;
    // wait for 10 ns;
    #10;

    ADDR <= 3'b001;
    OUTCOME <= 1'b1;
    // wait for 10 ns;
    #10;

    ADDR <= 3'b001;
    OUTCOME <= 1'b1;
    // wait for 10 ns;
    #10;

    ADDR <= 3'b001;
    OUTCOME <= 1'b0;
    // wait for 10 ns;
    #10;

    ADDR <= 3'b001;
    OUTCOME <= 1'b0;
    // wait for 10 ns;
    #10;

    ADDR <= 3'b010;
    OUTCOME <= 1'b1;
    // wait for 10 ns;
    #10;

    ADDR <= 3'b001;
    OUTCOME <= 1'b0;
    // wait for 10 ns;
    #10;

    ADDR <= 3'b001;
    OUTCOME <= 1'b0;
    // wait for 10 ns;
    #10;

    ADDR <= 3'b010;
    OUTCOME <= 1'b1;
    // wait for 10 ns;
    #10;

    ADDR <= 3'b010;
    OUTCOME <= 1'b0;
    // wait for 10 ns;
    #10;

    ADDR <= 3'b001;
    OUTCOME <= 1'b0;
    // wait for 10 ns;
    #10;

    ADDR <= 3'b001;
    OUTCOME <= 1'b1;
    // wait for 10 ns;
    #10;

    ADDR <= 3'b001;
    OUTCOME <= 1'b0;
    // wait for 10 ns;
    #10;

    ADDR <= 3'b001;
    OUTCOME <= 1'b0;
    // wait for 10 ns;
    #10;

    $finish;
  end
  
  // Dump VCD file for GTKWave
  initial begin
    $dumpfile("tb_OneCounterPredictorTest.vcd");
    $dumpvars;
  end
  
  // Simulation end
  initial begin
    #150;
    $finish;
  end
endmodule
