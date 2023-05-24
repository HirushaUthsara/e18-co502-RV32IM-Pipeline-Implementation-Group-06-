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
	$readmemb("instr_mem.mem", MEM_ARRAY);      // extract instructions from instr_mem.mem file

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
        READ_INST[7:0]      = #40 MEM_ARRAY[{BLOCK_ADDRESS,4'b0000}];    // convert byte address into block
        READ_INST[15:8]     = #40 MEM_ARRAY[{BLOCK_ADDRESS,4'b0001}];
        READ_INST[23:16]    = #40 MEM_ARRAY[{BLOCK_ADDRESS,4'b0010}];
        READ_INST[31:24]    = #40 MEM_ARRAY[{BLOCK_ADDRESS,4'b0011}];
        READ_INST[39:32]    = #40 MEM_ARRAY[{BLOCK_ADDRESS,4'b0100}];
        READ_INST[47:40]    = #40 MEM_ARRAY[{BLOCK_ADDRESS,4'b0101}];
        READ_INST[55:48]    = #40 MEM_ARRAY[{BLOCK_ADDRESS,4'b0110}];
        READ_INST[63:56]    = #40 MEM_ARRAY[{BLOCK_ADDRESS,4'b0111}];
        READ_INST[71:64]    = #40 MEM_ARRAY[{BLOCK_ADDRESS,4'b1000}];
        READ_INST[79:72]    = #40 MEM_ARRAY[{BLOCK_ADDRESS,4'b1001}];
        READ_INST[87:80]    = #40 MEM_ARRAY[{BLOCK_ADDRESS,4'b1010}];
        READ_INST[95:88]    = #40 MEM_ARRAY[{BLOCK_ADDRESS,4'b1011}];
        READ_INST[103:96]   = #40 MEM_ARRAY[{BLOCK_ADDRESS,4'b1100}];
        READ_INST[111:104]  = #40 MEM_ARRAY[{BLOCK_ADDRESS,4'b1101}];
        READ_INST[119:112]  = #40 MEM_ARRAY[{BLOCK_ADDRESS,4'b1110}];
        READ_INST[127:120]  = #40 MEM_ARRAY[{BLOCK_ADDRESS,4'b1111}];

        BUSYWAIT = 0;                      // set the busywait and readaccess to low
        READACCESS = 0;
    end
end

endmodule