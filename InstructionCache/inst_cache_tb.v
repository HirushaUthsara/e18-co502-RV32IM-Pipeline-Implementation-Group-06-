`include "instruction_cache.v"

module instruction_cache_tb;

    reg clock;
    reg reset;
    reg [31:0] address;
    wire [31:0] readinst;
    wire busywait;
    wire [27:0] mem_address;
    wire mem_read;
    reg [127:0] mem_readinst;
    wire mem_busywait;

    // Instantiate the instruction_cache module
    instruction_cache dut (
        .clock(clock),
        .reset(reset),
        .address(address),
        .readinst(readinst),
        .busywait(busywait),
        .mem_address(mem_address),
        .mem_read(mem_read),
        .mem_readinst(mem_readinst),
        .mem_busywait(mem_busywait)
    );

    // Clock generation
    always begin
        #5 clock = ~clock;
    end

    // Test stimulus
    initial begin
        clock = 0;
        reset = 1;
        address = 0;
        mem_readinst = 128'h0123456789ABCDEF0123456789ABCDEF;

        #10 reset = 0;

        // Read instruction at address 0
        address = 0;
        #20 $display("Instruction at address 0: %h", readinst);

        // Read instruction at address 4
        address = 4;
        #20 $display("Instruction at address 4: %h", readinst);

        // Read instruction at address 8
        address = 8;
        #20 $display("Instruction at address 8: %h", readinst);

        // Read instruction at address 12
        address = 12;
        #20 $display("Instruction at address 12: %h", readinst);

        // Read instruction at address 16
        address = 16;
        #20 $display("Instruction at address 16: %h", readinst);

        // Read instruction at address 20
        address = 20;
        #20 $display("Instruction at address 20: %h", readinst);

        // Read instruction at address 24
        address = 24;
        #20 $display("Instruction at address 24: %h", readinst);

        // Read instruction at address 28
        address = 28;
        #20 $display("Instruction at address 28: %h", readinst);

        // Wait for some time
        #100 $finish;
    end

endmodule
