    .globl main
main:
    # Set up arguments for sum_of_squares
    li $a0, 3      # First argument: 3
    li $a1, 4      # Second argument: 4

    # Call the sum_of_squares procedure
    jal sum_of_squares

    # Print the result (optional, requires syscall)
    move $a0, $v0  # Move result to $a0
    li $v0, 1      # System call code for print integer
    syscall

    # Exit the program
    li $v0, 10     # System call code for exit
    syscall

    .globl sum_of_squares
sum_of_squares:
    # Prologue (save $ra)
    addi $sp, $sp, -4  # Make space on the stack
    sw $ra, 0($sp)     # Save return address

    # Calculate square of the first argument
    move $a0, $a0     # Move first argument to $a0 for square
    jal square
    move $t0, $v0     # Store the result in $t0

    # Calculate square of the second argument
    move $a0, $a1     # Move second argument to $a0 for square
    jal square
    add $t0, $t0, $v0 # Add the squares

    # Epilogue (restore $ra)
    move $v0, $t0     # Store the sum of squares in $v0
    lw $ra, 0($sp)     # Restore return address
    addi $sp, $sp, 4  # Deallocate stack space
    jr $ra             # Return

    .globl square
square:
    # Calculate square
    mul $v0, $a0, $a0 # $v0 = $a0 * $a0
    jr $ra             # Return