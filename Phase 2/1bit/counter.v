module counter(
    input CLOCK,
    input INIT,
    input MISS,
    output [15:0] MISSES
);

reg [15:0] temp;

always @(posedge CLOCK) begin
    if (INIT) begin
        temp <= 16'b0000000000000000;
    end else begin
        if (MISS) begin
            if (temp == 16'b111111111111111) begin
                temp <= 16'b0000000000000000;
            end else begin
                temp <= temp + 1;
            end
        end
    end
end

assign MISSES = temp;

endmodule
