    .data
save:   .word 0,1,2,3,4,5,6,7 
    .text
main:
    # i in 
    la $s6, save
Loop: 
    sll $t1, $s3, 2 
    add $t1, $t1, $s6 
    lw $t0, 0($t1) 
    bne $t0, $s5, Exit
    addi $s3, $s3, 1 
    j Loop 

Exit:
li $v0, 1 
add $a0, $s3, $zero 
syscall 





