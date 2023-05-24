//timescale directive sets the base time unit and precision for the simulation. In this example, it sets the base time unit to 
//1 nanosecond and the precision to 100 picoseconds. 
`timescale 1ns/100ps

module INSTRUCTION_MEMORY(CLOCK, READ, BLOCK_ADDRESS, READ_INST, BUSYWAIT);

input CLOCK, READ;
input [27:0] BLOCK_ADDRESS;
output reg[127:0] READ_INST;
output reg BUSYWAIT;

reg READACCESS;

// declare memory array of 1024x32 bits
reg [31:0] MEM_ARRAY [1023:0];

//Initialize instruction memory
initial
begin
	BUSYWAIT = 0;
	READACCESS = 0;
	$readmemb("instr_mem.mem", MEM_ARRAY);
end

//Detecting an incoming memory access
always @(READ)
begin
    BUSYWAIT = (READ)? 1 : 0;
    READACCESS = (READ)? 1 : 0;
end

// reading the memory block from the memory 
always @(posedge CLOCK ) begin
    if (READACCESS) begin
        READ_INST[31:0] = #40 MEM_ARRAY[{BLOCK_ADDRESS,2'b00}];            // block size in 4 instructions = 32x4 = 128 bits
        READ_INST[63:32] = #40 MEM_ARRAY[{BLOCK_ADDRESS,2'b01}];
        READ_INST[95:64] = #40 MEM_ARRAY[{BLOCK_ADDRESS,2'b10}];
        READ_INST[127:96] = #40 MEM_ARRAY[{BLOCK_ADDRESS,2'b11}];
        BUSYWAIT = 0;                      // set the busywait and readaccess to low
        READACCESS = 0;
    end
end

endmodule