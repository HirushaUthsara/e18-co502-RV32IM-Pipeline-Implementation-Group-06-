//timescale directive sets the base time unit and precision for the simulation. In this example, it sets the base time unit to 
//1 nanosecond and the precision to 100 picoseconds. 
`timescale 1ns/100ps

module instruction_cache(
    input wire clock,
    input wire reset,
    input wire [31:0] address,
    output reg [31:0] readinst,
    output reg busywait,
    output reg [27:0] mem_address,
    output reg mem_read,
    input wire [127:0] mem_readinst,
    input wire mem_busywait
);
    reg [127:0] inst_cache [0:7];
    reg inst_valid [0:7];
    reg [24:0] inst_tag [0:7];
    reg [1:0] state, next_state;
    wire [2:0] index = address[6:4];
    reg [127:0] data_out;
    reg valid_out, tag_status, hit;

    always @(posedge clock or posedge reset) begin
        if (reset)
            state <= 2'b00;
        else
            state <= next_state;
    end

    always @(*) begin                   // FSM machine state change
        case (state)
            2'b00: begin
                if (!hit && (address != -32'd4))
                    next_state = 2'b01;
                else
                    next_state = 2'b00;
            end

            2'b01: begin
                if (!mem_busywait)
                    next_state = 2'b10;
                else
                    next_state = 2'b01;
            end

            2'b10: begin
                next_state = 2'b00;
            end
        endcase
    end

    always @(*) begin
        case (index)
            2'b00: begin
                data_out = inst_cache[0];
                valid_out = inst_valid[0];
            end
            2'b01: begin
                data_out = inst_cache[1];
                valid_out = inst_valid[1];
            end
            2'b10: begin
                data_out = inst_cache[2];
                valid_out = inst_valid[2];
            end
            2'b11: begin
                data_out = inst_cache[3];
                valid_out = inst_valid[3];
            end
        endcase

        tag_status = (inst_tag[index] == address[31:7]) ? 1'b1 : 1'b0;
        hit = valid_out & tag_status;

        if (hit) begin
            case (address[3:2])
                2'b00: readinst = data_out[31:0];
                2'b01: readinst = data_out[63:32];
                2'b10: readinst = data_out[95:64];
                2'b11: readinst = data_out[127:96];
            endcase
        end else begin
            readinst = 32'bx;
        end
    end

    always @(posedge clock) begin
        if (hit)
            busywait <= 0;
        else if (address != -32'd4)
            busywait <= 1;
    end

    always @(*) begin
        case (state)
            2'b00: begin
                mem_read = 0;
                mem_address = 28'dx;
            end

            2'b01: begin
                mem_read = 1;
                mem_address = address[31:4];
            end

            2'b10: begin
                mem_read = 0;
                inst_cache[index] <= mem_readinst;
                inst_valid[index] <= 1;
                inst_tag[index] <= address[31:7];
            end
        endcase
    end

    integer i;

    always @(*) begin
        if (reset) begin
            for ( i = 0; i < 8; i = i + 1) begin
                inst_valid[i] = 0;
                inst_tag[i] = 25'bx;
                inst_cache[i] = 128'dx;
            end
        end
    end
endmodule

