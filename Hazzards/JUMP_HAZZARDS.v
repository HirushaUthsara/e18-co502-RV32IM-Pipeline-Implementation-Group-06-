module JUMP_HAZZARDS(
    JUMP,
    FLUSH
);

    input JUMP;             // Input signal indicating a jump instruction
    output reg FLUSH;       // Output signal to initiate pipeline flush

    always @(*) begin
        if (JUMP) begin
            FLUSH = 1'b1;  // If jump instruction is detected, set flush signal to high
        end
        else begin
            FLUSH = 1'b0;  // Otherwise, keep flush signal low
        end
    end
    
endmodule

