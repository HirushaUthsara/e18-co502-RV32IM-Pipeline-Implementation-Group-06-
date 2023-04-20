`timescale 1ns / 100ps
`include "RegisterFile.v"

module testbench();

reg [4:0] reg_write;
reg [31:0] write_data;
reg [4:0] read1;
reg [4:0] read2;
wire [31:0] read_data1;
wire [31:0] read_data2;
reg clk;
reg rst;

register_file myreg(
    .reg_write(reg_write),
    .write_data(write_data),
    .read1(read1),
    .read2(read2),
    .read_data1(read_data1),
    .read_data2(read_data2),
    .clk(clk),
    .rst(rst)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    rst = 1;
    #10 rst = 0;
end

initial begin
    // Test write operation
    reg_write = 1;
    write_data = 32'habcdef01;
    #10;
    
    // Test read operation
    read1 = 1;
    read2 = 0;
    #10;
    
    // Verify read data
    if (read_data1 != write_data || read_data2 != 0) begin
        $error("Read data mismatch");
    end
    
    $display("Test complete");
    $finish;
end

endmodule
