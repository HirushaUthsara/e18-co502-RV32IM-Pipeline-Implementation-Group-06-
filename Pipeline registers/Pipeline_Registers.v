`timescale  1ns/100ps

// module for the first pipeline register
module PIPEREG1(CLK, 
            RESET, 
            NEXTPC, // next program counter value
            PC, 
            INSHIT, // Input signal used for control purposes.
            INSTRUCTION, 
            BUSYWAIT, // Input signal indicating whether the pipeline register should wait before updating its outputs
            PCOUT_NEXT, 
            PCOUT, 
            INSTROUT, 
            INSHITOUT);

    input [31:0] NEXTPC, PC, INSTRUCTION;
    input CLK, RESET, INSHIT, BUSYWAIT;

    output reg [31:0] PCOUT_NEXT, PCOUT, INSTROUT;
    output reg INSHITOUT;


// pipeline register operates on the positive edge of the clock signal
    always @(posedge CLK) begin
        #3
        if(!busywait)begin
            // assigning output values
            PCOUT_NEXT <= NEXTPC;
            PCOUT <= PC;
            INSTROUT <= INSTRUCTION;
            INSHITOUT <= INSHIT;
        end
    end

endmodule

/*
mux - pc mux
mux1- mux1
mux2- mux5
mux3- mux4
mux4- mux3
IMMGEN - MUX2
*/


// module for the second pipeline register
module PIPEREG2(CLK, RESET, BUSYWAIT,

            DESREG, FUNC, // Represents the destination register for an operation, Represents the function code for an instruction.
            
            MUX2_SELECT, WRITEENABLE, MUX4_SELECT, MEMWRITE, MEMREAD, 
            ALUOP, MUX3_SELECT, BRANCH, JUMP, MUX1_SELECT, // Indicates whether a branch and jump operation is enabled.

            PC, NEXTPC,

            DATA1, DATA2,

            IMMGEN_IN, // Represents the immediate value for an instruction.

            INSTHIT, // Represents an input signal used for control purposes.

            BRANCH_ADD, // Represents the address for a branch operation.

            DESREG_OUT, FUNCT_OUT, 

            MUX2_OUT, WRITEENABLE_OUT, MUX4_OUT, MEMWRITE_OUT, MEMREAD_OUT, 
            ALUOP_OUT, MUX3_OUT, BRANCH_OUT, JUMP_OUT, MUX1_OUT,

            PC_OUT, NEXTPC_OUT,

            DATA1_OUT, DATA2_OUT,

            IMMGEN_OUT,

            INSTHIT_OUT,

            BRANCH_ADD_OUT,
            );

// defining input ports
    input [31:0] PC, NEXTPC, DATA1, DATA2, IMMGEN_IN, BRANCH_ADD;
    input [4:0] DESREG, ALUOP;
    input [2:0]  FUNC;
    input [1:0]  MUX3_SELECT;
    input CLK, RESET, BUSYWAIT, MUX2_SELECT, WRITEENABLE, MUX4_SELECT, MEMWRITE, MEMREAD,
            BRANCH, JUMP, MUX1_SELECT, INSTHIT;

// defining the output ports
    output reg [31:0] PC_OUT, NEXTPC_OUT, DATA1_OUT, DATA2_OUT, BRANCH_ADD_OUT;
    output reg [4:0]  DESREG_OUT,  ALUOP_OUT;
    output reg [2:0]  FUNCT_OUT;
    output reg [1:0]  MUX3_OUT;
    output reg MUX2_OUT, WRITEENABLE_OUT, MUX4_OUT, MEMWRITE_OUT, MEMREAD_OUT, BRANCH_OUT, JUMP_OUT, MUX1_OUT, INSTHIT_OUT;

// considering the pipeline operation on positive edge of the clock
    always @(posedge CLK) begin
        #3 if(!BUSYWAIT)begin
            NEXTPC_OUT      <=  NEXTPC;
            PC_OUT          <=  PC;
            DATA1_OUT       <=  DATA1;
            DATA2_OUT       <=  DATA2;
            BRANCH_ADD_OUT  <=  BRANCH_ADD;
            DESREG_OUT      <=  DESREG;
            ALUOP_OUT       <=  ALUOP;
            FUNCT_OUT       <=  FUNC;
            MUX3_OUT        <=  MUX3_SELECT;
            MUX2_OUT        <=  MUX2_SELECT;
            WRITEENABLE_OUT <=  WRITEENABLE;
            MUX4_OUT        <=  MUX4_SELECT;
            MEMWRITE_OUT    <=  MEMWRITE;
            MEMREAD_OUT     <=  MEMREAD;
            BRANCH_OUT      <=  BRANCH;
            JUMP_OUT        <=  JUMP;
            MUX1_OUT        <=  MUX1_SELECT;
            INSTHIT_OUT     <=  INSHIT;
        end
    end

// resetting the insstruction hit signal
    always @(posedge CLK) begin
        if(RESET == 1'b1)begin
            INSHITOUT <=0;
        end
    end

endmodule


// module for the third pipeline register
module PIPEREG3(CLK, RESET, BUSYWAIT,
            
            DESREG, FUNCT,
            
            WRITEENABLE, MUX4_SELECT, MEMWRITE, MEMREAD,
            
            ALUOUT,
            
            DATA2,
            
            INSTHIT,
            
            DEREG_OUT, FUNCT_OUT, WRITEENABLE_OUT, MUX4_OUT, MEMWRITE_OUT, MEMREAD_OUT, ALU_OUT, DATA2_OUT, INSHITOUT);

// defining input ports
input [31:0] DATA2, ALUOUT;
input [4:0] DESREG;
input [2:0] FUNCT;
input CLK, RESET, BUSYWAIT, WRITEENABLE, MUX4_SELECT, MEMWRITE, MEMREAD,  INSTHIT;

// defining output ports
output reg [31:0] ALU_OUT, DATA2_OUT;
output reg [4:0]  DEREG_OUT;
output reg [2:0]  FUNCT_OUT;
output reg  WRITEENABLE_OUT, MUX4_OUT, MEMWRITE_OUT, MEMREAD_OUT, INSHITOUT;

// assigning values to the output ports
always @(posedge CLK) begin
    #3
    if(!BUSYWAIT)begin
        ALU_OUT         <= ALUOUT;
        DATA2_OUT       <= DATA2;
        DEREG_OUT       <= DESREG;
        FUNCT_OUT       <= FUNCT;
        WRITEENABLE_OUT <= WRITEENABLE;
        MUX4_OUT        <= MUX4_SELECT;
        MEMWRITE_OUT    <= MEMWRITE;
        MEMREAD_OUT     <= MEMREAD;
        INSHITOUT       <= INSTHIT;
    end
end


//resetting all values 
always @(posedge CLK) begin
    if(RESET == 1'b1)begin
        ALU_OUT         <= 0;
        DATA2_OUT       <= 0;
        DEREG_OUT       <= 0;
        FUNCT_OUT       <= 0;
        WRITEENABLE_OUT <= 0;
        MUX4_OUT        <= 0;
        MEMWRITE_OUT    <= 0;
        MEMREAD_OUT     <= 0;
        INSHITOUT       <= 0;
    end
end

endmodule


// module for the fourth pipeline register
module PIPEREG4(CLK, RESET,

                DESREG,
                
                WRITEENABLE, MUX4_SELECT,
                
                ALUOUT,
                
                DATAMEMOUT,
                
                INSHIT,
                
                DESREG_OUT, WRITEENABLE_OUT, MUX3_OUT, ALU_OUT, DATAMEM_OUT, INSTHIT_OUT);

// defining the input ports
    input [31:0] DATAMEMOUT, ALUOUT;
    input [4:0]  DESREG;
    input CLK, RESET, WRITEENABLE, MUX4_SELECT, INSHIT;

// defining the output ports
    output reg [31:0] ALU_OUT, DATAMEM_OUT, INSTHIT_OUT;
    output reg [4:0] DESREG_OUT;
    output reg  WRITEENABLE_OUT, MUX4_OUT, INSTHIT_OUT;

// assigning values to the output ports at the positive edge of the clock
    always @(posedge CLK)begin 
        #3 
        ALU_OUT             <=  ALUOUT;
        DATAMEM_OUT         <=  DATAMEMOUT;
        INSTHIT_OUT         <=  INSHIT;
        DESREG_OUT          <=  DESREG;
        WRITEENABLE_OUT     <=  WRITEENABLE;
        MUX4_OUT            <=  MUX4_SELECT;
        INSTHIT_OUT         <=  INSHIT;
    end   

// resetting the instruction out value
    always @(posedge CLK)begin
        if(RESET == 1'b1)begin
            INSHITOUT <= 0;
        end
    end 

endmodule