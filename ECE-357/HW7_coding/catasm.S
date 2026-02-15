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

    .comm buf,4096,4        # reserve 4096 bytes in BSS; address is 'buf'

    .text
    .global _start
_start:

read_and_write:
    # read(0,buf,4096)
    mov $0, %rax            # Put 0 in rax, rax holds the syscall number
    mov $0, %rdi            # rdi is first syscall argument, 0 (stdin) is for file descriptor
    lea buf(%rip), %rsi     # Loads buf to rsi, rsi is second syscall argument for buffer
    mov $4096, %rdx         # third argument is number of bytes to read, 4096 
    syscall                 # performs the equivalent of read(0,buf,4096)

    # save number of bytes read
    mov %rax, %rbx          

    # if (n <= 0) goto exit
    cmp $0, %rbx          
    jle exit               
    # write(1,buf,n)
    mov $1, %rax           # Put 1 in rax, means write 
    mov $1, %rdi           # Put 1 in rdi, file descriptor 1 is stdout 
    lea buf(%rip), %rsi    
    mov %rbx, %rdx         
    syscall                

    jmp read_and_write    

exit:
    mov $60, %rax           
    mov %rbx, %rdi  
    syscall                  
