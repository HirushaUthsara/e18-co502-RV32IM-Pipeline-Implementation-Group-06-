`timescale  1ns/100ps

// module for the first pipeline register
module PIPEREG1(CLK, 
            RESET, 
			INSTRIN,
            NEXTPC, // next program counter value
            PC, 
			INSTROUT, 
			PCOUT_NEXT, 
			PCOUT,
            BUSYWAIT // Input signal indicating whether the pipeline register should wait before updating its outputs
            );

    input [31:0] NEXTPC, PC, INSTRIN;
    input CLK, RESET, BUSYWAIT;

    output reg [31:0] PCOUT_NEXT, PCOUT, INSTROUT;


// pipeline register operates on the positive edge of the clock signal
    always @(*) begin
        if(RESET)begin
            // assigning output values
            #1;
            INSTROUT = 32'd0;
            PCOUT_NEXT = 32'd0;
			PCOUT = 32'd0;
        end
    end

    always @ (*) begin
        if (BUSYWAIT == 1'b0 ) begin
			#2
            INSTROUT <= INSTRIN;
            PCOUT_NEXT <= NEXTPC;
		 	PCOUT <= PC;
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
module PIPEREG2(
    CLK,
	RESET,
	WRITE_ENABLE_IN,
	MUXDATAMEM_SELECT_IN,
	MEM_READ_IN,
	MEM_WRITE_IN,
	MUXJAL_SELECT_IN,
	ALUOP_IN,
	MUXIMM_SELECT_IN,
	MUXPC_SELECT_IN,
	BRANCH_IN,
	JUMP_IN,
	PC_DIRECT_OUT_IN,
	SIGN_ZERO_EXTEND,
	PC_PLUS_4_OUT_IN,
	OUT1_IN,
	OUT2_IN,
	RD_IN,
	FUNCT3_IN,
	WRITE_ENABLE_OUT,
	MUXDATAMEM_SELECT_OUT,
	MEM_READ_OUT,
	MEM_WRITE_OUT,
	MUXJAL_SELECT_OUT,
	ALUOP_OUT,
	MUXIMM_SELECT_OUT,
	MUXPC_SELECT_OUT,
	BRANCH_OUT,
	JUMP_OUT,
	PC_DIRECT_OUT_OUT,
	SIGN_ZERO_EXTEND_OUT,
	PC_PLUS_4_OUT_OUT,
	OUT1_OUT,
	OUT2_OUT,
	RD_OUT,
	FUNCT3_OUT,
	BUSYWAIT
            );

//port declarations
	input CLK, RESET, WRITE_ENABLE_IN, MUXDATAMEM_SELECT_IN, MEM_READ_IN, MEM_WRITE_IN, MUXJAL_SELECT_IN, MUXIMM_SELECT_IN, MUXPC_SELECT_IN, BRANCH_IN, JUMP_IN, BUSYWAIT;
	input [2:0] FUNCT3_IN;
	input [4:0] ALUOP_IN, RD_IN;
	input [31:0] PC_DIRECT_OUT_IN, SIGN_ZERO_EXTEND, PC_PLUS_4_OUT_IN, OUT1_IN, OUT2_IN;
	
	output reg WRITE_ENABLE_OUT, MUXDATAMEM_SELECT_OUT, MEM_READ_OUT, MEM_WRITE_OUT, MUXJAL_SELECT_OUT, MUXIMM_SELECT_OUT, MUXPC_SELECT_OUT, BRANCH_OUT, JUMP_OUT;
	output reg [2:0] FUNCT3_OUT;
	output reg [4:0] ALUOP_OUT, RD_OUT;
	output reg [31:0] PC_DIRECT_OUT_OUT, SIGN_ZERO_EXTEND_OUT, PC_PLUS_4_OUT_OUT, OUT1_OUT, OUT2_OUT;

// The module has a set of input and output ports that facilitate data and control signal movement within the pipeline. These ports include clock (CLK), reset (RESET), various control signals, data inputs, and data outputs.
	always @ (*) begin
        if (RESET) begin
			#1
			WRITE_ENABLE_OUT = 1'd0; 
			MUXDATAMEM_SELECT_OUT = 1'd0; 
			MEM_READ_OUT = 1'd0; 
			MEM_WRITE_OUT = 1'd0; 
			MUXJAL_SELECT_OUT = 1'd0; 
			MUXIMM_SELECT_OUT = 1'd0; 
			MUXPC_SELECT_OUT = 1'd0; 
			BRANCH_OUT = 1'd0; 
			JUMP_OUT = 1'd0; 
			
			FUNCT3_OUT = 3'd0;
			
			ALUOP_OUT = 5'd0;
			RD_OUT = 5'd0;
			
			PC_DIRECT_OUT_OUT = 32'd0;
			SIGN_ZERO_EXTEND_OUT = 32'd0;
			PC_PLUS_4_OUT_OUT = 32'd0;
			OUT1_OUT = 32'd0;
			OUT2_OUT = 32'd0;
		end
	end
//The always block inside the module handles the reset functionality. When the RESET signal is asserted, the register values in the pipeline are reset to their initial values.
    always @ (*) begin
        if (BUSYWAIT == 1'b0 ) begin
			#2
			WRITE_ENABLE_OUT <= WRITE_ENABLE_IN;
			MUXDATAMEM_SELECT_OUT <= MUXDATAMEM_SELECT_IN;
			MEM_READ_OUT <= MEM_READ_IN;
			MEM_WRITE_OUT <= MEM_WRITE_IN;
			MUXJAL_SELECT_OUT <= MUXJAL_SELECT_IN;
			MUXIMM_SELECT_OUT <= MUXIMM_SELECT_IN;
			MUXPC_SELECT_OUT <= MUXPC_SELECT_IN;
			BRANCH_OUT <= BRANCH_IN;
			JUMP_OUT <= JUMP_IN;
			
			FUNCT3_OUT <= FUNCT3_IN;
			
			ALUOP_OUT <= ALUOP_IN;
			RD_OUT <= RD_IN;
			
			PC_DIRECT_OUT_OUT <= PC_DIRECT_OUT_IN;
			SIGN_ZERO_EXTEND_OUT <= SIGN_ZERO_EXTEND;
			PC_PLUS_4_OUT_OUT <= PC_PLUS_4_OUT_IN;
			OUT1_OUT <= OUT1_IN;
			OUT2_OUT <= OUT2_IN;
		
		
		end
	end

endmodule


// module for the third pipeline register
module PIPEREG3(
    CLK,
	RESET,
	WRITE_ENABLE_IN,
	MUXDATAMEM_SELECT_IN,
	MEM_READ_IN,
	MEM_WRITE_IN,
	ALU_OUT_IN,
	OUT2_IN,
	RD_IN,
	FUNCT3_IN,
	WRITE_ENABLE_OUT,
	MUXDATAMEM_SELECT_OUT,
	MEM_READ_OUT,
	MEM_WRITE_OUT,
	ALU_OUT_OUT,
	OUT2_OUT,
	RD_OUT,
	FUNCT3_OUT,
	BUSYWAIT
);

input CLK, RESET, WRITE_ENABLE_IN, MUXDATAMEM_SELECT_IN, MEM_READ_IN, MEM_WRITE_IN, BUSYWAIT;
	input [2:0] FUNCT3_IN;
	input [4:0] RD_IN;
	input [31:0] ALU_OUT_IN, OUT2_IN;
	
	output reg WRITE_ENABLE_OUT, MUXDATAMEM_SELECT_OUT, MEM_READ_OUT, MEM_WRITE_OUT;
	output reg [2:0] FUNCT3_OUT;
	output reg [4:0] RD_OUT;
	output reg [31:0] ALU_OUT_OUT, OUT2_OUT;

// assigning values to the output ports
always @ (*) begin
        if (RESET) begin
            #1;
            WRITE_ENABLE_OUT = 1'd0;
			MUXDATAMEM_SELECT_OUT = 1'd0;
			MEM_READ_OUT = 1'd0;
			MEM_WRITE_OUT = 1'd0;
			FUNCT3_OUT = 3'd0;
			RD_OUT = 5'd0;
			ALU_OUT_OUT = 32'd0;
			OUT2_OUT = 32'd0;
        end
    end


//resetting all values 
always @ (*) begin
        if (BUSYWAIT == 1'b0 ) begin
			#2
            WRITE_ENABLE_OUT <= WRITE_ENABLE_IN;
			MUXDATAMEM_SELECT_OUT <= MUXDATAMEM_SELECT_IN;
			MEM_READ_OUT <= MEM_READ_IN;
			MEM_WRITE_OUT <= MEM_WRITE_IN;
			FUNCT3_OUT <= FUNCT3_IN;
			RD_OUT <= RD_IN;
			ALU_OUT_OUT <= ALU_OUT_IN;
			OUT2_OUT <= OUT2_IN;
        end
    end

endmodule


// module for the fourth pipeline register
module PIPEREG4(CLK,
	RESET,
	WRITE_ENABLE_IN,
	MUXDATAMEM_SELECT_IN,
	DATA_OUT_IN,
	ALU_OUT_IN,
	RD_IN,
	WRITE_ENABLE_OUT,
	MUXDATAMEM_SELECT_OUT,
	DATA_OUT_OUT,
	ALU_OUT_OUT,
	RD_OUT,
	BUSYWAIT);

    input CLK, RESET, WRITE_ENABLE_IN, MUXDATAMEM_SELECT_IN, BUSYWAIT;
	input [4:0] RD_IN;
	input [31:0] DATA_OUT_IN, ALU_OUT_IN;
	
	output reg WRITE_ENABLE_OUT, MUXDATAMEM_SELECT_OUT;
	output reg [4:0] RD_OUT;
	output reg [31:0] DATA_OUT_OUT, ALU_OUT_OUT; 
	

// assigning values to the output ports at the positive edge of the clock
    always @ (*) begin
        if(RESET) begin
			#1
			WRITE_ENABLE_OUT = 1'd0;
			MUXDATAMEM_SELECT_OUT = 1'd0;
			RD_OUT = 5'd0;
			ALU_OUT_OUT = 32'd0;
			DATA_OUT_OUT = 32'd0;
		end
	end 

// resetting the instruction out value
    always @ (*) begin
        if (BUSYWAIT == 1'b0 ) begin
			#2
            WRITE_ENABLE_OUT <= WRITE_ENABLE_IN;
			MUXDATAMEM_SELECT_OUT <= MUXDATAMEM_SELECT_IN;
			RD_OUT <= RD_IN;
			ALU_OUT_OUT <= ALU_OUT_IN;
			DATA_OUT_OUT <= DATA_OUT_IN;
        end
    end

endmodule