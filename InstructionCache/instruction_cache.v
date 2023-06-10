`timescale 1ns/100ps

module instruction_cache(
    clock, 
    reset, 
    address, 
    readinst, 
    busywait, 
    mem_address, 
    mem_read, 
    mem_readinst, 
    mem_busywait
);
    input [31:0] address;                   // Input: Address for instruction fetch
    input [127:0] mem_readinst;             // Input: Instruction data from memory
    input clock, reset, mem_busywait;       // Inputs: Clock, Reset signal, Memory busy wait signal
    output reg [31:0] readinst;             // Output: Instruction data for processing
    output reg busywait;                    // Output: Indicates whether cache is busy
    output reg [27:0] mem_address;           // Output: Memory address for instruction fetch
    output reg mem_read;                    // Output: Signal to read instruction data from memory

    reg [127:0] inst_cache [0:7];           // Instruction cache memory
    reg inst_valid [0:7];                    // Instruction cache valid flags
    reg [24:0] inst_tag [0:7];               // Instruction cache tag values

    always @ (address ) // (address || !hit)
    begin
        if(address != -32'd4) busywait = 1;  // Set busywait signal when the address is not -32'd4
    end

    wire valid_out;
    wire [127:0] data_out;
    wire [24:0] tag_out;

    assign #1 data_out = inst_cache[address[6:4]];     // Read data from the instruction cache
    assign #1 valid_out = inst_valid[address[6:4]];    // Read valid flag from the instruction cache
    assign #1 tag_out = inst_tag[address[6:4]];        // Read tag value from the instruction cache

    wire tag_status, hit;
    assign #1 tag_status = (tag_out == address[31:7]) ? 1 : 0;   // Compare tag value with the address
    assign hit = valid_out & tag_status;                       // Determine if cache hit occurred

    always @ (posedge clock)
    begin
        if (hit) busywait = 0;                   // Reset busywait when cache hit occurs
    end

    always @ (*)
    begin
        #1
        if (hit)                                // If cache hit occurs
        begin
            case (address[3:2])                  // Select the appropriate part of the instruction based on the address
                2'b00 : readinst = data_out[31:0];
                2'b01 : readinst = data_out[63:32];
                2'b10 : readinst = data_out[95:64];
                2'b11 : readinst = data_out[127:96];
            endcase
        end
        else 
            readinst = 32'bx;                    // Set readinst to "don't care" if cache miss occurs
    end

    parameter IDLE = 2'b00, READ_MEM = 2'b01, UPDATE_CACHE = 2'b10;
    reg [1:0] state, next_state;

    always @(*)
    begin
        case (state)
            IDLE:
                if (!hit && (address != -32'd4))   // If cache miss occurs and address is not -32'd4
                   next_state = READ_MEM;
                else
                   next_state = IDLE;
                
            READ_MEM:
                if (!mem_busywait)
                    next_state = UPDATE_CACHE;     // Proceed to update the cache if memory is not busy
                else    
                    next_state = READ_MEM;         // Stay in the READ_MEM state if memory is busy

            UPDATE_CACHE:
                next_state = IDLE;
                
        endcase
    end

    // Combinational output logic
    always @(state)
    begin
        case(state)
            IDLE:
                begin
                    mem_read = 0;                   // No memory read operation
                    mem_address = 28'dx;            // Memory address set to "don't care"
                    busywait = 0;                   // Reset busywait signal
                end
             
            READ_MEM: 
                begin
                    mem_read = 1;                   // Enable memory read operation
                    mem_address = {address[31:4]};   // Set memory address for instruction fetch
                end

            UPDATE_CACHE:
                begin
                    mem_read = 0;                   // No memory read operation
                    #1
                    inst_cache[address[6:4]] = mem_readinst;     // Update the cache with the fetched instruction data
                    inst_valid[address[6:4]] = 1;                // Set the valid flag for the updated cache entry
                    inst_tag[address[6:4]] = address[31:7];      // Set the tag value for the updated cache entry
                end
        endcase
    end

    // Sequential logic for state transitioning 
    always @ (posedge clock, reset)
    begin
        if(reset)
            state = IDLE;                   // Reset state to IDLE
        else
            state = next_state;             // Update state based on next_state value
    end

    // Reset instruction cache
    integer i;
    always @ (reset)
    begin
        if(reset)
        begin
            for ( i = 0; i < 8; i = i + 1)
            begin
                inst_valid[i] = 0;                   // Reset valid flags
                inst_tag[i] = 25'bx;                 // Reset tag values
                busywait = 0;                        // Reset busywait signal
                inst_cache[i] = 128'dx;              // Reset cache entries
            end
        end
    end

endmodule

/*
The code represents an instruction cache module that interfaces with a memory system. Here's a summary of its functionality:

The module has various input and output ports for communication with other components, including clock, reset, address, instruction data, and control signals.
The inst_cache array represents the instruction cache memory, and inst_valid and inst_tag arrays store the validity flags and tag values for each cache entry.
The cache is accessed based on the input address, and the cache hit/miss status is determined using comparison with the tag values and the validity flags.
If a cache hit occurs, the appropriate part of the instruction is selected based on the address.
If a cache miss occurs, the module transitions to the READ_MEM state and requests the instruction data from the memory system.
Once the instruction data is received, the cache is updated with the new data, and the corresponding validity flag and tag value are set.
The module includes a finite-state machine (FSM) to control the state transitions between idle, reading from memory, and updating the cache.
Combinational and sequential logic is used to manage the state transitions and control the cache read and write operations.
The cache is reset during a reset signal, which initializes the validity flags, tag values, and cache entries.
Overall, this code represents a simple instruction cache module that fetches instructions from memory and utilizes a cache to improve performance by reducing memory access latency.
*/