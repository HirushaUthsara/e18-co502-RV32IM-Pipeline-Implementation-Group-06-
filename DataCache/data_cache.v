`timescale 1ns/100ps

module DATA_CACHE(
  input wire clk,
  input wire reset,
  input wire enable,
  input wire [31:0] address,
  input wire [31:0] writeData,
  input wire writeEnable,
  output wire [31:0] readData
);

  parameter CACHE_SIZE = 1024;  // Size of the cache in bytes
  parameter BLOCK_SIZE = 32;    // Size of each cache block in bytes
  parameter NUM_BLOCKS = CACHE_SIZE / BLOCK_SIZE;  // Number of cache blocks
  parameter INDEX_WIDTH = $clog2(NUM_BLOCKS);     // Width of the cache index

  reg [31:0] cache [0:NUM_BLOCKS-1];  // Cache data storage
  reg [31:0] tags [0:NUM_BLOCKS-1];   // Tags for each cache block
  reg [INDEX_WIDTH-1:0] index;        // Cache index for address mapping

  wire hit;           // Cache hit signal
  wire [31:0] hitData; // Data read from cache on a hit

  // Memory write signal for each cache block
  reg [NUM_BLOCKS-1:0] dirty;

  // Sequential logic for cache read and write operations
  always @(posedge clk) begin
    if (reset) begin
      // Reset cache and tags
      cache <= 0;
      tags <= 0;
      dirty <= 0;
    end else if (enable) begin
      // Calculate cache index
      index <= address[(INDEX_WIDTH + BLOCK_SIZE - 1):BLOCK_SIZE];

      // Check for cache hit
      hit = (tags[index] == address[(INDEX_WIDTH + BLOCK_SIZE - 1):BLOCK_SIZE]);

      if (hit) begin
        // Read from cache on hit
        readData <= hitData;
        
        if (writeEnable) begin
          // Write data to cache
          cache[index] <= writeData;
          dirty[index] <= 1;
        end
      end else begin
        // Cache miss, fetch data from memory
        // Read data from memory and update cache
        readData <= memory_read(address);

        if (writeEnable) begin
          // Write data to cache
          cache[index] <= writeData;
          tags[index] <= address[(INDEX_WIDTH + BLOCK_SIZE - 1):BLOCK_SIZE];
          dirty[index] <= 1;
        end
      end
    end
  end

  // Write-back logic
  always @(posedge clk) begin
    if (reset) begin
      // Reset dirty flags
      dirty <= 0;
    end else if (enable) begin
      if (!hit && dirty[index]) begin
        // Write dirty block back to memory
        memory_write(tags[index] + (address & (BLOCK_SIZE - 1)), cache[index]);
        dirty[index] <= 0;
      end
    end
  end

  // Memory read simulation
  function automatic logic [31:0] memory_read;
    input logic [31:0] addr;
    begin
      // Simulate memory read operation
      // Replace this with actual memory read code
      memory_read = 0; // Placeholder value
    end
  endfunction

  // Memory write simulation
  function automatic logic memory_write;
    input logic [31:0] addr;
    input logic [31:0] data;
    begin
      // Simulate memory write operation
      // Replace this with actual memory write code
    end
  endfunction

endmodule
