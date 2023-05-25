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

endmodule