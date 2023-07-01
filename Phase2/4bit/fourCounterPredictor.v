module FourCounterPredictor (
  input CLOCK,
  input INIT,
  input [2:0] ADDR,
  input OUTCOME,
  output PREDICTION,
  output [15:0] MISSES
);

  wire miss_in;
  wire prediction_out;
  wire demen0;
  wire demen1;
  wire [15:0] dem20o;
  wire [15:0] dem21o;
  wire [15:0] dem20en;
  wire [15:0] dem21en;
  wire A0, B0, C0, D0, E0, F0, G0, H0, I0, J0, K0, L0, M0, N0, O0, P0;
  wire A1, B1, C1, D1, E1, F1, G1, H1, I1, J1, K1, L1, M1, N1, O1, P1;
  wire [3:0] column;

  // CounterTwo module declaration
  module counterTwo (
    input CLOCK,
    input INIT,
    input OUTCOME,
    input ENABLE,
    output PREDICTION
  );

  // Multiplexer module declaration
  module Multiplexer (
    input A,
    input B,
    input [2:0] ADDR,
    output OUTPUT
  );

  // Demultiplexer module declaration
  module demultiplexer (
    output enable0,
    output enable1,
    input [2:0] ADDR
  );

  // Comparator module declaration
  module comparator (
    input OUTCOME,
    input PREDICTION,
    output MISS
  );

  // Counter module declaration
  module counter (
    input CLOCK,
    input INIT,
    input MISS,
    output [15:0] MISSES
  );

  // MuxTwo module declaration
  module MuxTwo (
    input A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P,
    input [3:0] column,
    output OUTPUT
  );

  // GBH module declaration
  module GBH (
    input CLOCK,
    input INIT,
    input OUTCOME,
    output [3:0] column
  );

  // Demultiplexer instantiation
  demultiplexer demux (
    .enable0(demen0),
    .enable1(demen1),
    .ADDR(ADDR)
  );

  // DemuxTwo instantiation for dem20
  demuxTwo demux20 (
    .enable0(dem20en[0]),
    .out0(dem20o[0]),
    .enable1(dem20en[1]),
    .out1(dem20o[1]),
    .enable2(dem20en[2]),
    .out2(dem20o[2]),
    .enable3(dem20en[3]),
    .out3(dem20o[3]),
    .enable4(dem20en[4]),
    .out4(dem20o[4]),
    .enable5(dem20en[5]),
    .out5(dem20o[5]),
    .enable6(dem20en[6]),
    .out6(dem20o[6]),
    .enable7(dem20en[7]),
    .out7(dem20o[7]),
    .enable8(dem20en[8]),
    .out8(dem20o[8]),
    .enable9(dem20en[9]),
    .out9(dem20o[9]),
    .enable10(dem20en[10]),
    .out10(dem20o[10]),
    .enable11(dem20en[11]),
    .out11(dem20o[11]),
    .enable12(dem20en[12]),
    .out12(dem20o[12]),
    .enable13(dem20en[13]),
    .out13(dem20o[13]),
    .enable14(dem20en[14]),
    .out14(dem20o[14]),
    .enable15(dem20en[15]),
    .out15(dem20o[15]),
    .ADDR(ADDR[1:0])
  );

  // DemuxTwo instantiation for dem21
  demuxTwo demux21 (
    .enable0(dem21en[0]),
    .out0(dem21o[0]),
    .enable1(dem21en[1]),
    .out1(dem21o[1]),
    .enable2(dem21en[2]),
    .out2(dem21o[2]),
    .enable3(dem21en[3]),
    .out3(dem21o[3]),
    .enable4(dem21en[4]),
    .out4(dem21o[4]),
    .enable5(dem21en[5]),
    .out5(dem21o[5]),
    .enable6(dem21en[6]),
    .out6(dem21o[6]),
    .enable7(dem21en[7]),
    .out7(dem21o[7]),
    .enable8(dem21en[8]),
    .out8(dem21o[8]),
    .enable9(dem21en[9]),
    .out9(dem21o[9]),
    .enable10(dem21en[10]),
    .out10(dem21o[10]),
    .enable11(dem21en[11]),
    .out11(dem21o[11]),
    .enable12(dem21en[12]),
    .out12(dem21o[12]),
    .enable13(dem21en[13]),
    .out13(dem21o[13]),
    .enable14(dem21en[14]),
    .out14(dem21o[14]),
    .enable15(dem21en[15]),
    .out15(dem21o[15]),
    .ADDR(ADDR[2:0])
  );

  // CounterTwo instantiation for counter0
  counterTwo counter0 (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .ENABLE(dem20o[0]),
    .PREDICTION(A0)
  );

  // CounterTwo instantiation for counter1
  counterTwo counter1 (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .ENABLE(dem20o[1]),
    .PREDICTION(B0)
  );

  // CounterTwo instantiation for counter2
  counterTwo counter2 (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .ENABLE(dem20o[2]),
    .PREDICTION(C0)
  );

  // CounterTwo instantiation for counter3
  counterTwo counter3 (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .ENABLE(dem20o[3]),
    .PREDICTION(D0)
  );

  // CounterTwo instantiation for counter4
  counterTwo counter4 (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .ENABLE(dem20o[4]),
    .PREDICTION(E0)
  );

  // CounterTwo instantiation for counter5
  counterTwo counter5 (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .ENABLE(dem20o[5]),
    .PREDICTION(F0)
  );

  // CounterTwo instantiation for counter6
  counterTwo counter6 (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .ENABLE(dem20o[6]),
    .PREDICTION(G0)
  );

  // CounterTwo instantiation for counter7
  counterTwo counter7 (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .ENABLE(dem20o[7]),
    .PREDICTION(H0)
  );

  // CounterTwo instantiation for counter8
  counterTwo counter8 (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .ENABLE(dem20o[8]),
    .PREDICTION(I0)
  );

  // CounterTwo instantiation for counter9
  counterTwo counter9 (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .ENABLE(dem20o[9]),
    .PREDICTION(J0)
  );

  // CounterTwo instantiation for counter10
  counterTwo counter10 (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .ENABLE(dem20o[10]),
    .PREDICTION(K0)
  );

  // CounterTwo instantiation for counter11
  counterTwo counter11 (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .ENABLE(dem20o[11]),
    .PREDICTION(L0)
  );

  // CounterTwo instantiation for counter12
  counterTwo counter12 (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .ENABLE(dem20o[12]),
    .PREDICTION(M0)
  );

  // CounterTwo instantiation for counter13
  counterTwo counter13 (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .ENABLE(dem20o[13]),
    .PREDICTION(N0)
  );

  // CounterTwo instantiation for counter14
  counterTwo counter14 (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .ENABLE(dem20o[14]),
    .PREDICTION(O0)
  );

  // CounterTwo instantiation for counter15
  counterTwo counter15 (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .ENABLE(dem20o[15]),
    .PREDICTION(P0)
  );

  // Counter instantiation
  counter counter (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .MISS(miss_in),
    .MISSES(MISSES)
  );

  // Multiplexer instantiation
  Multiplexer mux (
    .A(A0),
    .B(B0),
    .ADDR(ADDR),
    .OUTPUT(A1)
  );

  // MuxTwo instantiation
  MuxTwo muxTwo (
    .A(A1),
    .B(C0),
    .C(E0),
    .D(G0),
    .E(I0),
    .F(K0),
    .G(M0),
    .H(O0),
    .I(B1),
    .J(D1),
    .K(F1),
    .L(H1),
    .M(J1),
    .N(L1),
    .O(N1),
    .P(P1),
    .column(column),
    .OUTPUT(prediction_out)
  );

  // Comparator instantiation
  comparator comparator (
    .OUTCOME(OUTCOME),
    .PREDICTION(prediction_out),
    .MISS(miss_in)
  );

  // GBH instantiation
  GBH gbh (
    .CLOCK(CLOCK),
    .INIT(INIT),
    .OUTCOME(OUTCOME),
    .column(column)
  );

  assign PREDICTION = prediction_out;

