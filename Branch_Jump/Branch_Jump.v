// Define timescale
`timescale 1ns/100ps

// Declare module BRANCH_JUMP with input and output ports
module BRANCH_JUMP(RESET,                   // reset signal
                    BRANCH_ADDR,            // branch address from PC
                    ALU_JUMP_IMM,           // jump address from ALU
                    FUNCTION3,              // control signal for branching operation
                    BRANCH,                 // control signal for branching
                    JUMP,                   // control signal for jumping
                    EQUAL,                   // result of the ALU is zero
                    SIGNED_LT,               // sign bit of the result of the ALU
                    UNSIGNED_LT,               // SLTU bit of the result of the ALU
                    BRANCH_JUMP_OUT,        // output branch/jump address
                    PCMUX,         // output multiplexed control signal
                    REG_FLUSH
                    );

    // Declare input ports
    input [31:0] BRANCH_ADDR, ALU_JUMP_IMM;                     // 32-bit branch address, 32-bit jump address from ALU
    input [2:0] FUNCTION3;                                      // 3-bit control signal for branching operation
    input RESET, BRANCH, JUMP, EQUAL, SIGNED_LT, UNSIGNED_LT;        // control signals for reset, branching, and jumping, result of the ALU for zero, sign bit, and SLTU bit

    // Declare output ports
    output reg PCMUX, REG_FLUSH;         // multiplexed control signal
    output reg [31:0] BRANCH_JUMP_OUT;  // output branch/jump address

    // Declare intermediate wires for each type of branching operation
    wire BEQ, BGE, BNE, BLT, BLTU, BGEU;

    // Assign the value of each wire based on the FUNCTION3 control signal and the result of the ALU
    assign #1 BEQ= (~FUNCTION3[2]) & (~FUNCTION3[1]) &  (~FUNCTION3[0]) & EQUAL;
    assign #1 BGE= (FUNCTION3[2]) & (~FUNCTION3[1]) &  (FUNCTION3[0]) & (~SIGNED_LT);
    assign #1 BNE= (~FUNCTION3[2]) & (~FUNCTION3[1]) &  (FUNCTION3[0]) & (~EQUAL);
    assign #1 BLT= (FUNCTION3[2]) & (~FUNCTION3[1]) &  (~FUNCTION3[0]) & (~EQUAL) & SIGNED_LT;
    assign #1 BLTU= (FUNCTION3[2]) & (FUNCTION3[1]) &  (~FUNCTION3[0]) & (~EQUAL) & UNSIGNED_LT;
    assign #1 BGEU= (FUNCTION3[2]) & (FUNCTION3[1]) &  (FUNCTION3[0]) & (~UNSIGNED_LT);

    // #1 delay is used for specifies the time for the signal to propagate from the input of a logic gate to its output.


    always @(*)begin
        // Multiplex the output signal depending on the control signals
        if(((BRANCH &(BEQ|BGE|BNE|BLT|BLTU|BGEU)) | (JUMP)) ==  1'b1)begin
                PCMUX = 1'b1;
                REG_FLUSH =  1'b1;
            end
            else begin
                PCMUX = 1'b0;
                REG_FLUSH =  1'b0;
            end
    end

    always @(RESET) begin
        // Reset the multiplexed output signal
            PCMUX = 1'b0;    
    end

    always @(*) begin
        
        if(JUMP==1'b1)begin
            BRANCH_JUMP_OUT = ALU_JUMP_IMM;
        end
        else begin
            BRANCH_JUMP_OUT = BRANCH_ADDR;
        end
    end

endmodule

/*
In a branch module, the REG_FLUSH signal is typically used to indicate that a pipeline flush is required due to a branch instruction. When a branch instruction is encountered, it may change the control flow of the program, causing the instructions in the pipeline to become invalid. In such cases, a pipeline flush is necessary to discard the incorrect instructions and fetch the correct instructions based on the branch target.
*/




module BRANCH_JUMP_TB;

    // Declare signals for test bench
    reg RESET;
    reg [31:0] BRANCH_ADDR, ALU_JUMP_IMM;
    reg [2:0] FUNCTION3;
    reg BRANCH, JUMP, EQUAL, SIGNED_LT, UNSIGNED_LT;
    wire PCMUX, REG_FLUSH;
    wire [31:0] BRANCH_JUMP_OUT;

    // Instantiate the module under test
    BRANCH_JUMP dut (
        .RESET(RESET),
        .BRANCH_ADDR(BRANCH_ADDR),
        .ALU_JUMP_IMM(ALU_JUMP_IMM),
        .FUNCTION3(FUNCTION3),
        .BRANCH(BRANCH),
        .JUMP(JUMP),
        .EQUAL(EQUAL),
        .SIGNED_LT(SIGNED_LT),
        .UNSIGNED_LT(UNSIGNED_LT),
        .PCMUX(PCMUX),
        .REG_FLUSH(REG_FLUSH),
        .BRANCH_JUMP_OUT(BRANCH_JUMP_OUT)
    );

    // Clock generation
    reg clk;
    always #5 clk = ~clk;

    // Test stimulus
    initial begin
        // Initialize inputs
        RESET = 0;
        BRANCH_ADDR = 32'h12345678;
        ALU_JUMP_IMM = 32'h98765432;
        FUNCTION3 = 3'b101;
        BRANCH = 1'b0;
        JUMP = 1'b0;
        EQUAL = 1'b1;
        SIGNED_LT = 1'b0;
        UNSIGNED_LT = 1'b0;

        // Apply reset
        RESET = 1;
        #10 RESET = 0;

        // Test case 1: Branching
        #20 BRANCH = 1'b1;
        #5;
        // Add your assertions or checks here for the expected outputs

        // Test case 2: Jumping
        #20 JUMP = 1'b1;
        #5;
        // Add your assertions or checks here for the expected outputs

        // Test case 3: No branching or jumping
        #20;
        // Add your assertions or checks here for the expected outputs

        // Add more test cases as needed

        $finish; // End simulation
    end

    // Monitor for displaying the outputs
    always @(posedge clk) begin
        $display("BRANCH_JUMP_OUT = %h, PCMUX = %b, REG_FLUSH = %b", BRANCH_JUMP_OUT, PCMUX, REG_FLUSH);
    end

endmodule
