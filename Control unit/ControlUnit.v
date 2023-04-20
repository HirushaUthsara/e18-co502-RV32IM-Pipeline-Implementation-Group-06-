`timescale 1ns/100ps


module CONTROL_UNIT(INSTRUCTION, MUX1_SELECT, MUX2_SELECT, MUX3_SELECT, MUX4_SELECT,MEMREAD, MEMWRITE, BRANCH, JUMP, WRITEENABLE, ALUOP, IMME_SELECT);

    input [31:0] INSTRUCTION;
    output [4:0] ALUOP;
    output [1:0] MUX3_SELECT;
    output [2:0] IMME_SELECT;
    output MUX1_SELECT, MUX2_SELECT,MUX4_SELECT,MEMREAD, MEMWRITE, BRANCH, JUMP, WRITEENABLE, ALUOP;

    wire [6:0] OPCODE;
    wire [2:0] FUNCTION3;
    wire FUNCTION7A, FUNCTION7B;
    reg [1:0] MUX3_SELECT;
    reg MUX1_SELECT, MUX2_SELECT,MUX4_SELECT,MEMREAD, MEMWRITE, BRANCH, JUMP, WRITEENABLE, ALUOP;
    wire [8:0] SPECIALOP;
    reg [2:0] IMMEDIATE_SELECT, IMME_SELECT;
    reg [3:0] INTSTRUCTION_TYPE;
    reg [4:0] ALUOP;


    assign OPCODE = INSTRUCTION [6:0];
    assign FUNCTION3 = INSTRUCTION [14:12];
    assign FUNCTION7A = INSTRUCTION[30];
    assign FUNCTION7B = INSTRUCTION[25];

    // Genaral control signals
    always @(OPCODE) begin
        case(OPCODE)
            8'b00000000:begin   //nop instruction
                #1
                INTSTRUCTION_TYPE = 4'b1001;
                MUX1_SELECT = 1'bx;
                MUX4_SELECT = 1'bx;
                MUX3_SELECT = 2'bxx;
                MUX2_SELECT = 1'bx;
                WRITEENABLE = 1'b0;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b0;
                IMME_SELECT = 3'bxxx;
            end
            8'b00110011:begin   //R type instructions
                #1
                INTSTRUCTION_TYPE = 4'b1000;
                MUX1_SELECT = 1'b0;
                MUX4_SELECT = 1'b0;
                MUX3_SELECT = 2'b01;
                MUX2_SELECT = 1'b1;
                WRITEENABLE = 1'b1;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b0;
                IMME_SELECT = 3'bxxx;
            end
            8'b00010011:begin   //I type instructions
                #1
                INTSTRUCTION_TYPE = 4'b0111;
                MUX1_SELECT = 1'b0;
                MUX4_SELECT = 1'b0;
                MUX3_SELECT = 2'b01;
                MUX2_SELECT = 1'b0;
                WRITEENABLE = 1'b1;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b0;
                IMME_SELECT = 3'b010;
            end
            8'b00100011:begin   //S type instructions
                #1
                INTSTRUCTION_TYPE = 4'b0110;
                MUX1_SELECT = 1'b0;
                MUX4_SELECT = 1'b1;
                MUX3_SELECT = 2'b01;
                MUX2_SELECT = 1'b0;
                WRITEENABLE = 1'b0;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b1;
                BRANCH = 1'b0;
                JUMP = 1'b0;
                IMME_SELECT = 3'b001;
            end
            8'b00000011:begin   //I type instructions
                #1
                INTSTRUCTION_TYPE = 4'b0101;
                MUX1_SELECT = 1'b0;
                MUX4_SELECT = 1'b1;
                MUX3_SELECT = 2'b01;
                MUX2_SELECT = 1'b0;
                WRITEENABLE = 1'b1;
                MEMREAD = 1'b1;
                MEMWRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b0;
                IMME_SELECT = 3'b001;
            end
            8'b01100011:begin   //B type instructions
                #1
                INTSTRUCTION_TYPE = 4'b0100;
                MUX1_SELECT = 1'b0;
                MUX4_SELECT = 1'bx;
                MUX3_SELECT = 2'bxx;
                MUX2_SELECT = 1'b1;
                WRITEENABLE = 1'b0;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b0;
                BRANCH = 1'b1;
                JUMP = 1'b0;
                IMME_SELECT = 3'b000;
            end
            8'b01100111:begin   //jalr type instructions
                #1
                INTSTRUCTION_TYPE = 4'b0011;
                MUX1_SELECT = 1'b0;
                MUX4_SELECT = 1'b0;
                MUX3_SELECT = 2'b10;
                MUX2_SELECT = 1'b0;
                WRITEENABLE = 1'b1;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b1;
                IMME_SELECT = 3'b100;
            end
            8'b01101111:begin   //jal type instructions
                #1
                INTSTRUCTION_TYPE = 4'b0010;
                MUX1_SELECT = 1'b1;
                MUX4_SELECT = 1'b0;
                MUX3_SELECT = 2'b10;
                MUX2_SELECT = 1'b0;
                WRITEENABLE = 1'b1;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b1;
                IMME_SELECT = 3'b100;
            end
            8'b00010111:begin   //u type instructions
                #1
                INTSTRUCTION_TYPE = 4'b0001;
                MUX1_SELECT = 1'b1;
                MUX4_SELECT = 1'b0;
                MUX3_SELECT = 2'b01;
                MUX2_SELECT = 1'b0;
                WRITEENABLE = 1'b1;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b0;
                IMME_SELECT = 3'b011;
            end
            8'b00110111:begin   //u type instructions
                #1
                INTSTRUCTION_TYPE = 4'b0000;
                MUX1_SELECT = 1'bx;
                MUX4_SELECT = 1'b0;
                MUX3_SELECT = 2'b00;
                MUX2_SELECT = 1'bx; 
                WRITEENABLE = 1'b1;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b0;
                IMME_SELECT = 3'b011; 
            end
        endcase 
    end


    // specific control signals
    assign SPECIALOP = {FUNCTION7A, FUNCTION7B, FUNCTION3, INSTRUCTION_TYPE};
    always @(*) begin
        #1
        casex(SPECIALOP)
            9'bxxxxx0000: begin         //LUI
                ALUOP = 8'bxxxxxxxx;
            end
            9'bxxxxx0001: begin         //AUIPC
                ALUOP = 8'b00000000;
            end
            9'bxxxxx0010: begin         //JAL
                ALUOP = 8'b00000000;
            end
            9'bxxxxx0011: begin         //JALR
                ALUOP = 8'b00000000;
            end
            9'bxx0000100: begin         //BEQ
                ALUOP = 8'b00000001;
            end
            9'bxx0010100: begin         //BNE
                ALUOP = 8'b00000001;
            end
            9'bxx1000100: begin         //BLT
                ALUOP = 8'b00000001;
            end
            9'bxx1010100: begin         //BGE
                ALUOP = 8'b00000001;
            end
            9'bxx1100100: begin         //BLTU
                ALUOP = 8'b00000001;
            end
            9'bxx1110100: begin         //BGEU
                ALUOP = 8'b00000001;
            end


            // I type load and store type opcodes
            9'bxxxxx0101: begin         //Load instructions
                ALUOP = 8'b00000000;
            end
            9'bxxxxx0110: begin         //Store instructions
                ALUOP = 8'b00000000;
            end
            9'bxx0000111: begin         //ADDI
                ALUOP = 8'b00000000;
            end
            9'bxx0100111: begin         //SLTI
                ALUOP = 8'b00010000;
            end
            9'bxx0110111: begin         //SLTiU
                ALUOP = 8'b00000001;
            end
            9'bxx1000111: begin         //XORI
                ALUOP = 8'b00000100;
            end
            9'bxx1100111: begin         //ORI
                ALUOP = 8'b00000011;
            end
            9'bxx1110111: begin         //ANDI
                ALUOP = 8'b00000010;
            end
            9'b000010111: begin         //SLLI
                ALUOP = 8'b00000101;
            end
            9'b001010111: begin         //SRLI
                ALUOP = 8'b00000110;
            end
            9'b101010111: begin         //SRAI
                ALUOP = 8'b00000111;
            end
            9'b001011000: begin         //ADD
                ALUOP = 8'b00000000;
            end
            9'b101011000: begin         //SUB
                ALUOP = 8'b00000001;
            end
            9'b001011000: begin         //SLL
                ALUOP = 8'b00000101;
            end
            9'b001011000: begin         //SLT
                ALUOP = 8'b00010000;
            end
            9'b001011000: begin         //SLTU
                ALUOP = 8'b00010001;
            end
            9'b001011000: begin         //XOR
                ALUOP = 8'b00000100;
            end
            9'b001011000: begin         //SRL
                ALUOP = 8'b00000110;
            end
            9'b101011000: begin         //SRA 
                ALUOP = 8'b00000111;
            end
            9'b001011000: begin         //OR
                ALUOP = 8'b00000011;
            end
            9'b001011000: begin         //AND
                ALUOP = 8'b00000010;
            end

            // ALUOP for the M type instructions
            9'b011011000: begin         //MUL
                ALUOP = 8'b00001000;
            end
            9'b011011000: begin         //MULH
                ALUOP = 8'b00001001;
            end
            9'b011011000: begin         //MULHSU
                ALUOP = 8'b00001010;
            end
            9'b011011000: begin         //MULHU
                ALUOP = 8'b00001011;
            end
            9'b011011000: begin         //DIV
                ALUOP = 8'b00001100;
            end
            9'b011011000: begin         //DIVU
                ALUOP = 8'b00001101;
            end
            9'b011011000: begin         //REM
                ALUOP = 8'b00001110;
            end
            9'b011011000: begin         //REMU
                ALUOP = 8'b00001111;
            end
            9'b000001001: begin         //nop
                ALUOP = 8'bxxxxxxxx;
            end
        endcase
    end



endmodule

/* Verilog, casex is a keyword used to define a case statement with a case 
expression that can contain both X (unknown) and Z (high impedance) values. 
The casex statement is used to match a given pattern against multiple possible 
values of the case expression.*/