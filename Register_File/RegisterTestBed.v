`include "RegisterFile.v"
`timescale 1ns/100ps

module register_file_tb;

  // Declare the DUT (device under test)
  reg [4:0] reg_write;
  reg [31:0] write_data;
  reg [4:0] read1, read2;
  wire [31:0] read_data1, read_data2;
  reg writeenable;
  reg clk, rst;
  
  register_file dut (
    .reg_write(reg_write),
    .write_data(write_data),
    .read1(read1),
    .read2(read2),
    .read_data1(read_data1),
    .read_data2(read_data2),
    .writeenable(writeenable),
    .clk(clk),
    .rst(rst)
  );
  
  // Toggle the clock signal
  always #5 clk = ~clk;
  
  // Initialize testbench inputs
  initial begin
    // Reset the DUT
    clk = 1;
    rst = 1;
    #10 rst = 0;
    
    // Random write and read operations
    repeat(32) begin
      // Random write operation
      if ($random % 2 == 0) begin
        reg_write = $random % 32;
        write_data = $random;
        writeenable = 1;
        #10;
      end
      
      // Random read operation
      read1 = $random % 32;
      read2 = $random % 32;
      #10;
    end
    
    // End simulation
    #10 $finish;
  end
  
  // Dump waveform into a VCD file
  initial begin
    $dumpfile("register_file_waveform.vcd");
    $dumpvars(1, register_file_tb);
    #10;
  end
  
endmodule
