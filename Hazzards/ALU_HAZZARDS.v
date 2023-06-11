`timescale 1ns/100ps

module ALU_HAZZARDS(CLK, RESET, ADDRESS_MEM_STAGE, ADDRESS_ALU_STAGE,
                    SREG1, SREG2, MEM_TO_SREG1, MEM_TO_SREG2, WB_TO_SREG1, WB_TO_SREG2);
        
    input CLK, RESET;
    input [4:0] ADDRESS_MEM_STAGE, ADDRESS_ALU_STAGE, SREG1, SREG2;
    output reg MEM_TO_SREG1, MEM_TO_SREG2, WB_TO_SREG1, WB_TO_SREG2;

    wire [4:0] ALU_SREG1_XNOR, ALU_SREG2_XNOR, MEM_SREG1_XNOR, MEM_SREG2_XNOR;
    wire ALU_SREG1_COMPARE, ALU_SREG2_COMPARE, MEM_SREG1_COMPARE, MEM_SREG2_COMPARE;

    // XNOR operation to compare ALU stage address and SREG1/SREG2 addresses
    assign #1 ALU_SREG1_XNOR = (ADDRESS_ALU_STAGE ~^ SREG1); 
    assign #1 ALU_SREG2_XNOR = (ADDRESS_ALU_STAGE ~^ SREG2);
    // Taking the bitwise AND of the XNOR result to determine equality
    assign #1 ALU_SREG1_COMPARE = (&ALU_SREG1_XNOR);
    assign #1 ALU_SREG2_COMPARE = (&ALU_SREG2_XNOR);

    // XNOR operation to compare MEM stage address and SREG1/SREG2 addresses
    assign #1 MEM_SREG1_XNOR = (ADDRESS_MEM_STAGE ~^ SREG1); 
    assign #1 MEM_SREG2_XNOR = (ADDRESS_MEM_STAGE ~^ SREG2);
    // Taking the bitwise AND of the XNOR result to determine equality
    assign #1 MEM_SREG1_COMPARE = (&MEM_SREG1_XNOR);
    assign #1 MEM_SREG2_COMPARE = (&MEM_SREG2_XNOR);

    always @(posedge CLK) begin
        // On every positive edge of the clock
        #1  
        MEM_TO_SREG1 = ALU_SREG1_COMPARE; // Assign ALU-SREG1 comparison result to MEM_TO_SREG1
        MEM_TO_SREG2 = ALU_SREG2_COMPARE; // Assign ALU-SREG2 comparison result to MEM_TO_SREG2
        WB_TO_SREG1 = MEM_SREG1_COMPARE; // Assign MEM-SREG1 comparison result to WB_TO_SREG1
        WB_TO_SREG2 = MEM_SREG2_COMPARE; // Assign MEM-SREG2 comparison result to WB_TO_SREG2
    end

    always @(RESET) begin
        // On reset signal
        if (RESET == 1'b1) begin
            // Reset the values to zero
            #1  
            MEM_TO_SREG1 = 1'b0;
            MEM_TO_SREG2 = 1'b0;
            WB_TO_SREG1 = 1'b0;
            WB_TO_SREG2 = 1'b0;
        end
    end

endmodule


/*
rd_address_mem_stage: This parameter likely represents the address of a register or memory location being accessed in the memory stage of a processor pipeline. It could be used to read data from or write data to a specific location in memory.

rd_address_alu_stage: This parameter likely represents the address of a register being accessed in the ALU (Arithmetic Logic Unit) stage of a processor pipeline. It could be used to perform arithmetic or logical operations on the data stored in the specified register.

rs1_address_id_stage: This parameter likely represents the address of the first source register being accessed in the instruction decode (ID) stage of a processor pipeline. It indicates the register from which data is being read for use in subsequent stages or operations.

rs2_address_id_stage: This parameter likely represents the address of the second source register being accessed in the instruction decode (ID) stage of a processor pipeline. It indicates the register from which data is being read for use in subsequent stages or operations.

forward_from_mem_stage_to_rs1_signal: This parameter likely represents a signal that enables or indicates the forwarding of data from the memory stage of the pipeline to the first source register (rs1). Forwarding allows the data produced in a later stage to be used by an instruction in an earlier stage, avoiding data hazards.

forward_from_mem_stage_to_rs2_signal: This parameter likely represents a signal that enables or indicates the forwarding of data from the memory stage of the pipeline to the second source register (rs2). Similar to the previous parameter, this allows data to be forwarded to an earlier stage to prevent hazards.

forward_from_wb_stage_to_rs1_signal: This parameter likely represents a signal that enables or indicates the forwarding of data from the write-back (WB) stage of the pipeline to the first source register (rs1). This forwarding mechanism helps resolve data hazards by providing the most up-to-date data to an instruction that depends on it.

forward_from_wb_stage_to_rs2_signal: This parameter likely represents a signal that enables or indicates the forwarding of data from the write-back (WB) stage of the pipeline to the second source register (rs2). It serves a similar purpose to the previous parameter but for the second source register.



rdAlu_rs1Id_xnor_wire: This wire port represents the output of a bitwise XNOR operation performed on the rd_address_alu_stage signal and the rs1_address_id_stage signal. It indicates whether the two addresses are equal or not. The result is stored in a 5-bit vector, where each bit corresponds to a specific bit position of the two input addresses.

rdAlu_rs2Id_xnor_wire: This wire port represents the output of a bitwise XNOR operation performed on the rd_address_alu_stage signal and the rs2_address_id_stage signal. It determines the equality of the two addresses and stores the result in a 5-bit vector.

rdMem_rs1Id_xnor_wire: This wire port represents the output of a bitwise XNOR operation performed on the rd_address_mem_stage signal and the rs1_address_id_stage signal. It checks whether the two addresses are equal or not, and the result is stored in a 5-bit vector.

rdMem_rs2Id_xnor_wire: This wire port represents the output of a bitwise XNOR operation performed on the rd_address_mem_stage signal and the rs2_address_id_stage signal. It determines the equality of the two addresses and stores the result in a 5-bit vector.
*/