module demuxTwo(
    enable0,
    out0,
    enable1,
    out1,
    // ...
    enable15,
    out15,
    column,
    OUTCOME,
    ENABLE
);
    
output enable0;
output out0;
output enable1;
output out1;
// ...
output enable15;
output out15;
input [3:0] column;
input OUTCOME;
input ENABLE;

reg out0, out1, out2, out3, out15;
reg enable0, enable1, enable2, enable3, enable15;

always @(ENABLE or column)
begin
    if (ENABLE)
    begin
        // Check the value of column and enable the corresponding output
        // Disable all other outputs by assigning '0' to their enable signals
        case (column)
            4'b0000:
                begin
                    out0 <= OUTCOME;
                    enable0 <= 1'b1;
                    enable1 <= 1'b0;
                    // ...
                    enable15 <= 1'b0;
                end
            4'b0001:
                begin
                    out1 <= OUTCOME;
                    enable1 <= 1'b1;
                    enable0 <= 1'b0;
                    // ...
                    enable15 <= 1'b0;
                end
            4'b0010:
                begin
                    out2 <= OUTCOME;
                    enable2 <= 1'b1;
                    enable0 <= 1'b0;
                    enable1 <= 1'b0;
                    // ...
                    enable15 <= 1'b0;
                end
            4'b0011:
                begin
                    out3 <= OUTCOME;
                    enable3 <= 1'b1;
                    enable0 <= 1'b0;
                    enable1 <= 1'b0;
                    enable2 <= 1'b0;
                    // ...
                    enable15 <= 1'b0;
                end
            // ...
            default:
                begin
                    // Handle the case when column doesn't match any expected values
                    // Set all outputs to '0' and their enable signals to '0'
                    out0 <= 1'b0;
                    enable0 <= 1'b0;
                    out1 <= 1'b0;
                    enable1 <= 1'b0;
                    // ...
                    out15 <= 1'b0;
                    enable15 <= 1'b0;
                end
        endcase
    end
    else
    begin
        // When ENABLE is '0', set all outputs to '0' and their enable signals to '0'
        out0 <= 1'b0;
        enable0 <= 1'b0;
        out1 <= 1'b0;
        enable1 <= 1'b0;
        // ...
        out15 <= 1'b0;
        enable15 <= 1'b0;
    end
end

endmodule
