module counter (
    input CLOCK,
    input INIT,
    input MISS,
    output wire [15:0] MISSES
);

reg [15:0] temp;

always @(posedge CLOCK)
begin
    if (INIT)
        temp <= 16'b0000000000000000;
    else if (MISS)
    begin
        if (temp == 16'hFFFF)
            temp <= 16'b0000000000000000;
        else
            temp <= temp + 1;
    end
end

assign MISSES = temp;

endmodule
