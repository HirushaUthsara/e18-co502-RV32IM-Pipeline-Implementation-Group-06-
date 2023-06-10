module Sign_Zero_Extend(
    input [31:0] INSTRUCTION,
    input [2:0] SELECT,
    output reg [31:0] OUT
);
    reg [31:0] U_TYPE, J_TYPE, S_TYPE, B_TYPE, I_TYPE;

    always @(*) begin
        #2;  // Delay for 2 simulation cycles
        
        // U-Type: Zero-extend bits [31:12]
        U_TYPE = {INSTRUCTION[31:12], {12{1'b0}}};
        
        // J-Type: Concatenate bits [31], [19:12], [20], [30:21], and append a zero
        J_TYPE = {INSTRUCTION[31], INSTRUCTION[19:12], INSTRUCTION[20], INSTRUCTION[30:21], 1'b0};
        
        // S-Type: Concatenate bits [31], [30:25], [11:7]
        S_TYPE = {INSTRUCTION[31], INSTRUCTION[30:25], INSTRUCTION[11:7]};
        
        // B-Type: Concatenate bits [31], [7], [30:25], [11:8], and append a zero
        B_TYPE = {INSTRUCTION[31], INSTRUCTION[7], INSTRUCTION[30:25], INSTRUCTION[11:8], 1'b0};
        
        // I-Type: Check condition (INSTRUCTION[7:0] == 8'b0010011 && INSTRUCTION[14:12] == 3'b101)
        // If true, concatenate zeros with bits [24:20], otherwise concatenate bits [31], [30:20]
        I_TYPE = (INSTRUCTION[7:0] == 8'b0010011 && INSTRUCTION[14:12] == 3'b101) ? {27'b0, INSTRUCTION[24:20]} : {INSTRUCTION[31], INSTRUCTION[30:20]};
        
        // Assign OUT based on SELECT value
        case (SELECT)
            0: OUT = I_TYPE;  // I-Type
            1: OUT = S_TYPE;  // S-Type
            2: OUT = U_TYPE;  // U-Type
            3: OUT = B_TYPE;  // B-Type
            4: OUT = J_TYPE;  // J-Type
            default: OUT = 32'b0;  // Default: Assign zero to OUT
        endcase
    end
endmodule
