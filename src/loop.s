.text
.global loop

loop:
movl $100, %rax        # rax = sum
movl $0, %ecx          # exc = i =0
loop_start:
    decl %rax              # decrement sum  
    incl %ecx              # increment ECX i
    cmpl $5, %ecx          # is (ecx == 5)?
    jne loop_start         # jump if ECX != 5
