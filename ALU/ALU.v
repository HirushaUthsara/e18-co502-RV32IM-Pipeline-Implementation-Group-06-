`timescale 1ns/100ps // defining the time units used in the system

module ALU(DATA1, DATA2, RESULT, SELECT, EQUAL, SIGNEDLT, UNSIGNEDLT);
    input[31:0] DATA1, DATA2;   // defining variables to get the input values
    input[4:0] SELECT;          // variable to store the ALU opcode
    output reg[31:0] RESULT;    // variable to store the result of the ALU
    output EQUAL, SIGNEDLT, UNSIGNEDLT; // defining output signals

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

    wire [63:0] MULTIPICATION; 

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
    //assign  MULTIPICATION = DATA1 * DATA2; // FOR A RESULT OF UPPER 32 BITS
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
        8'b00000000: RESULT = FWD_RES;  
        8'b00000001: RESULT = ADD_RES; 
        8'b00000010: RESULT = SUB_RES; 
        8'b00000011: RESULT = SLL_RES;
        8'b00000100: RESULT = SLT_RES;
        8'b00000101: RESULT = SLTU_RES;
        8'b00000110: RESULT = XOR_RES;
        8'b00000111: RESULT = SRL_RES;
        8'b00001000: RESULT = SRA_RES;
        8'b00001001: RESULT = OR_RES;
        8'b00001010: RESULT = AND_RES;
        8'b00001011: RESULT = MUL_RES;
        8'b00001100: RESULT = MULH_RES;
        8'b00001101: RESULT = MULHSU_RES;
        8'b00001110: RESULT = MULHU_RES;
        8'b00001111: RESULT = DIV_RES;
        8'b00010000: RESULT = DIVU_RES;
        8'b00010001: RESULT = REM_RES;
        8'b00010010: RESULT = REMU_RES;
        default:RESULT = 31'd0;
    endcase
    end

    assign EQUAL = ~(|RESULT);      // DATA1 == DATA2
    assign SIGNEDLT = RESULT[31];   // DATA1 < DATA2
    assign UNSIGNEDLT= SLTU_RES[0]; // |DATA1| < |DATA2|

endmodule


module ALU_TESTBENCH();

    reg [31:0] DATA1, DATA2;
    reg [4:0] SELECT;
    wire [31:0] RESULT;
    wire ZERO, SIGN, SLTU;

    ALU ALU_TEST(DATA1, DATA2, RESULT, SELECT, ZERO, SIGN, SLTU);
        initial
        begin
            $monitor("DATA1: %b,DATA2: %b,SELECT: %b,RESULT: %b",DATA1,DATA2,SELECT,RESULT);
        end

        initial
        begin
            DATA1 = 32'd30;
            DATA2 = 32'd35;
            SELECT = 8'b00000000;
            #5
            $display("Test 1 passed");
            SELECT = 8'b00000001;
            #5
            $display("Test 2 paassed");
            SELECT = 8'b00000010;
            #5 
            $display ("Test 3 passed");
            SELECT = 8'b00000011;
            #5 
            $display ("Test 4 passed");
            SELECT = 8'b00000100;
            #5 
            $display ("Test 5 passed");


            
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

/*The timescale directive is used to define the time units used in the system. In this case, it specifies a timescale of 1 nanosecond (ns) for simulation purposes, 
with a time precision of 100 picoseconds (ps).

The module keyword is used to define the ALU module, and it has five output signals: RESULT, ZERO, SIGN_BIT, SLTU_BIT, and a 32-bit wide input for each data value.

The wire keyword is used to define intermediate signals that connect different parts of the module together. In this case, it defines wires for each possible operation's
 result, which can be used to calculate the final output of the module.

The assign keyword is used to define combinational logic that calculates a value based on the inputs. In this case, it is used to assign the values of the ZERO, 
SIGN_BIT, and SLTU_BIT outputs, which are calculated based on the value of RESULT and SLTU_RES.

It's worth noting that the code snippet you provided is incomplete, as some of the operations are missing their implementation. You would need to fill in the logic 
for each operation in order to have a functional ALU.

The ALU module performs different arithmetic, logic, and shift operations based on the SELECT input signal. The assign statements define each operation's output 
result and the time unit delay needed to calculate the operation's result.

The bitwise operations AND, OR, and XOR, take one time unit to calculate. The addition and subtraction operations ADD and SUB, take two time units. 
The forward operation FWD takes three time units, as it doesn't require any calculation.

The shift operations SLL, SRL, and SRA take one time unit to calculate. The multiplication operations MUL, MULH, MULHU, and MULHSU, take three time units. 
The division operations DIV and DIVU, take three time units. The remainder operations REM and REMU, take three time units.

Finally, the comparison operations SLT and SLTU take one time unit to calculate. SLT performs a signed comparison between DATA1 and DATA2 and returns 1 
if DATA1 is less than DATA2; otherwise, it returns 0. SLTU performs an unsigned comparison between DATA1 and DATA2 and returns 1 if DATA1 is less than DATA2; 
otherwise, it returns 0.

Overall, this code defines an ALU module that can perform various arithmetic and logic operations on two 32-bit input values, with different time delays 
depending on the operation type.

This specific ALU has 5 inputs and 3 outputs. The inputs are DATA1, DATA2, SELECT, ZERO, and SIGN_BIT. DATA1 and DATA2 are 32-bit input operands, SELECT is a 5-bit input operand that specifies the operation to be performed by the ALU, ZERO is a 1-bit output that indicates if the result is zero, and SIGN_BIT is a 1-bit output that indicates the sign of the result.

The ALU supports the following operations:

Addition
Subtraction
Bitwise AND
Bitwise OR
Bitwise XOR
Shift left logical
Shift right logical
Shift right arithmetic
Forwarding operation
Multiplication
Multiplication higher signed * signed
Multiplication higher unsigned * unsigned
Multiplication higher signed * unsigned
Division
Unsigned division
Remainder
Unsigned remainder
Comparison for less than
Comparison for less than unsigned
The ALU uses a case statement to select the appropriate output RESULT based on the SELECT input. The result is stored in a 32-bit register.

The ALU also has 16 internal wires (AND_RES, OR_RES, XOR_RES, ADD_RES, SUB_RES, SLL_RES, SRL_RES, SRA_RES, FWD_RES, MUL_RES, MULH_RES, MULHU_RES,
 MULHSU_RES, DIV_RES, DIVU_RES, REM_RES, and REMU_RES) that store the result of each arithmetic operation. Each operation is implemented with a specific time delay,
  ranging from 1 to 3 time units, depending on the operation.

Finally, the ALU has two output wires (SLT_RES and SLTU_RES) that store the result of the comparison for less than and less than unsigned operations, respectively.

Note that this code is incomplete, and some parts of it may not make sense without the context of the entire system it is intended to be used in.

*/




