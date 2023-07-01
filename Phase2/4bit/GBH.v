module GBH (
  input CLOCK,
  input INIT,
  input OUTCOME,
  output reg [3:0] column
);
  reg [3:0] temp;

  always @(posedge CLOCK) begin
    if (INIT) begin
      temp <= 4'b0000;
    end else begin
      column <= temp;
      temp[3:1] <= temp[2:0];
      temp[0] <= OUTCOME;
    end
  end

endmodule
