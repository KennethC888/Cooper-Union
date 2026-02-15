    .text
    .globl add_two_numbers

add_two_numbers:
    # Procedure Prologue (not needed for a simple leaf procedure)

    # Procedure Body
    add $v0, $a0, $a1  # $v0 = $a0 + $a1

    # Procedure Epilogue
    jr $ra              # Return to the caller
    
    # Syscall is a procedure call 