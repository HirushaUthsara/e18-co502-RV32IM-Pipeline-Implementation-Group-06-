module MuxTwo (
  input A,
  input B,
  input C,
  input D,
  input E,
  input F,
  input G,
  input H,
  input I,
  input J,
  input K,
  input L,
  input M,
  input N,
  input O,
  input P,
  input [3:0] column,
  output reg OUTPUT
);
  always @(*) begin
    case (column)
      4'b0000: OUTPUT = A;
      4'b0001: OUTPUT = B;
      4'b0010: OUTPUT = C;
      4'b0011: OUTPUT = D;
      4'b0100: OUTPUT = E;
      4'b0101: OUTPUT = F;
      4'b0110: OUTPUT = G;
      4'b0111: OUTPUT = H;
      4'b1000: OUTPUT = I;
      4'b1001: OUTPUT = J;
      4'b1010: OUTPUT = K;
      4'b1011: OUTPUT = L;
      4'b1100: OUTPUT = M;
      4'b1101: OUTPUT = N;
      4'b1110: OUTPUT = O;
      4'b1111: OUTPUT = P;
      default: OUTPUT = 1'b0;
    endcase
  end

endmodule