endmodule

// CounterTwo module definition
module counterTwo (
  input CLOCK,
  input INIT,
  input OUTCOME,
  input ENABLE,
  output PREDICTION
);
  reg [1:0] state;

  always @(posedge CLOCK) begin
    if (INIT) begin
      state <= 2'b00;
    end else if (ENABLE) begin
      case (state)
        2'b00: state <= (OUTCOME) ? 2'b01 : 2'b00;
        2'b01: state <= (OUTCOME) ? 2'b10 : 2'b00;
        2'b10: state <= (OUTCOME) ? 2'b11 : 2'b01;
        2'b11: state <= (OUTCOME) ? 2'b11 : 2'b10;
      endcase
    end
  end

  assign PREDICTION = (state == 2'b10) || (state == 2'b11);

endmodule

// Multiplexer module definition
module Multiplexer (
  input A,
  input B,
  input [2:0] ADDR,
  output OUTPUT
);
  reg OUTPUT;

  always @(ADDR or A or B) begin
    case (ADDR)
      3'b000: OUTPUT <= A;
      3'b001: OUTPUT <= B;
      3'b010: OUTPUT <= A;
      3'b011: OUTPUT <= B;
      3'b100: OUTPUT <= A;
      3'b101: OUTPUT <= B;
      3'b110: OUTPUT <= A;
      3'b111: OUTPUT <= B;
    endcase
  end

