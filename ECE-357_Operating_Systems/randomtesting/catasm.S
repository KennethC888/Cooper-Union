// To compile: 
// as --64 -o catasm.o catasm.S 
// ld -m elf_x86_64 -o catasm catasm.o

// Copy paste to turn into VM: scp -r ~/ECE-357/HW7_coding kenneth.chan@ece357.cooper.edu:~/hwsub/ps7p2

// To test code:
// ./catasm < test.txt
// strace ./catasm < test.txt

// while ((n=read(0,buf,4096)>0)
// write(1,buf,n);
// _exit(n) 
// want to write this in assembly

// 0 is read, 1 is write. 60 is exit 

.comom buf, 4096, 4

    .data
    .text
    .global _start

_start:
read_and_write:
    # read(0,buf,4096)
    mov $0, rax  # Read 
    mov $0, rdi # stdin 
    lea bu(%rip), rsi # move buffer to rsi 
    mov $4096, rdx # size of buffer 
    syscall 

    mov rax, rbx 

    # WRITING TIME 
    mov $1, rax # Write
    mov $1, rdi # stdout
    lea buf(%rip), rsi # move buffer to rsi
    mov $4096, rdx # size of buffer
    syscall

    cmp $0 rax 
    jle exit 
    jmp read_and_write

    exit: 
    mov $60, rax # Exit
    mov $0, rdi # Exit code 0
    syscall
    








