`timescale  1ns/100ps

`include "../Adder/Adder.v"
`include "../ALU/ALU.v"
`include "../Branch and Jump/Branch_Jump.v"
`include "../Control unit/ControlUnit.v"
`include "../Data Memory/Data_Memory.v"
`include "../DataCache/data_cache.v"
`include "../ImmediateGenerator/ImmediateGenarator.v"
`include "../Instruction_fetch_module/InstructionFetch.v"
`include "../InstructionCache/instruction_cache.v"
`include "../InstructionMemory/InstructionMemory.v"
`include "../Mux/MUX.v"
`include "../PC/PC.v"
`include "../Pipeline_Registers/Pipeline_Registers.v"
`include "../Register File/RegisterFile.v"

module CPU(CLK, RESET, PC, INSTR, MEMREAD_CACHE, MEMWRITE_CACHE, ALUOUT_PIPE3, TO_DMEM, FROM_DMEM, INSTRCACHE_BUSYWAIT, CACHE_BUSYWAIT, INSTHIT, INSTHIT_PIPE3);

    input CLK,RESET, INSTRCACHE_BUSYWAIT, CACHE_BUSYWAIT, INSTHIT;
    input[31:0] FROM_DMEM;  
    input [31:0] INSTR;                     //this go directly to pipeline reg 1
    output [31:0] PC,TO_DMEM;
    output MEMREAD_CACHE,MEMWRITE_CACHE,INSTHIT_PIPE3;         // this should be from output of pipeline reg 3
    output [31:0] ALUOUT_PIPE3;


    //stage 1 wires
    wire [127:0] READDATA;
    wire [31:0]  NEXTPC, JUMP_BRANCH_PC, PCMUX, PCAdder , INSTREAD, PCMUX_OUT,PCVALUE;
    wire [27:0]  MEMADD;
    wire         BUSYWAIT,MEM_BUSYWAIT, HIT, MEMREAD1, BRANCH_JUMP_SIGNAL;

    //pipeline reg 1 wires
    wire [31:0] NEXTPC_PIPE1, PCOUT_PIPE1,INSTR_PIPE1;
    wire INSTHIT_PIPE1;

    /*
mux - pc mux
mux1- mux1
mux2- mux5
mux3- mux4
mux4- mux3
IMMGEN - MUX2
*/

    //stage 2 wires
    wire       MUX1,MUX4,MUX2,MEMREAD,MEMWRITE,BRANCH,JUMP,WRITEENABLE,REGWRITE,INSTHIT;
    wire [1:0]  MUX3;
    wire [2:0]  IMMGEN;
    wire [4:0]  ALUOP;
    wire [31:0] OUT1, OUT2, IMM_OUT, BRANCH_ADD;

    wire MUX2_PIPE2,WRITEENABLE_PIPE2,MUX4_PIPE2,MEMWRITE_PIPE2,MEMREAD_PIPE2,BRANCH_PIPE2,JUMP_PIPE2,MUX1_PIPE2,INSTHIT_PIPE2;
    wire [2:0] FUNC_PIPE2;
    wire [1:0] MUX3_PIPE2;
    wire [4:0] ALUOP_PIPE2,DESREG_PIPE2;
    wire [31:0] PC_PIPE2, NEXTPC_PIPE2, DATA1_PIPE2, DATA1_PIPE2, IMMGEN_PIPE2, BRANCHADD_PIPE2;

    wire       ZERO, SIGN_BIT, SLTU_BIT;
    wire[31:0] DATA1, DATA2 , ALURESULT, MUX3_OUT;

    wire WRITEENABLE_PIPE3, MUX4_PIPE3, INSTHIT_PIPE3;
    wire [2:0] FUNC_PIPE3;
    wire [4:0] DESREG_PIPE3;
    wire [31:0] ALUOUT_PIPE3,DATA2_PIPE3;


    wire INSTHIT_PIPE4, WRITEENABLE_PIPE4, MUX4_PIPE4;
    wire [4:0] DESREG_PIPE4;
    wire [31:0] ALUOUT_PIPE4, DMEM_PIPE4;

    wire[31:0] REG_WRITEDATA;

   
    MUX_A               pcmux(NEXTPC, JUMP_BRANCH_PC, PCMUX_OUT, BRANCH_JUMP_SIGNAL);
    PC                  pc(CLK, RESET, PCMUX_OUT, PC, BUSYWAIT);
    adder               PCAdder(PC, NEXTPC);
    InstructionFetch    instfetch(CLK, RESET, INSTRCACHE_BUSYWAIT, CACHE_BUSYWAIT, BRANCH_JUMP_SIGNAL, PC, NEXTPC, JUMP_BRANCH_PC, PCMUX_OUT, PCVALUE);

    PIPEREG1            REG1(CLK,RESET,NEXTPC,PC,INSTR,INSTHIT,CACHE_BUSYWAIT,NEXTPC_PIPE1,PCOUT_PIPE1,INSTR_PIPE1,INSTHIT_PIPE1);

    CONTROL_UNIT        CONTROLUNIT(INSTR_PIPE1, MUX1, IMMGEN, MUX4, MUX3, MUX2, MEMREAD, MEMWRITE, BRANCH,JUMP,WRITEENABLE,ALUOP);
    register_file       regfile(CLK, RESET, REGWRITE, OUT1, OUT2, DESREG_PIPE4, INSTHIT_PIPE1[19:15], INSTHIT_PIPE1[24:20], WRITEENABLE_PIPE4, INSTHIT_PIPE4);

    PIPEREG2            REG2(CLK,RESET,cache_mem_busywait,
        //from instruction
        Instr_out_pipe1[11:7],Instr_out_pipe1[14:12],Instr_out_pipe1[19:15],Instr_out_pipe1[24:20],
        
        //control signals
        mux5_select,writeEnable,mux3_select,memWrite,memRead,ALUop,mux4_select,branch,jump,mux1_select,
        
        //PC
        PC_out_pipe1,nextPC_out_pipe1,
        
        //regfile outputs
        OUT1,OUT2,
        
        //immidiate value
        mux2_out,
        
        //inst hit signal
        Insthit_out_pipe1,

        //branch address
        B_address, 
        
        //outputs
        des_register_out_pipe2,Funct3_out_pipe2,rs1_out_pipe2,rs2_out_pipe2,mux_5_sel_out_pipe2,writeEnable_out_pipe2,mux_3_sel_out_pipe2,memWrite_out_pipe2,memRead_out_pipe2,ALUop_out_pipe2,mux_4_sel_out_pipe2,branch_out_pipe2,jump_out_pipe2,mux_1_sel_out_pipe2,
        PC_out_pipe2,nextPC_out_pipe2,data1_out_pipe2,data2_out_pipe2,mux_2_out_out_pipe2,Insthit_out_pipe2,B_address_out_pipe2);

    MUX_A   MUX1(mux_7_out,PC_out_pipe2,DATA1_in,mux_1_sel_out_pipe2);
    MUX_A   MUX2(mux_2_out_out_pipe2,mux_6_out,DATA2_in,mux_5_sel_out_pipe2);
    ALU     ALU(DATA1_in,DATA2_in,Alu_RESULT,ALUop_out_pipe2,zero_signal,sign_bit_signal,sltu_bit_signal);
    BRANCH_JUMP BJ(RESET,B_address_out_pipe2,Alu_RESULT,Funct3_out_pipe2,branch_out_pipe2,jump_out_pipe2,zero_signal,sign_bit_signal,sltu_bit_signal,jump_branch_pc,Branch_condition_and_jump_signal);
    MUX_B   MUX3(ALUOUT, IMMGEN, NEXTPC, MUX3_OUT);
    adder   ADDER(PC, B_IMM);
    


endmodule