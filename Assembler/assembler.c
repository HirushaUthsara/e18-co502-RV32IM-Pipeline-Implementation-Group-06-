#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_KEYWORD_LENGTH 10

typedef struct {
    char keyword[MAX_KEYWORD_LENGTH];
    char *opcode;
    char *type;
    char *func3;
    char *func7;
} Instruction;

Instruction instructions[] = {
    {"mul", "0110011", "R_TYPE", "000", "0000001"},
    {"mulh", "0110011", "R_TYPE", "001", "0000001"},
    {"mulhsu", "0110011", "R_TYPE", "010", "0000001"},
    {"mulhu", "0110011", "R_TYPE", "011", "0000001"},
    {"div", "0110011", "R_TYPE", "100", "0000001"},
    {"divu", "0110011", "R_TYPE", "101", "0000001"},
    {"rem", "0110011", "R_TYPE", "110", "0000001"},
    {"remu", "0110011", "R_TYPE", "111", "0000001"},
    {"add", "0110011", "R_TYPE", "000", "0000000"},
    {"sub", "0110011", "R_TYPE", "000", "0100000"},
    {"sll", "0110011", "R_TYPE", "001", "0000000"},
    {"slt", "0110011", "R_TYPE", "010", "0000000"},
    {"sltu", "0110011", "R_TYPE", "011", "0000000"},
    {"xor", "0110011", "R_TYPE", "100", "0000000"},
    {"srl", "0110011", "R_TYPE", "101", "0000000"},
    {"sra", "0110011", "R_TYPE", "101", "0100000"},
    {"or", "0110011", "R_TYPE", "110", "0000000"},
    {"and", "0110011", "R_TYPE", "111", "0000000"},
    {"lb", "0000011", "I_TYPE", "000", NULL},
    {"lh", "0000011", "I_TYPE", "001", NULL},
    {"lw", "0000011", "I_TYPE", "010", NULL},
    {"lbu", "0000011", "I_TYPE", "100", NULL},
    {"lhu", "0000011", "I_TYPE", "101", NULL},
    {"addi", "0010011", "I_TYPE", "000", NULL},
    {"slti", "0010011", "I_TYPE", "010", NULL},
    {"sltiu", "0010011", "I_TYPE", "011", NULL},
    {"xori", "0010011", "I_TYPE", "100", NULL},
    {"ori", "0010011", "I_TYPE", "110", NULL},
    {"andi", "0010011", "I_TYPE", "111", NULL},
    {"slli", "0010011", "SHIFT_TYPE", "001", NULL},
    {"srli", "0010011", "SHIFT_TYPE", "101", NULL},
    {"srai", "0010011", "SHIFT_TYPE", "101", "0100000"},
    {"jalr", "1100111", "I_TYPE", "000", NULL},
    {"sb", "0100011", "S_TYPE", "000", NULL},
    {"sh", "0100011", "S_TYPE", "001", NULL},
    {"sw", "0100011", "S_TYPE", "010", NULL},
    {"beq", "1100011", "SB_TYPE", "000", NULL},
    {"bne", "1100011", "SB_TYPE", "001", NULL},
    {"blt", "1100011", "SB_TYPE", "100", NULL},
    {"bge", "1100011", "SB_TYPE", "101", NULL},
    {"bltu", "1100011", "SB_TYPE", "110", NULL},
    {"bgeu", "1100011", "SB_TYPE", "111", NULL},
    {"lui", "0110111", "U_TYPE", NULL, NULL},
    {"auipc", "0010111", "U_TYPE", NULL, NULL},
    {"jal", "1101111", "UJ_TYPE", NULL, NULL}
};

char *getOpcode(char *keyword) {
    int numInstructions = sizeof(instructions) / sizeof(instructions[0]);
    for (int i = 0; i < numInstructions; i++) {
        if (strcmp(instructions[i].keyword, keyword) == 0) {
            return instructions[i].opcode;
        }
    }
    return NULL;
}

char *getType(char *keyword) {
    int numInstructions = sizeof(instructions) / sizeof(instructions[0]);
    for (int i = 0; i < numInstructions; i++) {
        if (strcmp(instructions[i].keyword, keyword) == 0) {
            return instructions[i].type;
        }
    }
    return NULL;
}

char *getFunc3(char *keyword) {
    int numInstructions = sizeof(instructions) / sizeof(instructions[0]);
    for (int i = 0; i < numInstructions; i++) {
        if (strcmp(instructions[i].keyword, keyword) == 0) {
            return instructions[i].func3;
        }
    }
    return NULL;
}

char *getFunc7(char *keyword) {
    int numInstructions = sizeof(instructions) / sizeof(instructions[0]);
    for (int i = 0; i < numInstructions; i++) {
        if (strcmp(instructions[i].keyword, keyword) == 0) {
            return instructions[i].func7;
        }
    }
    return NULL;
}

void encodeInstruction(char *keyword, char *rd_register, char *rs1_register, char *rs2_register, char *immediate, char *base_register) {
    char *opcode = getOpcode(keyword);
    char *type = getType(keyword);
    char *func3 = getFunc3(keyword);
    char *func7 = getFunc7(keyword);

    if (opcode == NULL || type == NULL || (func3 == NULL && func7 == NULL)) {
        printf("Invalid instruction!\n");
        return;
    }

    printf("Opcode: %s\n", opcode);
    printf("Type: %s\n", type);
    if (func3 != NULL) {
        printf("Func3: %s\n", func3);
    }
    if (func7 != NULL) {
        printf("Func7: %s\n", func7);
    }
    printf("rd_register: %s\n", rd_register);
    printf("rs1_register: %s\n", rs1_register);
    printf("rs2_register: %s\n", rs2_register);
    printf("immediate: %s\n", immediate);
    printf("base_register: %s\n", base_register);
}

int main() {
    char keyword[MAX_KEYWORD_LENGTH];
    char rd_register[3];
    char rs1_register[3];
    char rs2_register[3];
    char immediate[12];
    char base_register[3];

    printf("Enter instruction keyword: ");
    scanf("%s", keyword);
    printf("Enter rd register: ");
    scanf("%s", rd_register);
    printf("Enter rs1 register: ");
    scanf("%s", rs1_register);
    printf("Enter rs2 register: ");
    scanf("%s", rs2_register);
    printf("Enter immediate value: ");
    scanf("%s", immediate);
    printf("Enter base register: ");
    scanf("%s", base_register);

    encodeInstruction(keyword, rd_register, rs1_register, rs2_register, immediate, base_register);

    return 0;
}
