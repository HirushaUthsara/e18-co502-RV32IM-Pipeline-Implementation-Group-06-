`timescale 1ns/100ps

module data_cache (
  input clk,             // clock signal
  input rst,             // reset signal
  input [31:0] addr,     // memory address
  input [31:0] din,      // input data
  input wr_en,           // write enable signal
  input [1:0] cache_en,  // cache enable signal
  input busywait,        // busywait signal from the CPU
  output [31:0] dout     // output data
);

  // Parameters
  parameter CACHE_SIZE = 32;  // Size of the cache
  parameter LINE_SIZE = 4;    // Size of each cache line
  
  // Variables
  reg [31:0] cache [CACHE_SIZE-1:0];  // Cache array
  reg [1:0] valid [CACHE_SIZE/LINE_SIZE-1:0];  // Valid bit array
  reg [1:0] dirty [CACHE_SIZE/LINE_SIZE-1:0];  // Dirty bit array
  reg [31:0] tag [CACHE_SIZE/LINE_SIZE-1:0];   // Tag array
  
  // Internal signals
  wire hit;     // Cache hit signal
  wire [31:0] data_out;  // Data output from cache
  
  // Calculate the index and tag for the given memory address
  wire [5:0] index = addr[CACHE_SIZE_LOG2-1:LOG2_LINE_SIZE];
  wire [31:6] tag_bits = addr[CACHE_SIZE_LOG2-1:LOG2_LINE_SIZE+6];
  
  // Check if the memory address is a cache hit or miss
  assign hit = valid[index] && (tag[index] == tag_bits);
  
  // Output the data from the cache if there is a hit, otherwise access the data memory
  assign dout = hit ? data_out : (busywait ? dout : mem_read(addr));
  
  // Read data from the cache
  assign data_out = cache[index + (addr[LOG2_LINE_SIZE-1:2] & (LINE_SIZE-1))];
  
  // Write data to the cache
  always @(posedge clk) begin
    if (wr_en && cache_en) begin
      cache[index + (addr[LOG2_LINE_SIZE-1:2] & (LINE_SIZE-1))] <= din;
      valid[index] <= 2'b11;
      dirty[index] <= 2'b10;
      tag[index] <= tag_bits;
    end
  end
  
  // Write back dirty cache lines to memory
  always @(posedge clk) begin
    for (integer i = 0; i < CACHE_SIZE/LINE_SIZE; i = i + 1) begin
      if (dirty[i] == 2'b10) begin
        mem_write(tag[i], cache[i*LINE_SIZE +: LINE_SIZE]);
        dirty[i] <= 2'b01;
      end
    end
  end
  
endmodule
