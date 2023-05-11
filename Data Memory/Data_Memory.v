`timescale 1ns/100ps

// Declare the module with input and output ports
module DATA_MEMORY(CLOCK,  
                    RESET, 
                    READ, 
                    WRITE, 
                    ADDRESS,
                    WRITEDATA,
                    READDATA
                    BUSYWAIT 
                    );
// Declare input and output ports
        input CLOCK, RESET, READ, WRITE;
        input [27:0] ADDRESS;
        input [127:0] WRITEDATA;
        output reg [127:0] READDATA;
        output reg  BUSYWAIT;

// Declare a memory array of size 256, 128 bits wide
        reg [127:0] MEM_ARRAY [255:0];

// Declare two control signals for read and write operations
        reg READACESS, WRITEACESS;

// Combinational logic block to assign values to control signals based on input signals
        always @(READ, WRITE)
        begin
            BUSYWAIT = (READ || WRITE)? 1:0;     // set busywait signal to high
            READACESS = (READ && !WRITE)? 1:0; // Set READACESS to 1 if READ input is asserted and WRITE input is deasserted
            WRITEACESS = (!READ && WRITE)? 1:0; // Set WRITEACESS to 1 if WRITE input is asserted and READ input is deasserted
        end 

// Sequential logic for memory read and write operations on positive edge of clock signal
        always @(posedge CLOCK) 
        begin
            if(READACESS)// If it's a read access
            begin
                // Read the 128-bit data stored at the given address and update READDATA
                READDATA[7:0]     = #40 MEM_ARRAY[{ADDRESS,4'b0000}];
                READDATA[15:8]    = #40 MEM_ARRAY[{ADDRESS,4'b0001}];
                READDATA[23:16]   = #40 MEM_ARRAY[{ADDRESS,4'b0010}];
                READDATA[31:24]   = #40 MEM_ARRAY[{ADDRESS,4'b0011}];
                READDATA[39:32]   = #40 MEM_ARRAY[{ADDRESS,4'b0100}];
                READDATA[47:40]   = #40 MEM_ARRAY[{ADDRESS,4'b0101}];
                READDATA[55:48]   = #40 MEM_ARRAY[{ADDRESS,4'b0110}];
                READDATA[63:56]   = #40 MEM_ARRAY[{ADDRESS,4'b0111}];
                READDATA[71:64]   = #40 MEM_ARRAY[{ADDRESS,4'b1000}];
                READDATA[79:72]   = #40 MEM_ARRAY[{ADDRESS,4'b1001}];
                READDATA[87:80]   = #40 MEM_ARRAY[{ADDRESS,4'b1010}];
                READDATA[95:88]   = #40 MEM_ARRAY[{ADDRESS,4'b1011}];
                READDATA[103:96]  = #40 MEM_ARRAY[{ADDRESS,4'b1100}];
                READDATA[111:104] = #40 MEM_ARRAY[{ADDRESS,4'b1101}];
                READDATA[119:112] = #40 MEM_ARRAY[{ADDRESS,4'b1110}];
                READDATA[127:120] = #40 MEM_ARRAY[{ADDRESS,4'b1111}];
                READACESS =0;// Deassert read access flag
                BUSYWAIT = 0;// Deassert busywait signal
            end  

            if(WRITEACESS)// If it's a write access
            begin
                // Write the 128-bit data from WRITEDATA to the given address
                MEM_ARRAY[{ADDRESS,4'b0000}] = #40 WRITEDATA[7:0];
                MEM_ARRAY[{ADDRESS,4'b0001}] = #40 WRITEDATA[15:8];
                MEM_ARRAY[{ADDRESS,4'b0010}] = #40 WRITEDATA[23:16];
                MEM_ARRAY[{ADDRESS,4'b0011}] = #40 WRITEDATA[31:24];
                MEM_ARRAY[{ADDRESS,4'b0100}] = #40 WRITEDATA[39:32];
                MEM_ARRAY[{ADDRESS,4'b0101}] = #40 WRITEDATA[47:40];
                MEM_ARRAY[{ADDRESS,4'b0110}] = #40 WRITEDATA[55:48];
                MEM_ARRAY[{ADDRESS,4'b0111}] = #40 WRITEDATA[63:56];
                MEM_ARRAY[{ADDRESS,4'b1000}] = #40 WRITEDATA[71:64];
                MEM_ARRAY[{ADDRESS,4'b1001}] = #40 WRITEDATA[79:72];
                MEM_ARRAY[{ADDRESS,4'b1010}] = #40 WRITEDATA[87:80];
                MEM_ARRAY[{ADDRESS,4'b1011}] = #40 WRITEDATA[95:88];
                MEM_ARRAY[{ADDRESS,4'b1100}] = #40 WRITEDATA[103:96];
                MEM_ARRAY[{ADDRESS,4'b1101}] = #40 WRITEDATA[111:104];
                MEM_ARRAY[{ADDRESS,4'b1110}] = #40 WRITEDATA[119:112];
                MEM_ARRAY[{ADDRESS,4'b1111}] = #40 WRITEDATA[127:120];
                WRITEACESS = 0;// Deassert write access flag
                BUSYWAIT = 0;// Deassert busywait signal
            end  
        end

        integer i; // declare an integer variable i

// reset the memory array and control signals when RESET signal is triggered
        always @(posedge RESET) 
        begin
            if(RESET) // if RESET signal is 1
            begin
            for(i=0; i<256; i=i+1)
                MEM_ARRAY[i] = 0; // set each memory location to 0

            READACESS = 0; // reset the READ access control signal to 0 
            WRITEACESS = 0; // reset the WRITE access control signal to 0
            end
        end

endmodule


/*
#40 is used to ensure that enough time has elapsed for the memory MEM_ARRAY to return the correct data. This is known as a memory read delay.
Without the delay, the READDATA output may not have enough time to stabilize and may output incorrect values. By adding the delay, 
the code allows enough time for the data to propagate through the memory and stabilize before being read out.

*/