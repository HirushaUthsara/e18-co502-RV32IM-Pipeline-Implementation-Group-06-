`timescale 1ns/100ps

// Define a module called "PC"
module PC(CLOCK, RESET, NEXTPC, PC);

// Declare inputs and outputs of the module
    input CLOCK, RESET;
    input [31:0] NEXTPC;
    input [31:0] PC;

// Initialize the PC to start at address 0 when the reset input is triggered
    always @(RESET) begin
        #1
        PC = ~4;    
    end

 // Update the PC with the next program counter value on the positive edge of the clock signal
    always @(posedge CLOCK) begin
        #1
        begin
            PC = NEXTPC; // Update the PC with the value of the next program counter
        end
        
    end

endmodule




