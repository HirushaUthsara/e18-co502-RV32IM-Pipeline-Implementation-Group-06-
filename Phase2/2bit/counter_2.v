module counterTwo (
    input CLOCK,
    input INIT,
    input OUTCOME,
    input ENABLE,
    output wire PREDICTION
);

reg [2:0] count;
wire [0:0] predic;

always @(posedge CLOCK)
begin
    if (INIT)
        count <= 3'b000;
    else if (ENABLE)
    begin
        if (OUTCOME)
        begin
            if (count < 3)
                count <= count + 1;
        end
        else
        begin
            if (count > 0)
                count <= count - 1;
        end
    end
end

assign predic = count[1];

assign PREDICTION = predic;

endmodule
