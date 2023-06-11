`timescale 1ns/100ps

module CONTROL_UNIT_TEST;

    // Inputs
    reg [31:0] INSTRUCTION;

    // Outputs
    wire [4:0] ALUOP;
    wire [1:0] MUX3_SELECT;
    wire [2:0] IMME_SELECT;
    wire MUX1_SELECT, MUX2_SELECT, MUX4_SELECT, MEMREAD, MEMWRITE, BRANCH, JUMP, WRITEENABLE;

    // Instantiate the module under test
    CONTROL_UNIT uut (
        .INSTRUCTION(INSTRUCTION),
        .ALUOP(ALUOP),
        .MUX3_SELECT(MUX3_SELECT),
        .IMME_SELECT(IMME_SELECT),
        .MUX1_SELECT(MUX1_SELECT),
        .MUX2_SELECT(MUX2_SELECT),
        .MUX4_SELECT(MUX4_SELECT),
        .MEMREAD(MEMREAD),
        .MEMWRITE(MEMWRITE),
        .BRANCH(BRANCH),
        .JUMP(JUMP),
        .WRITEENABLE(WRITEENABLE)
    );

    // Test cases
    initial begin

        // Test case 1: NOP instruction
        INSTRUCTION = 32'h00000000;
        #1;
        assert(ALUOP === 5'bxxxxx);
        assert(MUX3_SELECT === 2'bxx);
        assert(IMME_SELECT === 3'bxxx);
        assert(MUX1_SELECT === 1'bx);
        assert(MUX2_SELECT === 1'bx);
        assert(MUX4_SELECT === 1'bx);
        assert(MEMREAD === 1'b0);
        assert(MEMWRITE === 1'b0);
        assert(BRANCH === 1'b0);
        assert(JUMP === 1'b0);
        assert(WRITEENABLE === 1'b0);

        // Test case 2: R-type instruction
        INSTRUCTION = 32'h01308433;
        #1;
        assert(ALUOP === 5'b00000);
        assert(MUX3_SELECT === 2'b01);
        assert(IMME_SELECT === 3'bxxx);
        assert(MUX1_SELECT === 1'b0);
        assert(MUX2_SELECT === 1'b1);
        assert(MUX4_SELECT === 1'b0);
        assert(MEMREAD === 1'b0);
        assert(MEMWRITE === 1'b0);
        assert(BRANCH === 1'b0);
        assert(JUMP === 1'b0);
        assert(WRITEENABLE === 1'b1);

        // Test case 3: I-type instruction
        INSTRUCTION = 32'h00000513;
        #1;
        assert(ALUOP === 5'bxxxxx);
        assert(MUX3_SELECT === 2'b01);
        assert(IMME_SELECT === 3'b010);
        assert(MUX1_SELECT === 1'b0);
        assert(MUX2_SELECT === 1'b0);
        assert(MUX4_SELECT === 1'b0);
        assert(MEMREAD === 1'b0);
        assert(MEMWRITE === 1'b0);
        assert(BRANCH === 1'b0);
        assert(JUMP === 1'b0);
        assert(WRITEENABLE === 1'b1);

        // Test case 4: S-type instruction
        INSTRUCTION = 32;
    end
endmodule