endmodule

// Demultiplexer module definition
module demultiplexer (
  output enable0,
  output enable1,
  input [2:0] ADDR
);
  assign enable0 = (ADDR[2:0] == 3'b000) ? 1'b1 : 1'b0;
  assign enable1 = (ADDR[2:0] != 3'b000) ? 1'b1 : 1'b0;

endmodule

// Comparator module definition
module comparator (
  input OUTCOME,
  input PREDICTION,
  output MISS
);
  assign MISS = (OUTCOME != PREDICTION);

endmodule

// Counter module definition
module counter (
  input CLOCK,
  input INIT,
  input MISS,
  output [15:0] MISSES
);
  reg [15:0] count;

  always @(posedge CLOCK) begin
    if (INIT) begin
      count <= 16'b0;
    end else if (MISS) begin
      count <= count + 16'b1;
    end
  end

  assign MISSES = count;

endmodule

// GBH module definition
module GBH (
  input CLOCK,
  input INIT,
  input OUTCOME,
  output [2:0] column
);
  reg [2:0] gbh[15:0];

  always @(posedge CLOCK) begin
    if (INIT) begin
      gbh <= 16'b0;
    end else begin
      gbh <= {gbh[14:0], OUTCOME};
    end
  end

  assign column = gbh[2:0];

endmodule

// MuxTwo module definition
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
  output OUTPUT
);
  reg OUTPUT;

  always @(column or A or B or C or D or E or F or G or H or I or J or K or L or M or N or O or P) begin
    case (column)
      4'b0000: OUTPUT <= A;
      4'b0001: OUTPUT <= B;
      4'b0010: OUTPUT <= C;
      4'b0011: OUTPUT <= D;
      4'b0100: OUTPUT <= E;
      4'b0101: OUTPUT <= F;
      4'b0110: OUTPUT <= G;
      4'b0111: OUTPUT <= H;
      4'b1000: OUTPUT <= I;
      4'b1001: OUTPUT <= J;
      4'b1010: OUTPUT <= K;
      4'b1011: OUTPUT <= L;
      4'b1100: OUTPUT <= M;
      4'b1101: OUTPUT <= N;
      4'b1110: OUTPUT <= O;
      4'b1111: OUTPUT <= P;
    endcase
  end

endmodule

// DemuxTwo module definition
module demuxTwo (
  output enable0,
  output enable1,
  input [3:0] ADDR
);
  assign enable0 = (ADDR[3:0] == 4'b0000) ? 1'b1 : 1'b0;
  assign enable1 = (ADDR[3:0] != 4'b0000) ? 1'b1 : 1'b0;

endmodule
