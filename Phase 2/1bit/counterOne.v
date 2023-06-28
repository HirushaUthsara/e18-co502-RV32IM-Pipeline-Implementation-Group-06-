module counterOne(
    input CLOCK,
    input INIT,
    input OUTCOME,
    input MISS,
    output wire PREDICTION
);

reg count;

always @(posedge CLOCK) begin
    if (INIT) begin
        count <= 1'b0;
    end else begin
        if (MISS) begin
            count <= ~count;
        end
    end
end

assign PREDICTION = count;

endmodule
