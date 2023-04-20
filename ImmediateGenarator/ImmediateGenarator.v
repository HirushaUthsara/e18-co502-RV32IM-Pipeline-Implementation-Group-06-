`timescale 1ns/100ps

module IMMEDIATE_GEN(INSTRUCTION, SELECT, OUT);

    input [31:0] INSTRUCTION;
    input [3:0] SELECT;
    output reg [31:0] OUT;

    wire [19:0] COMB1, COMB2;
    wire [11:0] COMB3, COMB4, COMB5;
    wire [4:0] TYPE6;

    assign COMB1 = INSTRUCTION[31:12];
    assign COMB2 = INSTRUCTION[31:12];
    assign COMB3 = INSTRUCTION[31:20];
    assign COMB4 = {INSTRUCTION[31:25], INSTRUCTION[11:7]};
    assign COMB5 = {INSTRUCTION[31:25], INSTRUCTION[11:7]};
    assign COMB6 = INSTRUCTION[19:25];

    always @(*) begin
        case(SELECT[2:0])
        3'b000:
            OUT = {COMB1,{12{1'b0}}};

        3'b001:
            if (SELECT[3] == 1'b1) 
                OUT = {{11{1'b0}}, COMB2, 1'b0};
            else
                OUT = {{11{INSTRUCTION[31]}}, INSTRUCTION[31], INSTRUCTION[19:12], INSTRUCTION[20], INSTRUCTION[30:21], 1'b0};
        
        3'b010:
            if(SELECT[3] == 1'b1)
                OUT = {{20{1'b0}}, COMB3};
            else
                OUT = {{20{COMB3[11]}}, COMB3};
        
        3'b011:
            if(SELECT[3] == 1'b1)
                OUT = {{20{1'b0}}, INSTRUCTION[31], INSTRUCTION[7], INSTRUCTION[30:25], INSTRUCTION[11:8], 1'b0}; 
            else
                OUT = {{20{INSTRUCTION[31]}}, INSTRUCTION[31], INSTRUCTION[7], INSTRUCTION[30:25], INSTRUCTION[11:8], 1'b0};

        3'b100:
            if(SELECT[3] == 1'b1)
                OUT = {{20{1'b0}}, COMB5};
            else
                OUT = {{20{COMB5[11]}}, COMB5};

        3'b101:
            OUT = {{27{1'b0}}, COMB6};

    endcase
    end

endmodule