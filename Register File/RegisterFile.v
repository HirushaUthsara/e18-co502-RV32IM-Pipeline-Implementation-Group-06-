module register_file (
    input [4:0] reg_write,
    input [31:0] write_data,
    input [4:0] read1,
    input [4:0] read2,
    output reg [31:0] read_data1,
    output reg [31:0] read_data2,
    input writeenable,
    input clk,
    input rst
);

reg [31:0] regs [0:31];
integer i;

always @(posedge clk) begin
    if (rst) begin
        // Reset all registers to zero
        for (i = 0; i < 32; i++) begin
            regs[i] <= 0;
        end
    end else begin
        // Write to register file if write enable is asserted
        if (writeenable) begin
            if (reg_write != 0) begin
                regs[reg_write] <= write_data;
            end
        end
        
        // Read from register file
        read_data1 <= regs[read1];
        read_data2 <= regs[read2];
    end
end

endmodule