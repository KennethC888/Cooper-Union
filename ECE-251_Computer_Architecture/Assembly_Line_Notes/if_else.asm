.data

.text
.globl main 

main: 

# Assume $t0 holds the value of x
    li $t0, 10 
    li $t1, 5                   # Load 5 into $t1
    
    
    loop_start:
    slt $t2, $t1, $t0         # $t2 = 1 if $t1 < $t0 (x > 5), 0 otherwise
    beq $t2, $zero , end_if  # Branch to else if $t2 is 0 (x <= 5)
    addi $t0, $t0, -1 
    j loop_start
                                # Then part (x > 5)
    # ... code for then part ...
   # j end_if                    # Jump to the end of the if-then-else

    # decrement t0 
                                # Else part (x <= 5)
    # ... code for else part ...

end_if:
                                # Continue with the rest of the program