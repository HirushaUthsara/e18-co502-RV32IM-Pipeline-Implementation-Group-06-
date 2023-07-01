module demultiplexer (
    output enable0,
    output enable1,
    input [2:0] ADDR
);
    
    reg enable0;
    reg enable1;
    
    always @(ADDR) begin
        case (ADDR)
            3'b001: begin
                enable0 <= 1'b1;
                enable1 <= 1'b0;
            end
            3'b010: begin
                enable1 <= 1'b1;
                enable0 <= 1'b0;
            end
            default: begin
                enable0 <= 1'b0;
                enable1 <= 1'b1;
            end
        endcase
    end
    
endmodule
