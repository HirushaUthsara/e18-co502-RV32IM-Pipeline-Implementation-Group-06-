`include "../Data Memory/Data_Memory.v"
`include "../DataCache/data_cache.v"

`timescale 1ns/100ps

// Declare the module with input and output ports
module DataMemoryWithCache (
  input wire CLOCK,
  input wire RESET,
  input wire READ,
  input wire WRITE,
  input wire [27:0] ADDRESS,
  input wire [127:0] WRITEDATA,
  output wire [127:0] READDATA,
  output wire BUSYWAIT
);
  // Declare the data memory module instance
  DATA_MEMORY data_memory (
    .CLOCK(CLOCK),
    .RESET(RESET),
    .READ(),
    .WRITE(),
    .ADDRESS(),
    .WRITEDATA(),
    .READDATA(),
    .BUSYWAIT()  
  );

  // Declare the data cache module instance
  DATA_CACHE data_cache (
    
  );
endmodule
