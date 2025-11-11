.text
.global col_update


col_update:
    #int col_update(colinfo_t *info); 
    # rdi = &info
# Reading from Struct
    movl 0(%rdi), %r8d # r8d =  info->cur
    movl 4(%rdi), %r9d # r9d = info->step

    cmpl $0, %r8d 	# if (cur <= 0)
    jle .ERROR

    incl %r9d  # step++
    cqto       # prepare for division
    movl %r8d, %eax # eax=numerator
    movl $2, $ecx   # ecx=denominator
    idivl %ecx    # cur / 2

    # remainder = edx
    cmpl $1, %edx
    jne .EVEN
    imull $3, %r8d  #cur = cur*3
    incl %r8d # cur = cur*3+1;
    jmp .DONE

.EVEN:
    sarl $1, %r8d #cur = cur / 2

.DONE:
    # Writing back to Struct
     movl %r8d, 0(%rdi) #info->cur=cur 
     movl %r9d, 4(%rdi) #info->step=step
     movl $0, %eax  # set return value to 0
     ret  

.ERROR:
    movl $1, %eax  # set return value to 1
    ret  
