module counterTwo (
    input CLOCK,
    input INIT,
    input OUTCOME,
    input ENABLE,
    output PREDICTION
);
    
    reg [31:0] count;
    wire [0:0] predic;
    
    always @(posedge CLOCK) begin
        if (INIT) begin
            count <= 32'd0;
        end else begin
            if (ENABLE) begin
                if (OUTCOME) begin
                    if (count < 3) begin
                        count <= count + 1;
                    end
                end else begin
                    if (count > 0) begin
                        count <= count - 1;
                    end
                end
            end
        end
    end
    
    assign predic = count[0] / 2;
    assign PREDICTION = predic[0];

endmodule
