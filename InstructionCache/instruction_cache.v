//timescale directive sets the base time unit and precision for the simulation. In this example, it sets the base time unit to 
//1 nanosecond and the precision to 100 picoseconds. 
`timescale 1ns/100ps

module INSTRUCTION_CACHE (
    CLOCK, RESET, BUSYWAIT, PC, INSTRUCTION, BUSYWAIT_instruction_mem, READ_INST, READ_instruction_mem, ADDRESS_instruction_mem
);

// ports between Instruction Cache and Instruction Memory and ports between CPU and Instruction Cache

	input BUSYWAIT_instruction_mem;				// instruction memory is busy
	input [127:0] READ_INST;					// instruction fetched from instruction memory
	output reg [29:0] ADDRESS_instruction_mem;	// address for miss to fetch from instruction memory
	output reg READ_instruction_mem;			// read signal control signal for mem
	input CLOCK, RESET;							
	output reg [0:0] BUSYWAIT;					// control signal to stall the cpu
	input [9:0] PC;								// program counter 10 bits (1024 byte addresses)
	output reg [31:0] INSTRUCTION;				// instruction fetched
    
endmodule