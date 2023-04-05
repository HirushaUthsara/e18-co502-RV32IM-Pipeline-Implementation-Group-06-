`timescale 1ns/100ps // defining the time units used in the system

module ALU(DATA1, DATA2, RESULT, BRANCH, SELECT):
    input[31:0] DATA1, DATA2;   // defining variables to get the input values
    input[4:0] SELECT;          // variable to store the ALU opcode
    output reg[31:0] RESULT;    // variable to store the result of the ALU
    output reg BRANCH;          // storing the branch output

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
                REM_RES,    // signed remainder
                REMU_RES,    // unsigned remainder
                SLT_RES,    // less than
                SLTU_RES;   // less than unsigned

    // variables for branch outputs
    wire BEQ, BNE, BLT, BGE, BLTU, BGEU;

    // operating bitwise operations with 3 time unit delay

    // and, or, xor operations
    assign  #3 AND_RES = DATA1 & DATA2;
    assign  #3 OR_RES = DATA1 | DATA2;
    assign  #3 XOR_RES = DATA1 ^ DATA2;

    // forwading operation
    assign  #3 FWD_RES = DATA2;

    // addition and substracting operation
    assign  #3 ADD_RES = DATA1 + DATA2;
    assign  #3 SUB_RES = DATA1 - DATA2;

    // shift operations
    assign  #3 SLL_RES = DATA1 << DATA2;
    assign  #3 SRL_RES = DATA1 >> DATA2;
    assign  #3 SRA_RES = DATA1 >>> DATA2;

    // multipication operation
    assign  #3 MUL_RES = DATA1 * DATA2;
    assign  #3 MULH_RES = $signed(DATA1) * $signed(DATA2);
    assign  #3 MULHU_RES = $unsigned(DATA1) * $unsigned(DATA2);
    assign  #3 MULHSU_RES = $signed(DATA1) * $unsigned(DATA2);

    // division operation
    assign  #3 DIV_RES = DATA1 / DATA2;

    // remainder operations
    assign  #3 REM_RES = $signed(DATA1) % $signed(DATA2);
    assign  #3 REMU_RES = $unsigned(DATA1) % $unsigned(DATA2);

    // set the output value according to the comparison of DATA1 and DATA2
    assign  #3 SLT_RES = ($signed(DATA1) < $signed(DATA2)) ? 1'b1 : 1'b0;
    assign  #3 SLTU_RES = ($unsigned(DATA1) < $unsigned(DATA2)) ? 1'b1 : 1'b0;


    // getting branch signals
    assign #3 BEQ = (DATA1==DATA2);
    assign #3 BNE = (DATA1 != DATA2);S
    assign #3 BLT = ($signed(DATA1) < $signed(DATA2));
    assign #3 BGE = ($signed(DATA1) >= $signed(DATA2));
    assign #3 BLTU = ($unsigned(DATA1) < $unsigned(DATA2)SS);
    assign #3 BGEU = ;

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

BR_BGEU - Branch on Greater Than or Equal Unsigned: This branch output signal is set when one operand is greater than or equal to another operand,

*/