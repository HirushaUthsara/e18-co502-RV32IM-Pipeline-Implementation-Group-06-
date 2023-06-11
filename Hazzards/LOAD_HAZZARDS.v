`timescale 1ns/100ps

module LOAD_HAZZARDS (
    clk,
    reset,
    load_signal,
    rd_mem_stage,
    rs1_alu_stage,
    rs2_alu_stage,
    forward_from_wb_stage_to_rs1,
    forward_from_wb_stage_to_rs2,
    bubble_enable
);

    // Port declaration
    input clk, reset, load_signal;
    input [4:0] rd_mem_stage, IFstage_Rs1, IFstage_Rs2, rs1_alu_stage, rs2_alu_stage;
    output reg forward_from_wb_stage_to_rs1, forward_from_wb_stage_to_rs2, bubble_enable;

    wire [4:0] alu_rs1_xor_wire, alu_rs2_xor_wire;
    wire alu_rs1_compare, alu_rs2_compare, bubble;

    // Identify hazards and compare source registers with destination registers
    assign #1 alu_rs1_xor_wire = (rd_mem_stage ^ rs1_alu_stage); // Bitwise XOR between rd_mem_stage and rs1_alu_stage
    assign #1 alu_rs2_xor_wire = (rd_mem_stage ^ rs2_alu_stage); // Bitwise XOR between rd_mem_stage and rs2_alu_stage
    assign #1 alu_rs1_compare = (&alu_rs1_xor_wire); // Result of ANDing all bits of alu_rs1_xor_wire
    assign #1 alu_rs2_compare = (&alu_rs2_xor_wire); // Result of ANDing all bits of alu_rs2_xor_wire
    assign #1 bubble = alu_rs1_compare | alu_rs2_compare; // Bubble signal is set when either alu_rs1_compare or alu_rs2_compare is true

    always @(posedge clk) begin
        #1 // Combinational logic delay

        // Set the signals
        if (load_signal) begin
            forward_from_wb_stage_to_rs1 = alu_rs1_compare; // Set forward_from_wb_stage_to_rs1 to alu_rs1_compare
            forward_from_wb_stage_to_rs2 = alu_rs2_compare; // Set forward_from_wb_stage_to_rs2 to alu_rs2_compare
            bubble_enable = bubble; // Set bubble_enable to bubble
        end
        else begin
            forward_from_wb_stage_to_rs1 = 1'b0; // Reset forward_from_wb_stage_to_rs1 to 0
            forward_from_wb_stage_to_rs2 = 1'b0; // Reset forward_from_wb_stage_to_rs2 to 0
            bubble_enable = 1'b0; // Reset bubble_enable to 0
        end
    end

    always @(reset) begin
        if (reset) begin
            // Reset all signals to zero
            forward_from_wb_stage_to_rs1 = 1'b0; // Reset forward_from_wb_stage_to_rs1 to 0
            forward_from_wb_stage_to_rs2 = 1'b0; // Reset forward_from_wb_stage_to_rs2 to 0
            bubble_enable = 1'b0; // Reset bubble_enable to 0
        end
    end
endmodule
