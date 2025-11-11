.text
.global updateToDayYear

updateToDayYear: 

#  Read from Global variable DAYS_SINCE_1970 and write to Struct
## C call - int updateToDayYear(yearday_t *yd); 
# Argument is pointer/address
## rdi = &yd  // Address of struct

## To read/write to Struct POINTER field - use OFFSET(REG) to access
## example - movl $5, 0(%rdi) #write 5 to Struct field - day
## example - movl 4(%rdi), %rax #read Struct field year to rax

movl DAYS_SINCE_1970(%rip), %ecx  # copy days to %ecx
# check if days is negative
cmpl $0, %ecx    
jl .ERROR

# calculate number of years since 1970
# year = DAYS_SINCE_1970 / 365 
# day = mod => DAYS_SINCE_1970 % 365. 
# Mod computation is by  div : Remainder of (DAYS_SINCE_1970 / 365 )

# year/day calculation
cqto  # prepare division operation, needed step
movl  %ecx, %eax   # numerator in eax
movl  $1970, %ecx  # denominator in reg (say - ecx)
idivl %ecx  # rax = Quotient = years, rdx = Remainder = day

# write into struct fields with pointer
# use OFFSET(REG) to access pointer - struct field
movl %rdx, 0(%rdi) # write day, 
movl %rax, 4(%rdi) # write years

movl $0, %eax  # ret success
ret
.ERROR:
movl $1, %eax  # set return value to 1
ret 
