`timescale 1ns/100ps
// delay of 1 time unit  
// mux for the mux1,mux2 and mux4 in datapath, pcmux
module MUX_A(INPUT1, INPUT2, OUT, SELECT);

    input [31:0] INPUT1, INPUT2;
    input  SELECT;
    output [31:0] OUT;
    
    assign OUT = (SELECT) ? INPUT2 : INPUT1; 

endmodule

// mux for the mux3 in datapath
module MUX_B(INPUT1, INPUT2, INPUT3, SELECT, OUT);

    input [31:0] INPUT1, INPUT2, INPUT3;
    input [1:0] SELECT;
    output [31:0] OUT;
    
    assign OUT = (SELECT[1]) ? (SELECT[0]? 32'bx:INPUT3) : (SELECT[0]? INPUT2:INPUT1) ;

endmodule

module MUX_C(INPUT1, INPUT2, INPUT3, INPUT4, INPUT5, SELECT, OUT);
     
     //declare the ports
    input [31:0] INPUT1, INPUT2, INPUT3, INPUT4, INPUT5;
    input [2:0] SELECT;
    output reg [31:0] OUT;

    always @ (*) begin
        case (SELECT)
			3'b100: OUT = INPUT5;
            3'b011: OUT = INPUT4;
            3'b010: OUT = INPUT3;
            3'b001: OUT = INPUT2;
            default: OUT = INPUT1;
        endcase
    end

endmodule