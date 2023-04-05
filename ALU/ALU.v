`timescale 1ns/100ps // defining the time units used in the system

module ALU(DATA1, DATA2, RESULT, SELECT, ZERO, SIGN_BIT, SLTU_BIT):
    input[31:0] DATA1, DATA2;   // defining variables to get the input values
    input[4:0] SELECT;          // variable to store the ALU opcode
    output reg[31:0] RESULT;    // variable to store the result of the ALU
    output ZERO, SIGN_BIT, SLTU_BIT;

// defining variables to store the results of each airthmatic operation
    wire[31:0]  AND_RES,    // and operation
                OR_RES,     // or operation
                XOR_RES,    // xor operation 
                ADD_RES,    // addition operation
                SUB_RES,    // subtraction
                SLL_RES,    // shift left logical
                SRL_RES,    // shift right logical
                SRA_RES,    // shift right airthmatic
                FWD_RES,    // forward operation
                MUL_RES,    // multiplication
                MULH_RES,   // multiplication higher signed * signed
                MULHU_RES,  // multiplication higher unsigned * unsigned
                MULHSU_RES, // multiplication higher signed * unsigned
                DIV_RES,    // division
                DIVU_RES,       // unsigned division
                REM_RES,    // signed remainder
                REMU_RES,    // unsigned remainder
                SLT_RES,    // less than
                SLTU_RES;   // less than unsigned


    assign zero = ~(|RESULT|);
    assign SIGN_BIT = RESULT[31];
    assign SLTU_BIT = SLTU_RES[0]; 

    // operating bitwise operations with 3 time unit delay

    //R type instructions
    assign  #1 AND_RES = DATA1 & DATA2;
    assign  #1 OR_RES = DATA1 | DATA2;
    assign  #1 XOR_RES = DATA1 ^ DATA2;
    assign  #2 ADD_RES = DATA1 + DATA2;
    assign  #2 SUB_RES = DATA1 - DATA2;

    // forwading operation
    assign  #3 FWD_RES = DATA2;
    

    // shift operations
    assign  #1 SLL_RES = DATA1 << DATA2;
    assign  #1 SRL_RES = DATA1 >> DATA2;
    assign  #1 SRA_RES = DATA1 >>> DATA2;

    // multipication operation
    assign  #3 MUL_RES = DATA1 * DATA2;
    assign  #3 MULH_RES = $signed(DATA1) * $signed(DATA2);
    assign  #3 MULHU_RES = $unsigned(DATA1) * $unsigned(DATA2);
    assign  #3 MULHSU_RES = $signed(DATA1) * $unsigned(DATA2);

    // division operation
    assign  #3 DIV_RES = DATA1 / DATA2;
    assign  #3 DIVU_RES = $unsigned(DATA1) / $unsigned(DATA2);


    // remainder operations
    assign  #3 REM_RES = $signed(DATA1) % $signed(DATA2);
    assign  #3 REMU_RES = $unsigned(DATA1) % $unsigned(DATA2);

    // set the output value according to the comparison of DATA1 and DATA2
    assign  #1 SLT_RES = ($signed(DATA1) < $signed(DATA2)) ? 32'd1 : 32'd0;
    assign  #1 SLTU_RES = ($unsigned(DATA1) < $unsigned(DATA2)) ? 32'd1 : 32'd0;


    always@(*)
    begin
        case(SELECT)
        8'b00000000: begin
            RESULT = ADD;
        end
        8'b00000001: begin
            RESULT = SUB;
        end
        8'b00000010: begin
            RESULT = AND;
        end
        8'b00000011: begin
            RESULT = OR;
        end
        8'b00000100: begin
            RESULT = XOR;
        end
        8'b00000101: begin
            RESULT = SLL;
        end
        8'b00000110: begin
            RESULT = SRL;
        end
        8'b00000111: begin
            RESULT = SRA;
        end
        8'b00001000: begin
            RESULT = MUL;
        end
        8'b00001001: begin
            RESULT = MULH;
        end
        8'b00001010: begin
            RESULT = MULHU;
        end
        8'b00001011: begin
            RESULT = MULHSU;
        end
        8'b00001100: begin
            RESULT = DIV;
        end
        8'b00001101: begin
            RESULT = DIVU;
        end
        8'b00001110: begin
            RESULT = REM;
        end
        8'b00001111: begin
            RESULT = REMU
        end
        8'b00010000: begin
            RESULT = SLT;
        end
        8'b00010001: begin
            RESULT = SLTU;
        end
        default:RESULT = 31'd0;
    endcase
    end


endmodule


/*multiplication higher signed * signed
For example, if you multiply a signed variable with a 4-bit width by another signed variable with a 3-bit width, 
the result will be a signed variable with a bit width of 7 (4 + 3).However, if both operands have the same bit width, 
the result will have twice the bit width of the operands, to accommodate the possibility of overflow.When multiplying
signed variables, the result can be positive or negative, depending on the signs of the operands. If both operands 
have the same sign (both positive or both negative), the result will be positive. If the operands have opposite signs, 
the result will be negative.It is important to note that signed multiplication can result in overflow, which occurs when 
the result is too large to be represented in the allocated bit width. To prevent overflow, you can use larger bit widths 
or scaling factors to reduce the magnitude of the operands before multiplication.*/


/*multiplication higher unsigned * unsigned
It is important to note that unsigned multiplication can result in overflow, which occurs when the result is too large to be 
represented in the allocated bit width. To prevent overflow, you can use larger bit widths or scaling factors to reduce the 
magnitude of the operands before multiplication.
*/


/*multiplication higher signed * unsigned
It is important to note that signed multiplication can result in overflow, which occurs when the result is too large to be 
represented in the allocated bit width. To prevent overflow, you can use larger bit widths or scaling factors to reduce the 
magnitude of the operands before multiplication.
*/


/*

BR_BEQ - Branch on Equal: This branch output signal is set when two operands are equal. 

BR_BNE - Branch on Not Equal: This branch output signal is set when two operands are not equal.

BR_BLT - Branch on Less Than: This branch output signal is set when one operand is less than another operand. 

BR_BGE - Branch on Greater Than or Equal: This branch output signal is set when one operand is greater than or equal to another operand. 

BR_BLTU - Branch on Less Than Unsigned: This branch output signal is set when one operand is less than another operand, 

BR_BGEU - Branch on Greater Than or Equal Unsigned: This branch output signal is set when one operand is greater than or equal to 
another operand,


zero_signal:
zero_signal typically refers to a signal or a flag that is set to indicate whether the result of an operation is zero or not. 
For example, in a processor's ALU (Arithmetic Logic Unit), after performing an arithmetic or logical operation, a zero_signal 
may be set to 1 if the result is zero, and 0 otherwise. This zero_signal can then be used by subsequent instructions or operations 
that depend on the result of the previous operation.

sign_bit_signal:
sign_bit_signal refers to a signal or a bit that represents the sign of a number. In computers, numbers are represented in binary 
form using a fixed number of bits. The leftmost bit in the binary representation is called the sign bit. If this bit is 0, then the 
number is positive; if it is 1, then the number is negative. For example, in an 8-bit binary number, if the sign bit is 1, then the 
number is in the range -128 to -1, and if it is 0, then the number is in the range 0 to 127.

sltu_bit_signal:
sltu_bit_signal typically refers to a signal or a bit that is set to 1 if an unsigned integer comparison is true, and 0 otherwise. 
In computer architecture, the SLTU instruction (Set Less Than Unsigned) compares two unsigned integers and sets a register or flag 
to 1 if the first operand is less than the second operand, and to 0 otherwise. The sltu_bit_signal is set to the output of this 
comparison, and can be used by subsequent instructions or operations that depend on the result of the comparison.
*/