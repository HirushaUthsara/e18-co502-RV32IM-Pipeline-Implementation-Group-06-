module Multiplexer (
  input A,
  input B,
  input [2:0] ADDR,
  output reg OUTPUT
);
  always @(*) begin
    case (ADDR)
      3'b001: OUTPUT = A;
      3'b010: OUTPUT = B;
      default: OUTPUT = 1'b0;
    endcase
  end

endmodule
