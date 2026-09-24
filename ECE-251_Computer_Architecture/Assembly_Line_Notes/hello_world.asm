# MIPS Assembly Code
# Ensure this is placed in a .text segment

    .text           # Indicates the start of the code segment
    .globl main     # Declare the main function as global

main:
    # Instruction 1: Add Immediate
    # Add the value in register $s6 with the immediate value 4 and store the result in $t0
    addi $t0, $s6, 4   # $t0 = $s6 + 4

    # Instruction 2: Add
    # Add the value in register $s6 with the value in register $0 (which is always 0) and store the result in $t1
    add $t1, $s6, $0   # $t1 = $s6 + 0 (essentially $t1 = $s6)

    # Instruction 3: Store Word
    # Store the value in register $t1 into the memory location pointed to by the address in $t0 (with an offset of 0)
    sw $t1, 0($t0)     # Memory[$t0 + 0] = $t1

    # Instruction 4: Load Word
    # Load the value from the memory location pointed to by the address in $t0 (with an offset of 0) into register $t0
    lw $t0, 0($t0)     # $t0 = Memory[$t0 + 0]

    # Instruction 5: Add
    # Add the values in registers $t1 and $t0 and store the result in $s0
    add $s0, $t1, $t0  # $s0 = $t1 + $t0

    # Exit the program (if running in a simulator like SPIM or MARS)
    li $v0, 10         # Load the syscall code for exit (10)
    syscall            # Perform the syscall to exit