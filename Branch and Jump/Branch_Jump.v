// Define timescale
`timescale 1ns/100ps

// Declare module BRANCH_JUMP with input and output ports
module BRANCH_JUMP(RESET,                   // reset signal
                    BRANCH_ADDR,            // branch address from PC
                    ALU_JUMP_IMM,           // jump address from ALU
                    FUNCTION3,              // control signal for branching operation
                    BRANCH,                 // control signal for branching
                    JUMP,                   // control signal for jumping
                    ZERO,                   // result of the ALU is zero
                    SIGN_BIT,               // sign bit of the result of the ALU
                    SLTU_BIT,               // SLTU bit of the result of the ALU
                    BRANCH_JUMP_OUT,        // output branch/jump address
                    BRANCH_JUMP_MUX         // output multiplexed control signal
                    );

    // Declare input ports
    input [31:0] BRANCH_ADDR, ALU_JUMP_IMM;                     // 32-bit branch address, 32-bit jump address from ALU
    input [2:0] FUNCTION3;                                      // 3-bit control signal for branching operation
    input RESET, BRANCH, JUMP, ZERO, SIGN_BIT, SLTU_BIT;        // control signals for reset, branching, and jumping, result of the ALU for zero, sign bit, and SLTU bit

    // Declare output ports
    output reg BRANCH_JUMP_MUX;         // multiplexed control signal
    output reg [31:0] BRANCH_JUMP_OUT;  // output branch/jump address

    // Declare intermediate wires for each type of branching operation
    wire BEQ, BGE, BNE, BLT, BLTU, BGEU;

    // Assign the value of each wire based on the FUNCTION3 control signal and the result of the ALU
    assign #1 BEQ= (~FUNCTION3[2]) & (~FUNCTION3[1]) &  (~FUNCTION3[0]) & ZERO;
    assign #1 BGE= (FUNCTION3[2]) & (~FUNCTION3[1]) &  (FUNCTION3[0]) & (~SIGN_BIT);
    assign #1 BNE= (~FUNCTION3[2]) & (~FUNCTION3[1]) &  (FUNCTION3[0]) & (~ZERO);
    assign #1 BLT= (FUNCTION3[2]) & (~FUNCTION3[1]) &  (~FUNCTION3[0]) & (~ZERO) & SIGN_BIT;
    assign #1 BLTU= (FUNCTION3[2]) & (FUNCTION3[1]) &  (~FUNCTION3[0]) & (~ZERO) & SLTU_BIT;
    assign #1 BGEU= (FUNCTION3[2]) & (FUNCTION3[1]) &  (FUNCTION3[0]) & (~SLTU_BIT);

    // #1 delay is used for specifies the time for the signal to propagate from the input of a logic gate to its output.


    always @(BRANCH,JUMP)begin
        // Multiplex the output signal depending on the control signals
        BRANCH_JUMP_MUX = (BRANCH & (BEQ|BGE|BNE|BLT|BLTU|BGEU)) | (JUMP);
    end

    always @(RESET) begin
        // Reset the multiplexed output signal
            BRANCH_JUMP_MUX = 1'b0;    
    end

    always @(*) begin
        #2  // this delay is used for specifies the time taken for a signal to be updated in a register or flip-flop. In this case, 
            //the delay of 2 nanoseconds is used to ensure that the output signal is updated after the input signals are stable.
        if(JUMP==1'b1)begin
            BRANCH_JUMP_OUT = ALU_JUMP_IMM;
        end
        else begin
            BRANCH_JUMP_OUT = BRANCH_ADDR;
        end
    end

endmodule