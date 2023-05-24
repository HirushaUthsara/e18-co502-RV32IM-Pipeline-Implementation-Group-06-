`timescale  1ns/100ps

module Instructionfetch (
    CLK,
    RESET,
    Datamem_busywait,
    JumpBranch,
    PC,
    PC_Four,
    JumpBranch_PC,
    PCMUX,
    PCvalue
);

// defining the output reg 
output reg [31:0] PC, PC_Four, PCMUX;
// defining the input wires
input wire  CLK, RESET, Datamem_busywait, JumpBranch;
input wire [31:0] JumpBranch_PC, PCvalue;

// defining the busywait signal
wire busywait;

// OR operation with busywait signal and store the value to the busywait signal
or(busywait, Datamem_busywait);

// when reset happen then PC-4
always @(RESET) begin
    PC = -4;
end

// IF pc SIGNAL CHANGE THEN THE pc +4
always @(PC) begin
    #2
    PC_Four = PC+4;
end

// selecting the output of the PCMUX according to the jumpbranch signals
always @(*)begin
    case (JumpBranch)
        1'b1:begin
            PCMUX =JumpBranch_PC;
        end
        1'b0:begin
            PCMUX = PC_Four;
        end
endcase
end

// checking whether the datamamemory is busy or not using ositive edge of the clock and busywait signal,
// if datamemory is not busy, then write PC
always @(posedge CLK) begin
    #2 
    if(busywait == 1'b0)begin
        PC = PCvalue;
    end
end

endmodule