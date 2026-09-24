addi $t0, $0, 47
sw $t0, 50($0)
addi $t1, $0, 13
sw $t1, 51($0)
lw $v0, 50($0)
lw $v1, 51($0)
mult $v0, $v1
mflo $t0
mfhi $t1
sw $v0, 60($0)
sw $v1, 61($0)