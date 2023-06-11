`timescale 1ns/100ps


// module for the control unit
module CONTROL_UNIT(INSTRUCTION, ALUOP, IMME_SELECT, MUX1_SELECT, MUX2_SELECT, MUX3_SELECT, MUX4_SELECT, WRITEENABLE, MEMREAD, MEMWRITE, BRANCH, JUMP);


    // Inputs
    // INSTRUCTION: 32-bit instruction word
    
    // Outputs
    // ALUOP: 5-bit signal to control the ALU operation
    // MUX3_SELECT: 2-bit signal to select input for MUX3
    // IMME_SELECT: 3-bit signal to select type of immediate value
    // MUX1_SELECT: 1-bit signal to select input for MUX1
    // MUX2_SELECT: 1-bit signal to select input for MUX2
    // MUX4_SELECT: 1-bit signal to select input for MUX4
    // MEMREAD: 1-bit signal to enable memory read
    // MEMWRITE: 1-bit signal to enable memory write
    // BRANCH: 1-bit signal to enable branching
    // JUMP: 1-bit signal to enable jumping
    // WRITEENABLE: 1-bit signal to enable register writeback

    input [31:0] INSTRUCTION;
    output reg[4:0] ALUOP;
    output reg [2:0] IMME_SELECT;
    output reg MUX1_SELECT, MUX2_SELECT,MUX3_SELECT,MUX4_SELECT,MEMREAD, MEMWRITE, BRANCH, JUMP, WRITEENABLE;

    wire [6:0] OPCODE, FUNCTION7;
    wire [2:0] FUNCTION3;
    

// Assign signals from instruction word
    assign OPCODE = INSTRUCTION [6:0];
    assign FUNCTION3 = INSTRUCTION [14:12];
    assign FUNCTION7 = INSTRUCTION[31:25];

   always @(OPCODE, FUNCTION3, FUNCTION7) begin
        case(OPCODE)
            8'b00110011:begin #1
                IMME_SELECT = 3'bxxx;
                MUX1_SELECT = 1'b0;
                MUX2_SELECT = 1'b0;
                MUX3_SELECT = 1'b0;
                MUX4_SELECT = 1'b0;
                WRITEENABLE = 1'b1;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b0; 

               case({FUNCTION7, FUNCTION3})
                    9'b000000000: ALUOP = 8'b00000001;      //ADD   
                    9'b100000000: ALUOP = 8'b00000010;      //SUB       
                    9'b000000001: ALUOP = 8'b00000011;      //SLL     
                    9'b000000010: ALUOP = 8'b00000100;      //SLT    
                    9'b000000011: ALUOP = 8'b00000101;      //SLTU        
                    9'b000000100: ALUOP = 8'b00000110;      //XOR          
                    9'b000000101: ALUOP = 8'b00000111;      //SRL     
                    9'b100000101: ALUOP = 8'b00001000;      //SRA     
                    9'b000000110: ALUOP = 8'b00001001;      //OR         
                    9'b000000111: ALUOP = 8'b00001010;      //AND     
                    9'b000001000: ALUOP = 8'b00001011;      //MUL     
                    9'b000001001: ALUOP = 8'b00001100;      //MULH          
                    9'b000001010: ALUOP = 8'b00001101;      //MULHSU   
                    9'b000001011: ALUOP = 8'b00001110;      //MULHU           
                    9'b000001100: ALUOP = 8'b00001111;      //DIV      
                    9'b000001101: ALUOP = 8'b00010000;      //DIVU          
                    9'b000001110: ALUOP = 8'b00010001;      //REM        
                    9'b000001111: ALUOP = 8'b00010010;      //REMU   
            endcase 
            end

            8'b00000011: begin #1		            //Load instructions (LB, LH, LW, LBU, LHU)
                ALUOP = 8'b00000001;
                IMME_SELECT = 3'b000;
                MUX1_SELECT = 1'b0;
                MUX2_SELECT = 1'b1;
                MUX3_SELECT = 1'b0;
                MUX4_SELECT = 1'b1;
                WRITEENABLE = 1'b1;
                MEMREAD = 1'b1;
                MEMWRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b0;                    
            end

            8'b00010011: begin #1		           //ADDI, SLLI, SLTI, SLTIU, XORI, SLRI, SRAI, ORI, ANDI
                //ALUOP = 8'b00000001;
                IMME_SELECT = 3'b000;
                MUX1_SELECT = 1'b0;
                MUX2_SELECT = 1'b1;
                MUX3_SELECT = 1'b0;
                MUX4_SELECT = 1'b0;
                WRITEENABLE = 1'b1;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b0;

                case(FUNCTION3)
                    8'b00000000: ALUOP = 8'b00000001;                    //ADDI
                    8'b00000001: begin                                //SLLI
                        case(FUNCTION7)
                            8'b00000000: ALUOP = 8'b00000011;
                        endcase
                    end

                    8'b00000010: ALUOP = 8'b00000100;                    //SLTI
                    8'b00000011: ALUOP = 8'b00000101;                    //SLTIU
                    8'b00000100: ALUOP = 8'b00000110; 

                    8'b000101: begin                                //SLRI, SRAI
                        case(FUNCTION7)
                            8'b00000000: ALUOP = 8'b00000111;        //SRLI 
                            8'b00100000: ALUOP = 8'b00001000;        //SRAI     
                        endcase                        
                    end

                    8'b00000110: ALUOP = 8'b00001001;                    //ORI
                    8'b00000111: ALUOP = 8'b00001010;
                endcase
            end

            8'b01100111: begin #1		            //JALR
                ALUOP = 8'b00000001;
                IMME_SELECT = 3'b000;
                MUX1_SELECT = 1'b0;
                MUX2_SELECT = 1'b1;
                MUX3_SELECT = 1'b1;
                MUX4_SELECT = 1'b0;
                WRITEENABLE = 1'b1;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b1;                    
            end

            8'b00100011: begin #1		            //Store instructions (SB, SH, SW, SBU, SHU)
                ALUOP = 8'b00000001;
                IMME_SELECT = 3'b001;
                MUX1_SELECT = 1'b0;
                MUX2_SELECT = 1'b1;
                MUX3_SELECT = 1'b0;
                MUX4_SELECT = 1'bx;
                WRITEENABLE = 1'b0;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b1;
                BRANCH = 1'b0;
                JUMP = 1'b0;                    
            end

            8'b00010111: begin #1		            //AUIPC
                ALUOP = 8'b00000001;
                IMME_SELECT = 3'b010;
                MUX1_SELECT = 1'b1;
                MUX2_SELECT = 1'b1;
                MUX3_SELECT = 1'b0;
                MUX4_SELECT = 1'b0;
                WRITEENABLE = 1'b1;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b0;                    
            end

            8'b00110111: begin #1		            //LUI
                ALUOP = 8'b00000000;
                IMME_SELECT = 3'b010;
                MUX1_SELECT = 1'bx;
                MUX2_SELECT = 1'b1;
                MUX3_SELECT = 1'b0;
                MUX4_SELECT = 1'b0;
                WRITEENABLE = 1'b1;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b0;                    
            end

            8'b01100011: begin #1		            //Branch instructions
                ALUOP = 8'b00000010;
                IMME_SELECT = 3'b011;
                MUX1_SELECT = 1'b1;
                MUX2_SELECT = 1'b1;
                MUX3_SELECT = 1'b0;
                MUX4_SELECT = 1'bx;
                WRITEENABLE = 1'b0;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b0;
                BRANCH = 1'b1;
                JUMP = 1'b0;                    
            end

            8'b01101111: begin #1		            //JAl
                ALUOP = 8'b00000001;
                IMME_SELECT = 3'b100;
                MUX1_SELECT = 1'b1;
                MUX2_SELECT = 1'b1;
                MUX3_SELECT = 1'b1;
                MUX4_SELECT = 1'b0;
                WRITEENABLE = 1'b1;
                MEMREAD = 1'b0;
                MEMWRITE = 1'b0;
                BRANCH = 1'b0;
                JUMP = 1'b1;                    
            end  

        endcase
    
   end


endmodule

/* Verilog, casex is a keyword used to define a case statement with a case 
expression that can contain both X (unknown) and Z (high impedance) values. 
The casex statement is used to match a given pattern against multiple possible 
values of the case expression.*/

