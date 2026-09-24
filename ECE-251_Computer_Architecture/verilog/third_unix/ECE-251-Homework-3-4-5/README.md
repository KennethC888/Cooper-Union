# ECE 251 Homework 3,4,5

 ### Question 1: <br />
addi $s2, $s2, -5 <br />
add $s0, $s1, $s2

### Question 2: <br />
f = A[0] + A[0];

### Question 3 (opcode, rs, rt, rd, funct, imm in decimal): <br />
x means that it does not apply

| MIPS code         | Type and instruction | opcode | rs  | rt  | rd  | funct | imm | Hex equivalent |
| ----------------- | ----                 | ------ | --- | --- | --- | ----- | --- | -------------- |
| addi $t0, $s6, 4  | I and addi           | 8      | 22  | 8   | x   | x     | 4   | 22C80004       |
| add $t1, $s6, $0  | R and add            | 0      | 22  | 0   | 9   | 32    | x   | 02C04820       |
| sw $t1, 0($t0)    | I and sw             | 43     | 8   | 9   | x   | x     | 0   | AD090000       |
| lw $t0, 0($t0)    | I and lw             | 35     | 8   | 8   | x   | x     | 0   | 8D080000       |
| add $s0, $t1, $t0 | R and add            | 0      | 9   | 8   | 16  | 32    | x   | 01288020       |

### Question 4: <br />
op=0x23, rs=1, rt=2, const=0x4 <br />
Type: I <br />
Assembly Language Instruction: lw $v0, 4($at) <br />
Binary Representation: 10001100001000100000000000000100

### Question 5: <br />
Given PC = 20000000 <br />
Lower bound: (PC + 4 - (4 * offset)) <br />
Upper bound: (PC + 4 + (4 *offset)) <br />
a) Ranges from 20000000 to 2FFFFFFC <br />
b) Ranges from 1FFE0004 to 20020000


