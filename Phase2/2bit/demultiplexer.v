module demultiplexer (
    input CLOCK,
    output wire out0,
    output wire enable0,
    output wire out1,
    output wire enable1,
    input [2:0] ADDR,
    input OUTCOME
);

reg out0_reg, out1_reg;
reg enable0_reg, enable1_reg;

always @(posedge CLOCK)
begin
    case (ADDR)
        3'b001: begin
            out0_reg <= OUTCOME;
            enable0_reg <= 1'b1;
            out1_reg <= 1'b0;
            enable1_reg <= 1'b0;
        end
        3'b010: begin
            out1_reg <= OUTCOME;
            enable1_reg <= 1'b1;
            out0_reg <= 1'b0;
            enable0_reg <= 1'b0;
        end
        default: begin
            out0_reg <= 1'b0;
            out1_reg <= 1'b0;
            enable0_reg <= 1'b0;
            enable1_reg <= 1'b1;
        end
    endcase
end

assign out0 = out0_reg;
assign out1 = out1_reg;
assign enable0 = enable0_reg;
assign enable1 = enable1_reg;

endmodule
