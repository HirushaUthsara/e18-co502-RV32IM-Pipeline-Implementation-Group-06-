`include "../Data Memory/Data_Memory.v"
`include "../DataCache/data_cache.v"

`timescale 1ns/100ps

// Declare the module with input and output ports
module DataMemoryWithCache (
  input wire CLOCK,
  input wire RESET,
  input wire READ,
  input wire WRITE,
  input wire [31:0] ADDRESS,
  input wire [31:0] WRITEDATA,
  output wire [31:0] READDATA,
  output wire BUSYWAIT
);

wire mem_busywait, mem_mem_read, mem_mem_write;
wire [27:0] block_address;
wire [127:0] data_block_read, data_block_write;

  // Declare the data memory module instance
  DATA_MEMORY data_memory (
    .CLOCK(CLOCK),
    .RESET(RESET),
    .READ(mem_mem_read),
    .WRITE(mem_mem_write),
    .ADDRESS(block_address),
    .WRITEDATA(data_block_write),
    .READDATA(data_block_read),
    .BUSYWAIT(mem_busywait)  
  );

  // Declare the data cache module instance
  DATA_CACHE data_cache (
    .CLK(CLOCK),
    .RESET(RESET),
    .MEM_READ(READ),
    .MEM_WRITE(WRITE),
    .MEM_ADDRESS(ADDRESS),
    .DATA_IN(WRITEDATA),
    .MEM_BUSYWAIT(mem_busywait),
    .MEM_READ_OUT(data_block_read),
    .CACHE_READ_OUT(READDATA),
    .MEM_MEM_READ(mem_mem_read),
    .MEM_MEM_WRITE(mem_mem_write),
    .BUSYWAIT(BUSYWAIT),
    .MEM_BLOCK_ADDR(block_address),
    .MEM_WRITE_OUT(data_block_write)
  );
endmodule


// Testbed for integration testing

module DataMemoryWithCache_tb;
  reg CLOCK;
  reg RESET;
  reg READ;
  reg WRITE;
  reg [31:0] ADDRESS;
  reg [31:0] WRITEDATA;
  wire [31:0] READDATA;
  wire BUSYWAIT;

  // Instantiate the module under test
  DataMemoryWithCache dut (
    .CLOCK(CLOCK),
    .RESET(RESET),
    .READ(READ),
    .WRITE(WRITE),
    .ADDRESS(ADDRESS),
    .WRITEDATA(WRITEDATA),
    .READDATA(READDATA),
    .BUSYWAIT(BUSYWAIT)
  );

  // Clock generation
  always begin
    #5 CLOCK = ~CLOCK;
  end

  // Test stimulus
  initial begin
    // Initialize inputs
    RESET = 1;
    READ = 0;
    WRITE = 0;
    ADDRESS = 0;
    WRITEDATA = 0;

    // Reset sequence
    #10 RESET = 0;
    #10 RESET = 1;

    // Perform read operation
    #10 READ = 1;
    #5 ADDRESS = 0x100; // Set the address you want to read from
    #5 READ = 0;

    // Perform write operation
    #10 WRITE = 1;
    #5 ADDRESS = 0x200; // Set the address you want to write to
    #5 WRITEDATA = 0xABCD; // Set the data you want to write
    #5 WRITE = 0;

    // Wait for busywait signal to be deasserted
    while (BUSYWAIT) begin
      #1;
    end

    // Add more test scenarios as needed

    // Finish simulation
    #10 $finish;
  end
endmodule
