.text
.global col_check

col_check:
    # rdi = info
    # int col_check(colinfo_t info);
    # reading info.cur
    movq %rdi, %rax   # no shifting needed
    andq $0xFFFFFFFF, %rax # rax = info.cur

    # reading info.step
    movq %rdi, %rcx
    sarq $32, %rcx   # shifting right
    andq $0xFFFFFFFF, %rcx # rcx =info.step

    movl $0, %edx  # edx = errs

    cmpl $0, %eax
    jg .STEP1
    orl $0b0001, %edx   // or’ing
    
.STEP1: 
    cmpl $0, %ecx
    jge .STEP2
    orl $0b0010, %edx

.STEP2:
   cmpl $1, %eax
   jne .DONE
   cmpl $0, %ecx
   jge .DONE
   orl $0b0100, %edx 

.DONE:
    movl %edx, %eax
    ret
